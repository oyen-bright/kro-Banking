part of 'dashboard_bloc.dart';

@freezed
class DashboardState with _$DashboardState {
  const DashboardState._();

  const factory DashboardState.initial() = _Initial;
  const factory DashboardState.loading({
    List<Account>? accounts,
    List<Bill>? bills,
    List<Transaction>? transactions,
  }) = _Loading;
  const factory DashboardState.loaded({
    required List<Account> accounts,
    required List<Bill> bills,
    required List<Transaction> transactions,
  }) = _Loaded;

  (
    List<Account>? accounts,
    List<Bill>? bills,
    List<Transaction>? transactions,
  ) get data {
    return map(
      initial: (_) => (null, null, null),
      loading: (state) => (state.accounts, state.bills, state.transactions),
      loaded: (state) => (state.accounts, state.bills, state.transactions),
    );
  }
}
