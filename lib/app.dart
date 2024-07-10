import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:kro_banking/bloc/authentication/authentication_bloc.dart';
import 'package:kro_banking/bloc/bloc_provider.dart';
import 'package:kro_banking/bloc/notification/error_bloc.dart';
import 'package:kro_banking/extentions/on_context.dart';
import 'package:kro_banking/repository/repository_provider.dart';
import 'package:kro_banking/router/route.dart';
import 'package:kro_banking/router/router.dart';
import 'package:kro_banking/theme/app_theme.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:toastification/toastification.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return AppRepositoriesProvider(
      child: AppBlocProvider(
        child: ResponsiveApp(builder: (context) {
          return ToastificationWrapper(
            child: Builder(builder: (context) {
              return AppBlocListeners(
                child: MaterialApp.router(
                  debugShowCheckedModeBanner: false,
                  theme: AppTheme.theme,
                  // routerConfig: AppRouter.router,
                  routeInformationProvider:
                      AppRouter.router.routeInformationProvider,
                  routerDelegate: AppRouter.instance.routerDelegate,
                  routeInformationParser:
                      AppRouter.instance.routeInformationParser,
                ),
              );
            }),
          );
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
            state.when(authenticated: (_) {
              AppRouter.router.go(AppRoutes.home);
            }, unauthenticated: (message) {
              AppRouter.router.go(AppRoutes.login);
            }, unknown: () {
              //TODO: show loading
            });
          },
        ),
        BlocListener<ErrorBloc, ErrorState>(
          listener: (context, state) {
            state.whenOrNull(errorMessage: (message, type) {
              if (context.mounted) {
                toastification.dismissAll();
                switch (type) {
                  case NotificationType.loading:
                    toastification.show(
                      icon: Icon(FontAwesomeIcons.circleInfo,
                          color: context.colorScheme.primary),
                      title: Text(message),
                      autoCloseDuration: const Duration(seconds: 10),
                    );
                    break;
                  case NotificationType.error:
                    toastification.show(
                      icon: Icon(
                        FontAwesomeIcons.circleInfo,
                        color: context.colorScheme.onError,
                      ),
                      title: Text(
                        message,
                        style: context.textTheme.titleMedium
                            ?.copyWith(color: context.colorScheme.onError),
                      ),
                      backgroundColor: context.colorScheme.error,
                      autoCloseDuration: const Duration(seconds: 5),
                    );
                    break;
                  case NotificationType.notify:
                    toastification.show(
                      icon: Icon(FontAwesomeIcons.circleInfo,
                          color: context.colorScheme.primary),
                      title: Text(message),
                      autoCloseDuration: const Duration(seconds: 5),
                    );
                    break;
                }
              }
            });
          },
        ),
      ],
      child: child,
    );
  }
}
