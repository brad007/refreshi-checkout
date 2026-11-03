import 'package:fpdart/fpdart.dart';
import 'package:mockito/mockito.dart';
import 'package:refreshi_checkout/domain/core/failures.dart';
import 'package:refreshi_checkout/domain/auth/user_session.dart';
import 'package:refreshi_checkout/domain/catalog/checkout_catalog.dart';
import 'package:refreshi_checkout/domain/checkout/checkout_draft.dart';
import 'package:refreshi_checkout/domain/orders/order.dart';
import 'package:refreshi_checkout/domain/orders/order_placement.dart';

import 'fixtures.dart';

/// Mockito can't invent values for generic `Either` return types; register
/// one per type so nice mocks can return something when not stubbed.
void registerDummies() {
  const failure = Failure.server();
  provideDummy<Either<Failure, Unit>>(left(failure));
  provideDummy<Either<Failure, UserSession>>(left(failure));
  provideDummy<Either<Failure, Option<UserSession>>>(left(failure));
  provideDummy<Either<Failure, CheckoutCatalog>>(left(failure));
  provideDummy<Either<Failure, CheckoutDraft>>(left(failure));
  provideDummy<Either<Failure, OrderPlacement>>(left(failure));
  provideDummy<Either<Failure, CustomerOrder>>(left(failure));
  provideDummy<CheckoutDraft>(Fixtures.emptyDraft);
}
