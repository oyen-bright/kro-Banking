import 'package:flutter/material.dart';
import 'package:kro_banking/constants/app_constants.dart';
import 'package:kro_banking/extentions/on_context.dart';
import 'package:kro_banking/views/layout/components/header.dart';
import 'package:kro_banking/views/layout/components/siderbar.dart';
import 'package:responsive_builder/responsive_builder.dart';

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
        drawer: LayoutSideBar(device: device),
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
                  LayoutHeader(scaffoldKey: _scaffoldKey),
                  Expanded(
                      child: SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: context.pWidth(KContents.kHorizontalPad)),
                      child: child,
                    ),
                  )),
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
        child: LayoutSideBar(device: device));
  }
}
