import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fpdart/fpdart.dart' show Left, Right;
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../../../catalog/domain/entities/checkout_catalog.dart';
import '../../../orders/domain/entities/order_placement.dart';
import '../../domain/entities/checkout_draft.dart';
import '../../domain/usecases/load_checkout_draft.dart';
import '../../domain/usecases/save_checkout_draft.dart';
import '../../domain/usecases/start_new_checkout.dart';
import '../../domain/usecases/submit_checkout.dart';

part 'checkout_bloc.freezed.dart';
part 'checkout_event.dart';
part 'checkout_state.dart';

/// Owns the checkout draft and the order submission.
///
/// Duplicate protection is layered:
/// * `droppable()` drops any submit event that arrives while one is running,
///   so a double click is a no-op here. The button is also disabled.
/// * Edits are ignored while submitting, so the request can't change underneath.
/// * The draft's idempotency key makes retries (including after a reload) safe
///   on the backend.
@lazySingleton
class CheckoutBloc extends Bloc<CheckoutEvent, CheckoutState> {
  CheckoutBloc(this._loadDraft, this._saveDraft, this._startNewCheckout, this._submitCheckout)
    : super(const CheckoutState()) {
    on<CheckoutStarted>(_onStarted, transformer: droppable());
    on<CheckoutServiceToggled>(_onServiceToggled, transformer: sequential());
    on<CheckoutSlotSelected>(_onSlotSelected, transformer: sequential());
    on<CheckoutPaymentMethodSelected>(_onPaymentMethodSelected, transformer: sequential());
    on<CheckoutCatalogAvailable>(_onCatalogAvailable, transformer: sequential());
    on<CheckoutSubmitted>(_onSubmitted, transformer: droppable());
    on<CheckoutNewCheckoutRequested>(_onNewCheckoutRequested, transformer: droppable());
    on<CheckoutPlacementHandled>(_onPlacementHandled);
    on<CheckoutRetryRequested>(_onRetryRequested, transformer: droppable());
  }

  final LoadCheckoutDraft _loadDraft;
  final SaveCheckoutDraft _saveDraft;
  final StartNewCheckout _startNewCheckout;
  final SubmitCheckout _submitCheckout;

  Future<void> _onStarted(CheckoutStarted event, Emitter<CheckoutState> emit) async {
    if (state.draft != null) return;
    final result = await _loadDraft(const NoParams());
    await result.match((failure) async => emit(state.copyWith(status: CheckoutStatus.failure, failure: failure)), (
      draft,
    ) async {
      emit(CheckoutState(status: CheckoutStatus.ready, draft: draft));
      // The page was reloaded while an order request was in flight. We
      // can't know whether it reached the backend, so send it again with
      // the same key: the backend either creates it or replays the original.
      if (draft.submissionInFlight) await _submit(emit, resumed: true);
    });
  }

  Future<void> _onServiceToggled(CheckoutServiceToggled event, Emitter<CheckoutState> emit) =>
      _updateDraft(emit, (draft) => draft.toggleService(event.serviceId));

  Future<void> _onSlotSelected(CheckoutSlotSelected event, Emitter<CheckoutState> emit) =>
      _updateDraft(emit, (draft) => draft.copyWith(slotId: event.slotId));

  Future<void> _onPaymentMethodSelected(CheckoutPaymentMethodSelected event, Emitter<CheckoutState> emit) =>
      _updateDraft(emit, (draft) => draft.copyWith(paymentMethodId: event.paymentMethodId));

  Future<void> _onCatalogAvailable(CheckoutCatalogAvailable event, Emitter<CheckoutState> emit) =>
      _updateDraft(emit, (draft) {
        final catalog = event.catalog;
        return draft.copyWith(
          serviceIds: draft.serviceIds.where((id) => catalog.serviceById(id) != null).toList(),
          slotId: catalog.slotById(draft.slotId)?.id,
          paymentMethodId: catalog.paymentMethodById(draft.paymentMethodId)?.id,
        );
      });

  Future<void> _onSubmitted(CheckoutSubmitted event, Emitter<CheckoutState> emit) async {
    if (!state.canSubmit) return;
    await _submit(emit, resumed: false);
  }

  Future<void> _onNewCheckoutRequested(CheckoutNewCheckoutRequested event, Emitter<CheckoutState> emit) async {
    if (state.isSubmitting) return;
    final result = await _startNewCheckout(const NoParams());
    result.match(
      (failure) => emit(state.copyWith(status: CheckoutStatus.failure, failure: failure)),
      (draft) => emit(CheckoutState(status: CheckoutStatus.ready, draft: draft)),
    );
  }

  Future<void> _onRetryRequested(CheckoutRetryRequested event, Emitter<CheckoutState> emit) async {
    if (state.isSubmitting) return;
    final result = await _startNewCheckout(const NoParams());
    switch (result) {
      case Left(value: final failure):
        emit(state.copyWith(status: CheckoutStatus.failure, failure: failure));
      case Right(value: final fresh):
        final draft = fresh.copyWith(
          serviceIds: event.serviceIds.take(CheckoutDraft.maxServices).toList(),
          slotId: event.slotId,
        );
        emit(CheckoutState(status: CheckoutStatus.ready, draft: draft));
        final saved = await _saveDraft(draft);
        if (saved case Left(value: final failure)) emit(state.copyWith(failure: failure));
    }
  }

  void _onPlacementHandled(CheckoutPlacementHandled event, Emitter<CheckoutState> emit) {
    if (state.placement == null) return;
    emit(state.copyWith(status: CheckoutStatus.ready, placement: null, resumed: false));
  }

  Future<void> _submit(Emitter<CheckoutState> emit, {required bool resumed}) async {
    final draft = state.draft;
    if (draft == null) return;
    emit(state.copyWith(status: CheckoutStatus.submitting, failure: null, resumed: resumed));

    final result = await _submitCheckout(draft);
    await result.match(
      (failure) async => emit(
        state.copyWith(
          status: CheckoutStatus.failure,
          failure: failure,
          draft: draft.copyWith(submissionInFlight: false),
        ),
      ),
      (placement) async {
        // SubmitCheckout rotated the stored draft; pick up the fresh one.
        final next = await _loadDraft(const NoParams());
        emit(
          CheckoutState(
            status: CheckoutStatus.success,
            draft: next.toNullable(),
            placement: placement,
            resumed: resumed,
          ),
        );
      },
    );
  }

  Future<void> _updateDraft(Emitter<CheckoutState> emit, CheckoutDraft Function(CheckoutDraft draft) update) async {
    final draft = state.draft;
    if (draft == null || state.isSubmitting) return;
    final next = update(draft);
    if (next == draft) return;
    // A conflict sticks: edits can't make a spent key usable again.
    emit(
      state.copyWith(
        draft: next,
        status: CheckoutStatus.ready,
        failure: state.isSpent ? state.failure : null,
        placement: null,
      ),
    );
    final saved = await _saveDraft(next);
    saved.match((failure) => emit(state.copyWith(failure: failure)), (_) {});
  }
}
