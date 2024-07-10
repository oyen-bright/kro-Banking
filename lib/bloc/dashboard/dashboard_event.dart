part of 'dashboard_bloc.dart';

@freezed
class DashboardEvent with _$DashboardEvent {
  const factory DashboardEvent.started() = _Started;
  const factory DashboardEvent.loadDashboard() = _LoadDashboard;
  const factory DashboardEvent.transferBetweenAccounts(
      Account from, Account to, double amount) = _TransferBetweenAccounts;
  const factory DashboardEvent.onAccountDataChange(List<Account> accounts) =
      _AccountDataChange;
  const factory DashboardEvent.onTransactionDataChange(
      List<Transaction> transaction) = _TransactionDataChange;
}
