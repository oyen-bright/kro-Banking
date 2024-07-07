import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kro_banking/injection.dart';
import 'package:kro_banking/repository/authentication.dart';
import 'package:kro_banking/service/authentication_service.dart';

class AppRepositoriesProvider extends StatelessWidget {
  final Widget child;
  const AppRepositoriesProvider({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<AuthenticationRepository>(
          lazy: true,
          create: (context) =>
              AuthenticationRepository(getIt<AuthenticationService>()),
        ),
      ],
      child: child,
    );
  }
}