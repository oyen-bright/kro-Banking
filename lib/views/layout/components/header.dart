import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:kro_banking/bloc/loading/loading_bloc.dart';
import 'package:kro_banking/constants/app_constants.dart';
import 'package:kro_banking/extentions/on_context.dart';
import 'package:kro_banking/router/router.dart';
import 'package:kro_banking/theme/app_colors.dart';
import 'package:kro_banking/utils/get_greetings.dart';
import 'package:kro_banking/widgets/linear_loader.dart';
import 'package:responsive_builder/responsive_builder.dart';

class LayoutHeader extends StatefulWidget {
  const LayoutHeader({
    super.key,
    required this.scaffoldKey,
  });
  final GlobalKey<ScaffoldState> scaffoldKey;

  @override
  State<LayoutHeader> createState() => _LayoutHeaderState();
}

class _LayoutHeaderState extends State<LayoutHeader> {
  bool showGreetings = true;
  bool showTitle = false;

  String getRouteName() {
    final router = GoRouter.of(context);
    final Uri currentRoute = router.routeInformationProvider.value.uri;

    final List<String> segments =
        currentRoute.path.split('/').where((s) => s.isNotEmpty).toList();

    if (segments.isEmpty) {
      return "";
    }

    return (segments[0])[0].toUpperCase() + (segments[0]).substring(1);
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(5.seconds, () {
      if (mounted) {
        setState(() {
          showGreetings = false;
        });
      }
    });

    AppRouter.scrollController.addListener(_scrollListener);
  }

  @override
  void dispose() {
    AppRouter.scrollController.removeListener(_scrollListener);
    super.dispose();
  }

  void _scrollListener() {
    if (AppRouter.scrollController.position.pixels == 0 ||
        AppRouter.scrollController.position.pixels < 20) {
      setState(() {
        showTitle = false;
      });
    } else if (!showTitle && AppRouter.scrollController.position.pixels > 25) {
      setState(() {
        showTitle = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: 500.milliseconds,
      height: kToolbarHeight + 0.5.sh,
      decoration: BoxDecoration(
          color: showTitle
              ? AppColors.kBgWhite
              : context.theme.scaffoldBackgroundColor,
          border: showTitle
              ? Border(
                  bottom: BorderSide(
                      color: context.colorScheme.primary.withOpacity(0.1)))
              : null),
      padding: EdgeInsets.symmetric(horizontal: context.pWidth(30)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.end,
        mainAxisSize: MainAxisSize.min,
        children: [
          ResponsiveBuilder(builder: (context, device) {
            return Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                if (device.isMobile)
                  IconButton(
                      onPressed: () =>
                          widget.scaffoldKey.currentState?.openDrawer(),
                      icon: const Icon(Icons.menu)),
                if (showGreetings)
                  Text(
                    "${getGreeting()}, User",
                    style: context.textTheme.titleMedium?.copyWith(
                        fontSize:
                            context.textTheme.titleMedium!.fontSize! + 2.0),
                  ).animate().slideX(),
                if (!showGreetings && showTitle)
                  Text(
                    getRouteName(),
                    style: context.textTheme.headlineMedium
                        ?.copyWith(fontWeight: FontWeight.w400),
                  ).animate().slideY(),
                const Spacer(),
                IconButton(
                    onPressed: () =>
                        widget.scaffoldKey.currentState?.openEndDrawer(),
                    icon: const Icon(FontAwesomeIcons.bell)),
                Row(
                  children: AnimateList(interval: 200.ms, effects: [
                    FadeEffect(duration: 100.ms)
                  ], children: [
                    CircleAvatar(
                      radius: 20,
                      child: Image.network(KContents.kProfileIcon),
                    ),
                    if (!device.isMobile) ...{
                      SizedBox(
                        width: 1.sw,
                      ),
                      Text(
                        "Oyen ",
                        style: context.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    }
                  ]),
                )
              ],
            );
          }),
          BlocBuilder<LoadingBloc, LoadingState>(
            builder: (context, state) {
              return state.maybeWhen(
                  orElse: () => const SizedBox.shrink(),
                  loading: (_, __, ___) =>
                      SlowLinearProgressIndicator(duration: 2.seconds));
            },
          )
        ],
      ),
    );
  }
}
