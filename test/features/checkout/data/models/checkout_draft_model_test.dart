import 'package:flutter_test/flutter_test.dart';
import 'package:refreshi_checkout/features/checkout/data/models/checkout_draft_model.dart';

import '../../../../helpers/fixtures.dart';

void main() {
  test('round-trips through the entity and JSON', () {
    final draft = Fixtures.completeDraft.copyWith(submissionInFlight: true);
    final model = CheckoutDraftModel.fromEntity(draft);
    expect(model.toEntity(), draft);
    expect(CheckoutDraftModel.fromJson(model.toJson()), model);
  });

  test('older saved drafts without optional fields still load', () {
    final model = CheckoutDraftModel.fromJson({'idempotencyKey': 'k'});
    expect(model.serviceIds, isEmpty);
    expect(model.submissionInFlight, isFalse);
  });
}
