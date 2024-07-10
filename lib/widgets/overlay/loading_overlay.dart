import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:kro_banking/bloc/loading/loading_bloc.dart';
import 'package:kro_banking/extentions/on_context.dart';

class LoadingOverlay extends StatelessWidget {
  const LoadingOverlay({
    super.key,
    required this.child,
    this.borderRadius = BorderRadius.zero,
  });
  final Widget child;
  final BorderRadiusGeometry borderRadius;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,
        BlocBuilder<LoadingBloc, LoadingState>(
          builder: (context, state) {
            return state.when(
                initial: () => const SizedBox(),
                loading: (message, ___, __) {
                  return Positioned.fill(
                    child: ClipRRect(
                      borderRadius: borderRadius,
                      child: BackdropFilter(
                        filter: ImageFilter.blur(
                          sigmaX: 4.0,
                          sigmaY: 4.0,
                        ),
                        child: Container(
                          color: Colors.transparent,
                          child: Center(
                            child: Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SpinKitFoldingCube(
                                    color: context.colorScheme.primary,
                                    size: 50.0,
                                  ),
                                  if (message != null)
                                    Text(
                                      message,
                                      textAlign: TextAlign.center,
                                      style: context.textTheme.titleMedium!
                                          .copyWith(
                                        color: context.colorScheme.primary,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                ]),
                          ),
                        ),
                      ),
                    ),
                  );
                });
          },
        )
      ],
    );
  }
}
