import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:kro_banking/extentions/on_context.dart';
import 'package:kro_banking/router/route.dart';
import 'package:kro_banking/router/router.dart';
import 'package:kro_banking/utils/route.dart';
import 'package:responsive_builder/responsive_builder.dart';

final menuItems = [
  {'title': 'Dashboard', 'icon': Icons.dashboard, 'route': AppRoutes.home},
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
  {'title': 'Account', 'icon': Icons.wallet, 'route': AppRoutes.accounts},
  {
    'title': 'Investment',
    'icon': Icons.analytics,
    'route': AppRoutes.investments
  },
  {'title': 'Support', 'icon': Icons.support_agent, 'route': null},
  {'title': 'Settings', 'icon': Icons.settings, 'route': null},
  {'title': 'Logout', 'icon': Icons.logout, 'route': null},
];

class LayoutSideBar extends StatelessWidget {
  const LayoutSideBar({super.key, required this.device});

  final SizingInformation device;

  @override
  Widget build(BuildContext context) {
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
                // KContents.kAppName.toUpperCase(),

                "",
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
                  ).animate().slideX();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

ListTile _buildItem(BuildContext context, bool isSelected, String? route,
    Map<String, Object?> item, SizingInformation device, String title) {
  return ListTile(
    selectedColor: context.colorScheme.primary,
    selectedTileColor:
        isSelected ? context.colorScheme.primary.withOpacity(0.2) : Colors.grey,
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
