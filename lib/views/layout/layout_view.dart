import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:kro_banking/constants/app_constants.dart';
import 'package:kro_banking/extentions/on_context.dart';
import 'package:kro_banking/router/route.dart';
import 'package:kro_banking/router/router.dart';
import 'package:responsive_builder/responsive_builder.dart';

final menuItems = [
  {'title': 'Dashboard', 'icon': Icons.analytics, 'route': AppRoutes.home},
  {'title': 'Account', 'icon': Icons.analytics, 'route': AppRoutes.accounts},
  {
    'title': 'Transfer',
    'icon': Icons.analytics,
    'route': AppRoutes.transferFunds
  },
  {
    'title': 'Transactions',
    'icon': Icons.analytics,
    'route': AppRoutes.transactionHistory
  },
  {'title': 'Bills', 'icon': Icons.analytics, 'route': AppRoutes.billPayments},
  {
    'title': 'Investment',
    'icon': Icons.analytics,
    'route': AppRoutes.investments
  },
];

bool isCurrentRoute(String baseRoute, BuildContext context) {
  final router = GoRouter.of(context);
  final Uri currentRoute = router.routeInformationProvider.value.uri;

  final List<String> segments =
      currentRoute.path.split('/').where((s) => s.isNotEmpty).toList();

  print(segments);

  if (segments.isNotEmpty && "/${segments[0]}" == baseRoute) {
    return true;
  } else if (segments.isEmpty && baseRoute == "/") {
    return true;
  } else if (segments.isNotEmpty &&
      "/${segments[0]}" == AppRoutes.login &&
      baseRoute == "/") {
    //TODO:fix login bug
    return true;
  } else {
    return false;
  }
}

class Layout extends StatelessWidget {
  final Widget child;

  const Layout({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // drawer: Drawer(
      //   child: ListView(
      //     padding: EdgeInsets.zero,
      //     children: <Widget>[
      //       const DrawerHeader(
      //         decoration: BoxDecoration(
      //           color: Colors.blue,
      //         ),
      //         child: Text(
      //           'Drawer Header',
      //           style: TextStyle(
      //             color: Colors.white,
      //             fontSize: 24,
      //           ),
      //         ),
      //       ),
      //       ListTile(
      //         leading: const Icon(Icons.home),
      //         title: const Text('Home'),
      //         onTap: () {
      //           context.go('/');
      //         },
      //       ),
      //       ListTile(
      //         leading: const Icon(Icons.dashboard),
      //         title: const Text('Dashboard'),
      //         onTap: () {
      //           context.go('/dashboard');
      //         },
      //       ),
      //       ListTile(
      //         leading: const Icon(Icons.person),
      //         title: const Text('Profile'),
      //         onTap: () {
      //           context.go('/profile');
      //         },
      //       ),
      //       ListTile(
      //         leading: const Icon(Icons.person),
      //         title: const Text('sex'),
      //         onTap: () {
      //           context.go('/transfer');
      //         },
      //       ),
      //     ],
      //   ),
      // ),
      body: Row(
        children: [
          Drawer(
              width: context.pWidth(300),
              child: Container(
                width: context.pWidth(300),
                color: Colors.white,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(
                      height: 3.sh,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: context.pWidth(20),
                      ),
                      child: Text(
                        KContents.kAppName.toUpperCase(),
                        style: context.textTheme.headlineMedium?.copyWith(
                            color: context.colorScheme.primary,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(
                      height: 3.sh,
                    ),
                    Expanded(
                        child: ListView.builder(
                            itemCount: menuItems.length,
                            itemBuilder: (context, index) {
                              final item = menuItems[index];

                              return ListTile(
                                onTap: () => AppRouter.router
                                    .go(item['route'] as String),
                                selectedColor: Colors.red,
                                selected: isCurrentRoute(
                                    item['route'] as String, context),
                                title: Text(item['title'] as String),
                                leading: Icon(item['icon'] as IconData),
                              );
                            }))
                  ],
                ),
              )),
          Expanded(
            child: child,
          ),
        ],
      ),
    );
  }
}
