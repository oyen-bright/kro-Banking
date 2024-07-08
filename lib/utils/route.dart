import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:kro_banking/router/route.dart';

bool isCurrentRoute(String baseRoute, BuildContext context) {
  final router = GoRouter.of(context);
  final Uri currentRoute = router.routeInformationProvider.value.uri;

  final List<String> segments =
      currentRoute.path.split('/').where((s) => s.isNotEmpty).toList();

  if (segments.isNotEmpty && "/${segments[0]}" == baseRoute) {
    return true;
  } else if (segments.isEmpty && baseRoute == "/") {
    return true;
  } else if (segments.isNotEmpty &&
      "/${segments[0]}" == AppRoutes.login &&
      baseRoute == "/") {
    //TODO:login route bug
    return true;
  } else {
    return false;
  }
}
