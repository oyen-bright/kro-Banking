// import 'package:bloc_test/bloc_test.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:kro_banking/bloc/authentication/authentication_bloc.dart';
// import 'package:kro_banking/bloc/dashboard/dashboard_bloc.dart';
// import 'package:kro_banking/bloc/loading/loading_bloc.dart';
// import 'package:kro_banking/bloc/notification/error_bloc.dart';
// import 'package:kro_banking/model/account.dart';
// import 'package:kro_banking/model/transaction.dart';
// import 'package:kro_banking/repository/account.dart';
// import 'package:kro_banking/repository/transaction.dart';
// import 'package:mockito/annotations.dart';
// import 'package:mockito/mockito.dart';

// import 'auth.dart';

// class MockAccountRepository extends Mock implements AccountRepository {}

// class MockTransactionRepository extends Mock implements TransactionRepository {}

// class MockAuthenticationBloc extends Mock implements AuthenticationBloc {}

// class MockLoadingBloc extends Mock implements LoadingBloc {}

// class MockErrorBloc extends Mock implements ErrorBloc {}

// @GenerateMocks([
//   MockAccountRepository,
//   MockTransactionRepository,
//   MockAuthenticationBloc,
//   MockLoadingBloc,
//   MockErrorBloc,
// ])
// void main() {
//   late MockAccountRepository accountRepository;
//   late MockTransactionRepository transactionRepository;
//   late MockAuthenticationBloc authenticationBloc;
//   late MockLoadingBloc loadingBloc;
//   late MockErrorBloc errorBloc;
//   late DashboardBloc dashboardBloc;

//   setUp(() {
//     accountRepository = MockAccountRepository();
//     transactionRepository = MockTransactionRepository();
//     authenticationBloc = MockAuthenticationBloc();
//     loadingBloc = MockLoadingBloc();
//     errorBloc = MockErrorBloc();

//     when(authenticationBloc.state)
//         .thenReturn(AuthenticationState.authenticated(MockUser(id: '123')));

//     dashboardBloc = DashboardBloc(
//       loadingBloc,
//       errorBloc,
//       accountRepository,
//       authenticationBloc,
//       transactionRepository,
//     );
//   });

//   tearDown(() {
//     dashboardBloc.close();
//   });

//   test('initial state is DashboardState.initial', () {
//     expect(dashboardBloc.state, equals(const DashboardState.initial()));
//   });

//   blocTest<DashboardBloc, DashboardState>(
//     'emits [DashboardState.loading, DashboardState.loaded] when _LoadDashboard is added',
//     build: () {
//       when(accountRepository.getAccounts(any))
//           .thenAnswer((_) async => (null, [Account(id: 'acc1', type: '')]));
//       when(transactionRepository.getTransactions(any))
//           .thenAnswer((_) async => (null, [Transaction(id: 'txn1')]));
//       return dashboardBloc;
//     },
//     act: (bloc) => bloc.add(const DashboardEvent.loadDashboard()),
//     expect: () => [
//       const DashboardState.loading([], [], []),
//       DashboardState.loaded(
//         accounts: [Account(id: 'acc1')],
//         bills: [],
//         transactions: [Transaction(id: 'txn1', dateTime: null)],
//       ),
//     ],
//   );

//   blocTest<DashboardBloc, DashboardState>(
//     'emits updated state when _AccountDataChange is added',
//     build: () => dashboardBloc,
//     act: (bloc) => bloc
//         .add(DashboardEvent.accountDataChange([Account(id: 'acc2', type: "")])),
//     expect: () => [
//       DashboardState.loaded(
//         accounts: [Account(id: 'acc2')],
//         bills: [],
//         transactions: [],
//       ),
//     ],
//   );

//   blocTest<DashboardBloc, DashboardState>(
//     'emits updated state when _TransactionDataChange is added',
//     build: () => dashboardBloc,
//     act: (bloc) => bloc
//         .add(DashboardEvent.transactionDataChange([Transaction(id: 'txn2')])),
//     expect: () => [
//       DashboardState.loaded(
//         accounts: [],
//         bills: [],
//         transactions: [Transaction(id: 'txn2')],
//       ),
//     ],
//   );

//   blocTest<DashboardBloc, DashboardState>(
//     'emits appropriate states and events when _TransferBetweenAccounts is added',
//     build: () {
//       when(accountRepository.makeTransfer(any, any, any, any))
//           .thenAnswer((_) async => (null, 'Transfer successful'));
//       return dashboardBloc;
//     },
//     act: (bloc) => bloc.add(const DashboardEvent.transferBetweenAccounts(
//       from: 'acc1',
//       to: 'acc2',
//       amount: 100.0,
//     )),
//     expect: () => [],
//     verify: (_) {
//       verify(loadingBloc.add(const LoadingEvent.loading())).called(1);
//       verify(errorBloc.add(const ErrorEvent.showError('Transferring Funds',
//               type: NotificationType.loading)))
//           .called(1);
//       verify(accountRepository.makeTransfer(any, any, any, any)).called(1);
//       verify(errorBloc.add(const ErrorEvent.showError('Transfer successful',
//               type: NotificationType.notify)))
//           .called(1);
//       verify(loadingBloc.add(const LoadingEvent.loaded())).called(1);
//     },
//   );
// }
