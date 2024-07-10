// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:kro_banking/service/account.dart' as _i4;
import 'package:kro_banking/service/authentication_service.dart' as _i5;
import 'package:kro_banking/service/bills.dart' as _i3;
import 'package:kro_banking/service/transaction.dart' as _i6;

extension GetItInjectableX on _i1.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i1.GetIt init({
    String? environment,
    _i2.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i2.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    gh.singleton<_i3.BillService>(() => _i3.BillService());
    gh.singleton<_i4.AccountService>(() => _i4.AccountService());
    gh.singleton<_i5.AuthenticationService>(() => _i5.AuthenticationService());
    gh.singleton<_i6.TransactionService>(() => _i6.TransactionService());
    return this;
  }
}
