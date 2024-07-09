library app_router;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:kro_banking/bloc/authentication/authentication_bloc.dart';
import 'package:kro_banking/router/route.dart';
import 'package:kro_banking/views/dashboard/dashboard_view.dart';
import 'package:kro_banking/views/layout/layout_view.dart';
import 'package:kro_banking/views/login/login_view.dart';
import 'package:kro_banking/views/transactions/transaction_view.dart';
import 'package:kro_banking/views/transfer/transfer_view.dart';

part './routes/account.dart';
part './routes/auth.dart';
part './routes/bills_payment.dart';
part './routes/home.dart';
part './routes/investment.dart';
part './routes/profile.dart';
part './routes/transaction.dart';
part './routes/transfer.dart';

class AppRouter {
  factory AppRouter() {
    return _instance;
  }

  static final AppRouter _instance = AppRouter._internal();
  static AppRouter get instance => _instance;

  static final GlobalKey<NavigatorState> parentNavigatorKey =
      GlobalKey<NavigatorState>();

  static final GlobalKey<NavigatorState> homeNavigatorKey =
      GlobalKey<NavigatorState>();
  static final GlobalKey<NavigatorState> transferNavigatorKey =
      GlobalKey<NavigatorState>();
  static final GlobalKey<NavigatorState> transactionNavigatorKey =
      GlobalKey<NavigatorState>();
  static final GlobalKey<NavigatorState> billsPaymentNavigatorKey =
      GlobalKey<NavigatorState>();
  static final GlobalKey<NavigatorState> investmentNavigatorKey =
      GlobalKey<NavigatorState>();
  static final GlobalKey<NavigatorState> profileNavigatorKey =
      GlobalKey<NavigatorState>();
  static final GlobalKey<NavigatorState> accountNavigatorKey =
      GlobalKey<NavigatorState>();

  static late final GoRouter router;

  BuildContext get context =>
      router.routerDelegate.navigatorKey.currentContext!;

  GoRouterDelegate get routerDelegate => router.routerDelegate;

  GoRouteInformationParser get routeInformationParser =>
      router.routeInformationParser;

  AppRouter._internal() {
    final routes = [
      _shellRoutes(),
      ...authRoutes,
    ];
    router = GoRouter(
      navigatorKey: parentNavigatorKey,
      initialLocation: AppRoutes.login,
      routes: routes,
      errorBuilder: (context, state) {
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                '404 - Page Not Found',
                style: TextStyle(fontSize: 24),
              ),
              ElevatedButton(
                onPressed: () => context.go(AppRoutes.home),
                child: const Text('Go Home'),
              ),
            ],
          ),
        );
      },
    );
  }

  static Page setupPage({
    required Widget child,
    required GoRouterState state,
  }) {
    return MaterialPage(
      key: state.pageKey,
      child: child,
    );
  }

  StatefulShellRoute _shellRoutes() {
    return StatefulShellRoute.indexedStack(
      parentNavigatorKey: parentNavigatorKey,
      branches: [
        StatefulShellBranch(
          navigatorKey: homeNavigatorKey,
          routes: homeRoutes,
        ),
        StatefulShellBranch(
          navigatorKey: billsPaymentNavigatorKey,
          routes: billPaymentRoutes,
        ),
        StatefulShellBranch(
          navigatorKey: accountNavigatorKey,
          routes: accountRoutes,
        ),
        StatefulShellBranch(
          navigatorKey: transferNavigatorKey,
          routes: transferRoutes,
        ),
        StatefulShellBranch(
          navigatorKey: transactionNavigatorKey,
          routes: transactionRoutes,
        ),
        StatefulShellBranch(
          navigatorKey: profileNavigatorKey,
          routes: profileRoutes,
        ),
        StatefulShellBranch(
          navigatorKey: investmentNavigatorKey,
          routes: investmentRoutes,
        ),
      ],
      pageBuilder: (
        BuildContext context,
        GoRouterState state,
        StatefulNavigationShell navigationShell,
      ) {
        return MaterialPage(
          key: state.pageKey,
          child: Layout(
            child: navigationShell,
          ),
        );
      },
    );
  }
}
