import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mockito/mockito.dart';
import 'package:refreshi_checkout/core/usecase/usecase.dart';
import 'package:refreshi_checkout/features/checkout/domain/usecases/load_checkout_draft.dart';
import 'package:refreshi_checkout/features/checkout/domain/usecases/save_checkout_draft.dart';
import 'package:refreshi_checkout/features/checkout/domain/usecases/start_new_checkout.dart';

import '../../../../helpers/dummies.dart';
import '../../../../helpers/fixtures.dart';
import '../../../../helpers/mocks.mocks.dart';

void main() {
  late MockCheckoutRepository repository;

  setUpAll(registerDummies);
  setUp(() => repository = MockCheckoutRepository());

  test('LoadCheckoutDraft delegates', () async {
    when(repository.loadDraft()).thenAnswer((_) async => right(Fixtures.emptyDraft));
    expect(await LoadCheckoutDraft(repository)(const NoParams()), right(Fixtures.emptyDraft));
  });

  test('SaveCheckoutDraft delegates', () async {
    when(repository.saveDraft(any)).thenAnswer((_) async => right(unit));
    expect(await SaveCheckoutDraft(repository)(Fixtures.completeDraft), right(unit));
    verify(repository.saveDraft(Fixtures.completeDraft));
  });

  test('StartNewCheckout delegates', () async {
    when(repository.startNewDraft()).thenAnswer((_) async => right(Fixtures.emptyDraft));
    expect(await StartNewCheckout(repository)(const NoParams()), right(Fixtures.emptyDraft));
  });
}
