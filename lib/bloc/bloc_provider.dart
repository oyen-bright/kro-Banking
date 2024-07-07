import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kro_banking/bloc/bloc/authentication_bloc.dart';
import 'package:kro_banking/repository/authentication.dart';

class AppBlocProvider extends StatelessWidget {
  final Widget child;
  const AppBlocProvider({super.key, required this.child});

  @override
  Widget build(
    BuildContext context,
  ) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              AuthenticationBloc(context.read<AuthenticationRepository>())
                ..add(const AuthenticationEvent.started()),
        )
      ],
      child: child,
    );
  }
}
