import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kro_banking/bloc/authentication/authentication_bloc.dart';
import 'package:kro_banking/bloc/dashboard/dashboard_bloc.dart';
import 'package:kro_banking/bloc/loading/loading_bloc.dart';
import 'package:kro_banking/bloc/notification/error_bloc.dart';
import 'package:kro_banking/repository/account.dart';
import 'package:kro_banking/repository/authentication.dart';
import 'package:kro_banking/repository/bills.dart';
import 'package:kro_banking/repository/transaction.dart';

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
          create: (context) => LoadingBloc(),
        ),
        BlocProvider(
          create: (context) => ErrorBloc(),
        ),
        BlocProvider(
          lazy: false,
          create: (context) => AuthenticationBloc(
              context.read<AuthenticationRepository>(),
              context.read<LoadingBloc>(),
              context.read<ErrorBloc>())
            ..add(const AuthenticationEvent.started()),
        ),
        BlocProvider<DashboardBloc>(
          create: (context) => DashboardBloc(
              context.read<LoadingBloc>(),
              context.read<ErrorBloc>(),
              context.read<AccountRepository>(),
              context.read<AuthenticationBloc>(),
              context.read<TransactionRepository>(),
              context.read<BillRepository>())
            ..add(const DashboardEvent.loadDashboard()),
        ),
      ],
      child: child,
    );
  }
}
