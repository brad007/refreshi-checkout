// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes

import 'package:auto_route/auto_route.dart' as _i5;
import 'package:flutter/material.dart' as _i6;
import 'package:refreshi_checkout/features/auth/presentation/pages/sign_in_page.dart'
    as _i4;
import 'package:refreshi_checkout/features/catalog/presentation/pages/catalog_page.dart'
    as _i1;
import 'package:refreshi_checkout/features/checkout/presentation/pages/checkout_page.dart'
    as _i2;
import 'package:refreshi_checkout/features/orders/presentation/pages/order_details_page.dart'
    as _i3;

/// generated route for
/// [_i1.CatalogPage]
class CatalogRoute extends _i5.PageRouteInfo<void> {
  const CatalogRoute({List<_i5.PageRouteInfo>? children})
    : super(CatalogRoute.name, initialChildren: children);

  static const String name = 'CatalogRoute';

  static _i5.PageInfo page = _i5.PageInfo(
    name,
    builder: (data) {
      return const _i1.CatalogPage();
    },
  );
}

/// generated route for
/// [_i2.CheckoutPage]
class CheckoutRoute extends _i5.PageRouteInfo<void> {
  const CheckoutRoute({List<_i5.PageRouteInfo>? children})
    : super(CheckoutRoute.name, initialChildren: children);

  static const String name = 'CheckoutRoute';

  static _i5.PageInfo page = _i5.PageInfo(
    name,
    builder: (data) {
      return const _i2.CheckoutPage();
    },
  );
}

/// generated route for
/// [_i3.OrderDetailsPage]
class OrderDetailsRoute extends _i5.PageRouteInfo<OrderDetailsRouteArgs> {
  OrderDetailsRoute({
    _i6.Key? key,
    required String orderId,
    List<_i5.PageRouteInfo>? children,
  }) : super(
         OrderDetailsRoute.name,
         args: OrderDetailsRouteArgs(key: key, orderId: orderId),
         rawPathParams: {'orderId': orderId},
         initialChildren: children,
       );

  static const String name = 'OrderDetailsRoute';

  static _i5.PageInfo page = _i5.PageInfo(
    name,
    builder: (data) {
      final pathParams = data.inheritedPathParams;
      final args = data.argsAs<OrderDetailsRouteArgs>(
        orElse: () =>
            OrderDetailsRouteArgs(orderId: pathParams.getString('orderId')),
      );
      return _i5.WrappedRoute(
        child: _i3.OrderDetailsPage(key: args.key, orderId: args.orderId),
      );
    },
  );
}

class OrderDetailsRouteArgs {
  const OrderDetailsRouteArgs({this.key, required this.orderId});

  final _i6.Key? key;

  final String orderId;

  @override
  String toString() {
    return 'OrderDetailsRouteArgs{key: $key, orderId: $orderId}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! OrderDetailsRouteArgs) return false;
    return key == other.key && orderId == other.orderId;
  }

  @override
  int get hashCode => key.hashCode ^ orderId.hashCode;
}

/// generated route for
/// [_i4.SignInPage]
class SignInRoute extends _i5.PageRouteInfo<SignInRouteArgs> {
  SignInRoute({
    _i6.Key? key,
    String? redirect,
    List<_i5.PageRouteInfo>? children,
  }) : super(
         SignInRoute.name,
         args: SignInRouteArgs(key: key, redirect: redirect),
         rawQueryParams: {'redirect': redirect},
         initialChildren: children,
       );

  static const String name = 'SignInRoute';

  static _i5.PageInfo page = _i5.PageInfo(
    name,
    builder: (data) {
      final queryParams = data.queryParams;
      final args = data.argsAs<SignInRouteArgs>(
        orElse: () =>
            SignInRouteArgs(redirect: queryParams.optString('redirect')),
      );
      return _i4.SignInPage(key: args.key, redirect: args.redirect);
    },
  );
}

class SignInRouteArgs {
  const SignInRouteArgs({this.key, this.redirect});

  final _i6.Key? key;

  final String? redirect;

  @override
  String toString() {
    return 'SignInRouteArgs{key: $key, redirect: $redirect}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! SignInRouteArgs) return false;
    return key == other.key && redirect == other.redirect;
  }

  @override
  int get hashCode => key.hashCode ^ redirect.hashCode;
}
