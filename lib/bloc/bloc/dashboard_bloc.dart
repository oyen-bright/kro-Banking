import 'package:bloc/bloc.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:kro_banking/bloc/authentication/authentication_bloc.dart';
import 'package:kro_banking/bloc/error/error_bloc.dart';
import 'package:kro_banking/bloc/loading/loading_bloc.dart';
import 'package:kro_banking/model/account.dart';
import 'package:kro_banking/model/bills.dart';
import 'package:kro_banking/model/transaction.dart';
import 'package:kro_banking/repository/account.dart';

part 'dashboard_bloc.freezed.dart';
part 'dashboard_event.dart';
part 'dashboard_state.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  final LoadingBloc _loadingBloc;
  final ErrorBloc _errorBloc;
  final AuthenticationBloc _authenticationBloc;
  final AccountRepository _accountRepository;

  late final String userID;

  DashboardBloc(this._loadingBloc, this._errorBloc, this._accountRepository,
      this._authenticationBloc)
      : super(const _Initial()) {
    userID = _authenticationBloc.state.user?.id ?? "";
    on<_LoadDashboard>(_onLoadDashBoard);
    on<_AccountDataChange>(_onAccountDataChange);

    // _accountRepository.listenToAccountChanges(userID, (newData) {
    //   add(_AccountDataChange(newData));
    // });
  }

  void _onLoadDashBoard(
      _LoadDashboard event, Emitter<DashboardState> emit) async {
    final currentState = state.data;
    _loadingBloc.add(const LoadingEvent.loading());
    await Future.delayed(10.seconds);
    emit(_Loading(
        accounts: currentState.$1,
        bills: currentState.$2,
        transactions: currentState.$3));

    final response = await _accountRepository.getAccounts(userID);
    if (response.$1 != null) {
      _errorBloc.add(ErrorEvent.showError(response.$1 ?? ""));
      emit(_Loaded(
          accounts: currentState.$1 ?? [],
          bills: currentState.$2 ?? [],
          transactions: currentState.$3 ?? []));

      return;
    }

    emit(_Loaded(
      accounts: response.$2,
      bills: currentState.$2 ?? [],
      transactions: currentState.$3 ?? [],
    ));
    _loadingBloc.add(const LoadingEvent.loaded());
  }

  void _onAccountDataChange(
      _AccountDataChange event, Emitter<DashboardState> emit) async {
    final currentState = state.data;
    emit(_Loaded(
        accounts: event.accounts,
        bills: currentState.$2 ?? [],
        transactions: currentState.$3 ?? []));
  }
}
