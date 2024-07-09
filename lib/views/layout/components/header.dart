// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:kro_banking/bloc/loading/loading_bloc.dart';
import 'package:kro_banking/constants/app_constants.dart';
import 'package:kro_banking/extentions/on_context.dart';
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

bool showGreetings = true;

class _LayoutHeaderState extends State<LayoutHeader> {
  @override
  void initState() {
    Future.delayed(5.seconds, () {
      if (mounted) {
        setState(() {
          showGreetings = false;
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: kToolbarHeight + 0.5.sh,
      color: context.theme.scaffoldBackgroundColor,
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
                  ).animate(effects: [const FadeEffect()]),
                const Spacer(),
                IconButton(
                    onPressed: () =>
                        widget.scaffoldKey.currentState?.openEndDrawer(),
                    icon: const Icon(FontAwesomeIcons.bell)),
                Row(
                  children: [
                    CircleAvatar(
                      radius: 20,
                      child: Image.network(KContents.kProfileIcon),
                    ),
                    if (!device.isMobile) ...{
                      SizedBox(
                        width: 1.sw,
                      ),
                      Text(
                        "its Aha",
                        style: context.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    }
                  ].animate(effects: [const FadeEffect()]),
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
