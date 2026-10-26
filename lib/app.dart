import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/di/injection.dart';
import 'core/router/app_router.dart';
import 'core/theme/app_theme.dart';
import 'features/auth/presentation/bloc/auth_bloc.dart';
import 'features/catalog/presentation/bloc/catalog_bloc.dart';
import 'features/checkout/presentation/bloc/checkout_bloc.dart';

class RefreshiApp extends StatelessWidget {
  const RefreshiApp({super.key});

  @override
  Widget build(BuildContext context) {
    // App-wide blocs are singletons in get_it; BlocProvider.value exposes them
    // to the tree without taking ownership.
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: getIt<AuthBloc>()..add(const AuthEvent.started())),
        BlocProvider.value(value: getIt<CatalogBloc>()),
        BlocProvider.value(value: getIt<CheckoutBloc>()..add(const CheckoutEvent.started())),
      ],
      child: MaterialApp.router(
        title: 'Refreshi',
        debugShowCheckedModeBanner: false,
        // The brand is cream-and-forest only, like refreshi.co.za.
        theme: AppTheme.light(),
        themeMode: ThemeMode.light,
        routerConfig: getIt<AppRouter>().config(),
      ),
    );
  }
}
