part of '../router.dart';

final authRoutes = [
  GoRoute(
    path: AppRoutes.login,
    builder: (context, state) => const LoginView(),
  ),
];
