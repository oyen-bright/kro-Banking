part of '../router.dart';

final transferRoutes = [
  GoRoute(
    path: AppRoutes.transferFunds,
    builder: (context, state) => const TransferView(),
  ),
];
