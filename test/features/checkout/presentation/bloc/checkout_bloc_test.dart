import 'dart:async';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mockito/mockito.dart';
import 'package:refreshi_checkout/core/error/failures.dart';
import 'package:refreshi_checkout/features/checkout/domain/entities/checkout_draft.dart';
import 'package:refreshi_checkout/features/checkout/presentation/bloc/checkout_bloc.dart';
import 'package:refreshi_checkout/features/orders/domain/entities/order_placement.dart';

import '../../../../helpers/dummies.dart';
import '../../../../helpers/fixtures.dart';
import '../../../../helpers/mocks.mocks.dart';

void main() {
  late MockLoadCheckoutDraft loadDraft;
  late MockSaveCheckoutDraft saveDraft;
  late MockStartNewCheckout startNewCheckout;
  late MockSubmitCheckout submitCheckout;

  const nextDraft = CheckoutDraft(idempotencyKey: 'key-2');

  setUpAll(registerDummies);

  setUp(() {
    loadDraft = MockLoadCheckoutDraft();
    saveDraft = MockSaveCheckoutDraft();
    startNewCheckout = MockStartNewCheckout();
    submitCheckout = MockSubmitCheckout();
    when(saveDraft(any)).thenAnswer((_) async => right(unit));
  });

  CheckoutBloc build() => CheckoutBloc(loadDraft, saveDraft, startNewCheckout, submitCheckout);

  CheckoutState ready(CheckoutDraft draft) => CheckoutState(status: CheckoutStatus.ready, draft: draft);

  group('started', () {
    blocTest<CheckoutBloc, CheckoutState>(
      'loads the saved draft',
      setUp: () => when(loadDraft(any)).thenAnswer((_) async => right(Fixtures.completeDraft)),
      build: build,
      act: (bloc) => bloc.add(const CheckoutEvent.started()),
      expect: () => [ready(Fixtures.completeDraft)],
    );

    blocTest<CheckoutBloc, CheckoutState>(
      'reports a failure to load',
      setUp: () => when(loadDraft(any)).thenAnswer((_) async => left(const Failure.cache())),
      build: build,
      act: (bloc) => bloc.add(const CheckoutEvent.started()),
      expect: () => [const CheckoutState(status: CheckoutStatus.failure, failure: Failure.cache())],
    );

    blocTest<CheckoutBloc, CheckoutState>(
      'is a no-op once a draft is loaded',
      build: build,
      seed: () => ready(Fixtures.emptyDraft),
      act: (bloc) => bloc.add(const CheckoutEvent.started()),
      expect: () => <CheckoutState>[],
      verify: (_) => verifyNever(loadDraft(any)),
    );

    blocTest<CheckoutBloc, CheckoutState>(
      'resubmits automatically when the page reloaded mid-submission',
      setUp: () {
        final inFlight = Fixtures.completeDraft.copyWith(submissionInFlight: true);
        var loads = 0;
        when(loadDraft(any)).thenAnswer((_) async => right(loads++ == 0 ? inFlight : nextDraft));
        when(submitCheckout(any)).thenAnswer((_) async => right(Fixtures.placement(replayed: true)));
      },
      build: build,
      act: (bloc) => bloc.add(const CheckoutEvent.started()),
      expect: () {
        final inFlight = Fixtures.completeDraft.copyWith(submissionInFlight: true);
        return [
          ready(inFlight),
          CheckoutState(status: CheckoutStatus.submitting, draft: inFlight, resumed: true),
          CheckoutState(
            status: CheckoutStatus.success,
            draft: nextDraft,
            placement: Fixtures.placement(replayed: true),
            resumed: true,
          ),
        ];
      },
      verify: (_) => verify(submitCheckout(Fixtures.completeDraft.copyWith(submissionInFlight: true))).called(1),
    );
  });

  group('editing', () {
    blocTest<CheckoutBloc, CheckoutState>(
      'toggling a service updates and saves the draft',
      build: build,
      seed: () => ready(Fixtures.emptyDraft),
      act: (bloc) => bloc.add(const CheckoutEvent.serviceToggled('bag_grocer')),
      expect: () => [
        ready(Fixtures.emptyDraft.copyWith(serviceIds: ['bag_grocer'])),
      ],
      verify: (_) => verify(saveDraft(Fixtures.emptyDraft.copyWith(serviceIds: ['bag_grocer']))),
    );

    blocTest<CheckoutBloc, CheckoutState>(
      'selecting a slot and a payment method updates the draft',
      build: build,
      seed: () => ready(Fixtures.emptyDraft),
      act: (bloc) => bloc
        ..add(const CheckoutEvent.slotSelected('slot_1'))
        ..add(const CheckoutEvent.paymentMethodSelected('8ac7a4a28a5f1e3c018a6b2e0d7f4a01')),
      expect: () => [
        ready(Fixtures.emptyDraft.copyWith(slotId: 'slot_1')),
        ready(Fixtures.emptyDraft.copyWith(slotId: 'slot_1', paymentMethodId: '8ac7a4a28a5f1e3c018a6b2e0d7f4a01')),
      ],
    );

    blocTest<CheckoutBloc, CheckoutState>(
      'a no-op change emits and saves nothing',
      build: build,
      seed: () => ready(Fixtures.completeDraft),
      act: (bloc) => bloc.add(CheckoutEvent.slotSelected(Fixtures.completeDraft.slotId!)),
      expect: () => <CheckoutState>[],
      verify: (_) => verifyNever(saveDraft(any)),
    );

    blocTest<CheckoutBloc, CheckoutState>(
      'edits are ignored before the draft has loaded',
      build: build,
      act: (bloc) => bloc.add(const CheckoutEvent.serviceToggled('bag_grocer')),
      expect: () => <CheckoutState>[],
    );

    blocTest<CheckoutBloc, CheckoutState>(
      'edits are ignored while submitting, so the order can\'t change mid-request',
      build: build,
      seed: () => CheckoutState(status: CheckoutStatus.submitting, draft: Fixtures.completeDraft),
      act: (bloc) => bloc.add(const CheckoutEvent.serviceToggled('bag_grocer')),
      expect: () => <CheckoutState>[],
      verify: (_) => verifyNever(saveDraft(any)),
    );

    blocTest<CheckoutBloc, CheckoutState>(
      'editing clears a previous failure',
      build: build,
      seed: () => CheckoutState(
        status: CheckoutStatus.failure,
        draft: Fixtures.completeDraft,
        failure: const Failure.network(),
      ),
      act: (bloc) => bloc.add(const CheckoutEvent.paymentMethodSelected('8ac7a4a28a5f1e3c018a6b2e0d7f4b07')),
      expect: () => [ready(Fixtures.completeDraft.copyWith(paymentMethodId: '8ac7a4a28a5f1e3c018a6b2e0d7f4b07'))],
    );

    blocTest<CheckoutBloc, CheckoutState>(
      'a failed save is surfaced',
      setUp: () => when(saveDraft(any)).thenAnswer((_) async => left(const Failure.cache())),
      build: build,
      seed: () => ready(Fixtures.emptyDraft),
      act: (bloc) => bloc.add(const CheckoutEvent.serviceToggled('bag_grocer')),
      expect: () => [
        ready(Fixtures.emptyDraft.copyWith(serviceIds: ['bag_grocer'])),
        ready(Fixtures.emptyDraft.copyWith(serviceIds: ['bag_grocer'])).copyWith(failure: const Failure.cache()),
      ],
    );

    blocTest<CheckoutBloc, CheckoutState>(
      'catalogAvailable drops selections that are no longer offered',
      build: build,
      seed: () => ready(
        Fixtures.completeDraft.copyWith(
          serviceIds: ['bag_bakery', 'svc_retired'],
          slotId: 'slot_expired',
          paymentMethodId: 'pm_removed',
        ),
      ),
      act: (bloc) => bloc.add(CheckoutEvent.catalogAvailable(Fixtures.catalog)),
      expect: () => [
        ready(Fixtures.completeDraft.copyWith(serviceIds: ['bag_bakery'], slotId: null, paymentMethodId: null)),
      ],
    );

    blocTest<CheckoutBloc, CheckoutState>(
      'catalogAvailable keeps valid selections untouched',
      build: build,
      seed: () => ready(Fixtures.completeDraft),
      act: (bloc) => bloc.add(CheckoutEvent.catalogAvailable(Fixtures.catalog)),
      expect: () => <CheckoutState>[],
    );
  });

  group('submitted', () {
    blocTest<CheckoutBloc, CheckoutState>(
      'places the order and moves to a fresh draft',
      setUp: () {
        when(submitCheckout(any)).thenAnswer((_) async => right(Fixtures.placement()));
        when(loadDraft(any)).thenAnswer((_) async => right(nextDraft));
      },
      build: build,
      seed: () => ready(Fixtures.completeDraft),
      act: (bloc) => bloc.add(const CheckoutEvent.submitted()),
      expect: () => [
        CheckoutState(status: CheckoutStatus.submitting, draft: Fixtures.completeDraft),
        CheckoutState(status: CheckoutStatus.success, draft: nextDraft, placement: Fixtures.placement()),
      ],
    );

    blocTest<CheckoutBloc, CheckoutState>(
      'a double click submits exactly once',
      setUp: () {
        final gate = Completer<Either<Failure, OrderPlacement>>();
        when(submitCheckout(any)).thenAnswer((_) => gate.future);
        when(loadDraft(any)).thenAnswer((_) async => right(nextDraft));
        Future<void>.delayed(const Duration(milliseconds: 10), () => gate.complete(right(Fixtures.placement())));
      },
      build: build,
      seed: () => ready(Fixtures.completeDraft),
      act: (bloc) => bloc
        ..add(const CheckoutEvent.submitted())
        ..add(const CheckoutEvent.submitted())
        ..add(const CheckoutEvent.submitted()),
      wait: const Duration(milliseconds: 50),
      expect: () => [
        CheckoutState(status: CheckoutStatus.submitting, draft: Fixtures.completeDraft),
        CheckoutState(status: CheckoutStatus.success, draft: nextDraft, placement: Fixtures.placement()),
      ],
      verify: (_) => verify(submitCheckout(any)).called(1),
    );

    blocTest<CheckoutBloc, CheckoutState>(
      'reports a failure and stays editable with the same key',
      setUp: () => when(submitCheckout(any)).thenAnswer((_) async => left(const Failure.network())),
      build: build,
      seed: () => ready(Fixtures.completeDraft),
      act: (bloc) => bloc.add(const CheckoutEvent.submitted()),
      expect: () => [
        CheckoutState(status: CheckoutStatus.submitting, draft: Fixtures.completeDraft),
        CheckoutState(status: CheckoutStatus.failure, draft: Fixtures.completeDraft, failure: const Failure.network()),
      ],
    );

    blocTest<CheckoutBloc, CheckoutState>(
      'does nothing for an incomplete draft',
      build: build,
      seed: () => ready(Fixtures.emptyDraft),
      act: (bloc) => bloc.add(const CheckoutEvent.submitted()),
      expect: () => <CheckoutState>[],
      verify: (_) => verifyNever(submitCheckout(any)),
    );
  });

  group('newCheckoutRequested', () {
    blocTest<CheckoutBloc, CheckoutState>(
      'replaces the draft with a fresh one',
      setUp: () => when(startNewCheckout(any)).thenAnswer((_) async => right(nextDraft)),
      build: build,
      seed: () => CheckoutState(
        status: CheckoutStatus.failure,
        draft: Fixtures.completeDraft,
        failure: const Failure.idempotencyConflict(existingOrderId: 'ord_1'),
      ),
      act: (bloc) => bloc.add(const CheckoutEvent.newCheckoutRequested()),
      expect: () => [ready(nextDraft)],
    );

    blocTest<CheckoutBloc, CheckoutState>(
      'reports a failure',
      setUp: () => when(startNewCheckout(any)).thenAnswer((_) async => left(const Failure.cache())),
      build: build,
      seed: () => ready(Fixtures.completeDraft),
      act: (bloc) => bloc.add(const CheckoutEvent.newCheckoutRequested()),
      expect: () => [
        CheckoutState(status: CheckoutStatus.failure, draft: Fixtures.completeDraft, failure: const Failure.cache()),
      ],
    );

    blocTest<CheckoutBloc, CheckoutState>(
      'is ignored while submitting',
      build: build,
      seed: () => CheckoutState(status: CheckoutStatus.submitting, draft: Fixtures.completeDraft),
      act: (bloc) => bloc.add(const CheckoutEvent.newCheckoutRequested()),
      expect: () => <CheckoutState>[],
    );
  });

  group('retryRequested', () {
    blocTest<CheckoutBloc, CheckoutState>(
      'starts a fresh draft (new key) with the failed order\'s bags and window',
      setUp: () => when(startNewCheckout(any)).thenAnswer((_) async => right(nextDraft)),
      build: build,
      act: (bloc) => bloc.add(const CheckoutEvent.retryRequested(serviceIds: ['a', 'b', 'c'], slotId: 'slot_1')),
      expect: () => [
        ready(nextDraft.copyWith(serviceIds: ['a', 'b'], slotId: 'slot_1')),
      ],
      verify: (_) => verify(saveDraft(nextDraft.copyWith(serviceIds: ['a', 'b'], slotId: 'slot_1'))),
    );

    blocTest<CheckoutBloc, CheckoutState>(
      'reports a failure to start the new draft',
      setUp: () => when(startNewCheckout(any)).thenAnswer((_) async => left(const Failure.cache())),
      build: build,
      act: (bloc) => bloc.add(const CheckoutEvent.retryRequested(serviceIds: ['a'])),
      expect: () => [const CheckoutState(status: CheckoutStatus.failure, failure: Failure.cache())],
    );

    blocTest<CheckoutBloc, CheckoutState>(
      'reports a failure to save the new draft',
      setUp: () {
        when(startNewCheckout(any)).thenAnswer((_) async => right(nextDraft));
        when(saveDraft(any)).thenAnswer((_) async => left(const Failure.cache()));
      },
      build: build,
      act: (bloc) => bloc.add(const CheckoutEvent.retryRequested(serviceIds: ['a'])),
      expect: () => [
        ready(nextDraft.copyWith(serviceIds: ['a'])),
        ready(nextDraft.copyWith(serviceIds: ['a'])).copyWith(failure: const Failure.cache()),
      ],
    );

    blocTest<CheckoutBloc, CheckoutState>(
      'is ignored while submitting',
      build: build,
      seed: () => CheckoutState(status: CheckoutStatus.submitting, draft: Fixtures.completeDraft),
      act: (bloc) => bloc.add(const CheckoutEvent.retryRequested(serviceIds: ['a'])),
      expect: () => <CheckoutState>[],
    );
  });

  group('spent checkout', () {
    const conflict = Failure.idempotencyConflict(existingOrderId: 'ord_1');

    test('a conflicted checkout cannot be submitted again', () {
      final state = CheckoutState(status: CheckoutStatus.failure, draft: Fixtures.completeDraft, failure: conflict);
      expect(state.isSpent, isTrue);
      expect(state.canSubmit, isFalse);
    });

    blocTest<CheckoutBloc, CheckoutState>(
      'the conflict survives edits, because the key is still spent',
      build: build,
      seed: () => CheckoutState(status: CheckoutStatus.failure, draft: Fixtures.completeDraft, failure: conflict),
      act: (bloc) => bloc.add(const CheckoutEvent.paymentMethodSelected('other')),
      expect: () => [
        CheckoutState(
          status: CheckoutStatus.ready,
          draft: Fixtures.completeDraft.copyWith(paymentMethodId: 'other'),
          failure: conflict,
        ),
      ],
    );

    blocTest<CheckoutBloc, CheckoutState>(
      'submitting a spent checkout does nothing',
      build: build,
      seed: () => CheckoutState(status: CheckoutStatus.failure, draft: Fixtures.completeDraft, failure: conflict),
      act: (bloc) => bloc.add(const CheckoutEvent.submitted()),
      expect: () => <CheckoutState>[],
      verify: (_) => verifyNever(submitCheckout(any)),
    );
  });

  group('placementHandled', () {
    blocTest<CheckoutBloc, CheckoutState>(
      'clears the placed order so it is only handled once',
      build: build,
      seed: () => CheckoutState(
        status: CheckoutStatus.success,
        draft: nextDraft,
        placement: Fixtures.placement(),
        resumed: true,
      ),
      act: (bloc) => bloc.add(const CheckoutEvent.placementHandled()),
      expect: () => [ready(nextDraft)],
    );

    blocTest<CheckoutBloc, CheckoutState>(
      'is a no-op without a placement',
      build: build,
      seed: () => ready(nextDraft),
      act: (bloc) => bloc.add(const CheckoutEvent.placementHandled()),
      expect: () => <CheckoutState>[],
    );
  });

  test('canSubmit requires a complete draft and no submission in progress', () {
    expect(ready(Fixtures.completeDraft).canSubmit, isTrue);
    expect(ready(Fixtures.emptyDraft).canSubmit, isFalse);
    expect(const CheckoutState().canSubmit, isFalse);
    expect(CheckoutState(status: CheckoutStatus.submitting, draft: Fixtures.completeDraft).canSubmit, isFalse);
  });
}
