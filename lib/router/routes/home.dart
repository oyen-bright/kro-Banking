part of '../router.dart';

final homeRoutes = [
  GoRoute(
    path: AppRoutes.home,
    builder: (context, state) => const DashboardView(),
  ),
];
