import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kro_banking/bloc/authentication/authentication_bloc.dart';
import 'package:kro_banking/bloc/bloc_provider.dart';
import 'package:kro_banking/bloc/error/error_bloc.dart';
import 'package:kro_banking/repository/repository_provider.dart';
import 'package:kro_banking/router/route.dart';
import 'package:kro_banking/router/router.dart';
import 'package:kro_banking/theme/app_theme.dart';
import 'package:kro_banking/utils/toast.dart';
import 'package:responsive_builder/responsive_builder.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return AppRepositoriesProvider(
      child: AppBlocProvider(
        child: ResponsiveApp(builder: (context) {
          AppRouter.instance;
          return Builder(builder: (context) {
            return AppBlocListeners(
              child: MaterialApp.router(
                theme: AppTheme.theme,
                routeInformationProvider:
                    AppRouter.router.routeInformationProvider,
                routerDelegate: AppRouter.instance.routerDelegate,
                routeInformationParser:
                    AppRouter.instance.routeInformationParser,
              ),
            );
          });
        }),
      ),
    );
  }
}

class AppBlocListeners extends StatelessWidget {
  final Widget child;
  const AppBlocListeners({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<AuthenticationBloc, AuthenticationState>(
          listener: (context, state) {
            state.when(authenticated: () {
              AppRouter.router.go(AppRoutes.home);
              print("authentcate");
            }, unauthenticated: (message) {
              print(message);
              print("unautheticated");
              AppRouter.router.go(AppRoutes.login);
            }, unknown: () {
              //TODO: show loading
            });
          },
        ),
        BlocListener<ErrorBloc, ErrorState>(
          listener: (context, state) {
            state.whenOrNull(errorMessage: (message) {
              if (context.mounted) {
                Toasts.showError(message, context);
              }
            });
          },
        ),
      ],
      child: child,
    );
  }
}
