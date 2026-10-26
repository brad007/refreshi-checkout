import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mockito/mockito.dart';
import 'package:refreshi_checkout/core/error/exceptions.dart';
import 'package:refreshi_checkout/core/error/failures.dart';
import 'package:refreshi_checkout/features/checkout/data/models/checkout_draft_model.dart';
import 'package:refreshi_checkout/features/checkout/data/repositories/checkout_repository_impl.dart';
import 'package:refreshi_checkout/features/checkout/domain/entities/checkout_draft.dart';

import '../../../../helpers/fixtures.dart';
import '../../../../helpers/mocks.mocks.dart';

void main() {
  late MockCheckoutLocalDataSource local;
  late MockIdGenerator ids;
  late CheckoutRepositoryImpl repository;

  setUp(() {
    local = MockCheckoutLocalDataSource();
    ids = MockIdGenerator();
    when(ids()).thenReturn('new-key');
    repository = CheckoutRepositoryImpl(local, ids);
  });

  test('loadDraft returns the saved draft', () async {
    when(local.getDraft()).thenReturn(CheckoutDraftModel.fromEntity(Fixtures.completeDraft));
    expect(await repository.loadDraft(), right(Fixtures.completeDraft));
    verifyNever(local.saveDraft(any));
  });

  test('loadDraft starts and saves a new draft when there is none', () async {
    when(local.getDraft()).thenReturn(null);
    expect(await repository.loadDraft(), right(const CheckoutDraft(idempotencyKey: 'new-key')));
    verify(local.saveDraft(const CheckoutDraftModel(idempotencyKey: 'new-key')));
  });

  test('startNewDraft always uses a fresh key', () async {
    expect(await repository.startNewDraft(), right(const CheckoutDraft(idempotencyKey: 'new-key')));
    verify(ids()).called(1);
  });

  test('startNewDraft reports a failed save', () async {
    when(local.saveDraft(any)).thenThrow(const CacheException());
    expect(await repository.startNewDraft(), left(const Failure.cache()));
  });

  test('saveDraft persists the model', () async {
    expect(await repository.saveDraft(Fixtures.completeDraft), right(unit));
    verify(local.saveDraft(CheckoutDraftModel.fromEntity(Fixtures.completeDraft)));
  });

  test('saveDraft maps failures', () async {
    when(local.saveDraft(any)).thenThrow(const CacheException());
    expect(await repository.saveDraft(Fixtures.completeDraft), left(const Failure.cache()));
  });
}
