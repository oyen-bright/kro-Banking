import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:kro_banking/constants/app_constants.dart';
import 'package:kro_banking/extentions/on_context.dart';
import 'package:kro_banking/router/route.dart';
import 'package:kro_banking/router/router.dart';
import 'package:kro_banking/utils/get_greetings.dart';
import 'package:responsive_builder/responsive_builder.dart';

final menuItems = [
  {'title': 'Dashboard', 'icon': Icons.dashboard, 'route': AppRoutes.home},
  {'title': 'Account', 'icon': Icons.wallet, 'route': AppRoutes.accounts},
  {
    'title': 'Transfer',
    'icon': Icons.savings,
    'route': AppRoutes.transferFunds
  },
  {
    'title': 'Transactions',
    'icon': Icons.input,
    'route': AppRoutes.transactionHistory
  },
  {'title': 'Bills', 'icon': Icons.payment, 'route': AppRoutes.billPayments},
  {
    'title': 'Investment',
    'icon': Icons.analytics,
    'route': AppRoutes.investments
  },
  {'title': 'Support', 'icon': Icons.support_agent, 'route': null},
  {'title': 'Settings', 'icon': Icons.settings, 'route': null},
  {'title': 'Logout', 'icon': Icons.logout, 'route': null},
];

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

final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

class Layout extends StatelessWidget {
  final Widget child;

  const Layout({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(builder: (context, device) {
      return Scaffold(
        key: _scaffoldKey,
        endDrawer: const Drawer(),
        // appBar: AppBar(),
        drawer: _drawer(context, device),
        body: Row(
          children: [
            Builder(builder: (context) {
              if (device.isDesktop || device.isTablet) {
                double drawerWidth = device.isTablet ? 80 : context.pWidth(285);
                return _sideNav(drawerWidth, context, device);
              } else {
                return const SizedBox.shrink();
              }
            }),
            Expanded(
              child: Column(
                children: [
                  Container(
                    height: kToolbarHeight,
                    color: Colors.red,
                    child: ResponsiveBuilder(builder: (context, device) {
                      return Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          if (device.isMobile)
                            IconButton(
                                onPressed: () =>
                                    _scaffoldKey.currentState?.openDrawer(),
                                icon: const Icon(Icons.menu)),
                          SizedBox(
                            width: 1.sw,
                          ),
                          Text(
                            "${getGreeting()}, User",
                            style: context.textTheme.titleMedium?.copyWith(
                                fontSize:
                                    context.textTheme.titleMedium!.fontSize! +
                                        2.0),
                          ),
                          const Spacer(),
                          IconButton(
                              onPressed: () =>
                                  _scaffoldKey.currentState?.openEndDrawer(),
                              icon: const Icon(FontAwesomeIcons.bell)),
                          CircleAvatar(
                            radius: 20,
                            child: Image.network(
                                "https://avatars.githubusercontent.com/u/35768100?v=4"),
                          )
                        ],
                      );
                    }),
                  ),
                  Expanded(child: child),
                ],
              ),
            ),
          ],
        ),
      );
    });
  }

  AnimatedContainer _sideNav(
      double drawerWidth, BuildContext context, SizingInformation device) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      width: drawerWidth,
      decoration: BoxDecoration(
          border: Border(
              right: BorderSide(
                  color: context.colorScheme.primary.withOpacity(0.2)))),
      child: _drawer(context, device),
    );
  }

  Drawer _drawer(BuildContext context, SizingInformation device) {
    return Drawer(
      shape: const RoundedRectangleBorder(),
      child: Container(
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: 2.1.sh),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: context.pWidth(30)),
              child: Text(
                KContents.kAppName.toUpperCase(),
                maxLines: 1,
                style: context.textTheme.headlineMedium?.copyWith(
                  color: context.colorScheme.primary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 3.sh),
            Expanded(
              child: ListView.separated(
                separatorBuilder: (context, index) {
                  if (index == 5) {
                    return Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: context.pWidth(20),
                          vertical: context.pHeight(10)),
                      child: Divider(
                        color: context.colorScheme.primary.withOpacity(0.2),
                      ),
                    );
                  }
                  return const SizedBox.shrink();
                },
                itemCount: menuItems.length,
                itemBuilder: (context, index) {
                  final item = menuItems[index];
                  final title = item['title'] as String;
                  final route = item['route'] as String?;
                  final isSelected = route != null
                      ? isCurrentRoute((item['route'] as String?)!, context)
                      : false;

                  return Material(
                    color: Colors.transparent,
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: context.pWidth(20)),
                      child: device.isTablet
                          ? Tooltip(
                              message: title,
                              child: _buildItem(context, isSelected, route,
                                  item, device, title),
                            )
                          : _buildItem(
                              context, isSelected, route, item, device, title),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  ListTile _buildItem(BuildContext context, bool isSelected, String? route,
      Map<String, Object?> item, SizingInformation device, String title) {
    return ListTile(
      selectedColor: context.colorScheme.primary,
      selectedTileColor: isSelected
          ? context.colorScheme.primary.withOpacity(0.2)
          : Colors.grey,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: BorderSide(
          width: 1,
          color: isSelected
              ? context.colorScheme.primary.withOpacity(0.5)
              : Colors.transparent,
        ),
      ),
      onTap: () =>
          route != null ? AppRouter.router.go(item['route'] as String) : null,
      selected: isSelected,
      title: device.isTablet
          ? const SizedBox.shrink()
          : Text(
              title,
              maxLines: 1,
            ),
      leading: Icon(
        item['icon'] as IconData,
        color: isSelected ? context.colorScheme.primary : Colors.grey,
      ),
    );
  }
}
