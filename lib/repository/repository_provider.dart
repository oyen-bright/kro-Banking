import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kro_banking/injection.dart';
import 'package:kro_banking/repository/account.dart';
import 'package:kro_banking/repository/authentication.dart';
import 'package:kro_banking/repository/bills.dart';
import 'package:kro_banking/repository/transaction.dart';
import 'package:kro_banking/service/account.dart';
import 'package:kro_banking/service/authentication_service.dart';
import 'package:kro_banking/service/bills.dart';
import 'package:kro_banking/service/transaction.dart';

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
        RepositoryProvider<AccountRepository>(
          lazy: true,
          create: (context) => AccountRepository(
              getIt<AccountService>(), getIt<TransactionService>()),
        ),
        RepositoryProvider<TransactionRepository>(
          lazy: true,
          create: (context) =>
              TransactionRepository(getIt<TransactionService>()),
        ),
        RepositoryProvider<BillRepository>(
          lazy: true,
          create: (context) => BillRepository(getIt<BillService>()),
        ),
      ],
      child: child,
    );
  }
}
