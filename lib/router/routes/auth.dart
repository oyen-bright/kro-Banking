part of '../router.dart';

final authRoutes = [
  GoRoute(
    path: AppRoutes.login,
    redirect: (context, state) {
      final isAuthenticated =
          context.read<AuthenticationBloc>().state.maybeWhen(
                orElse: () => false,
                authenticated: () => true,
              );
      if (isAuthenticated) {
        return AppRoutes.home;
      }
      return AppRoutes.login;
    },
    builder: (context, state) => const LoginView(),
  ),
];
