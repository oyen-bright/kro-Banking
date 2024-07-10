import 'package:bloc_test/bloc_test.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kro_banking/bloc/authentication/authentication_bloc.dart';
import 'package:kro_banking/bloc/loading/loading_bloc.dart';
import 'package:kro_banking/bloc/notification/error_bloc.dart';
import 'package:kro_banking/repository/authentication.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'authentication_bloc_test.mocks.dart';

class MockFirebaseAuth extends Mock implements FirebaseAuth {}

class MockAuthenticationRepository extends Mock
    implements AuthenticationRepository {}

class MockLoadingBloc extends Mock implements LoadingBloc {}

class MockErrorBloc extends Mock implements ErrorBloc {}

class MockUser extends Mock implements User {}

@GenerateMocks([
  MockFirebaseAuth,
  MockAuthenticationRepository,
  MockLoadingBloc,
  MockErrorBloc,
  MockUser
])
void main() {
  late MockFirebaseAuth firebaseAuth;
  late MockAuthenticationRepository authRepository;
  late MockLoadingBloc loadingBloc;
  late MockErrorBloc errorBloc;
  late AuthenticationBloc authenticationBloc;

  setUp(() {
    firebaseAuth = MockFirebaseAuth();
    authRepository = MockAuthenticationRepository();
    loadingBloc = MockLoadingBloc();
    errorBloc = MockErrorBloc();

    when(authRepository.auth).thenReturn(firebaseAuth);
    when(firebaseAuth.authStateChanges())
        .thenAnswer((_) => Stream.value(MockUser()));

    authenticationBloc =
        AuthenticationBloc(authRepository, loadingBloc, errorBloc);
  });

  tearDown(() {
    authenticationBloc.close();
  });

  test('initial state is AuthenticationState.unknown', () {
    expect(
        authenticationBloc.state, equals(const AuthenticationState.unknown()));
  });

  blocTest<AuthenticationBloc, AuthenticationState>(
    'emits [authenticated] when _Started is added and user is logged in',
    build: () {
      when(firebaseAuth.currentUser).thenReturn(MockUser());
      when(MockUser().email).thenReturn('test@test.com');
      return authenticationBloc;
    },
    act: (bloc) => bloc.add(const AuthenticationEvent.started()),
    expect: () => [isA<AuthenticationStateAuthenticated>()],
  );

  blocTest<AuthenticationBloc, AuthenticationState>(
    'emits [unauthenticated] when _Started is added and no user is logged in',
    build: () {
      when(firebaseAuth.currentUser).thenReturn(null);
      return authenticationBloc;
    },
    act: (bloc) => bloc.add(const AuthenticationEvent.started()),
    expect: () => [const AuthenticationState.unauthenticated()],
  );

  blocTest<AuthenticationBloc, AuthenticationState>(
    'emits [unauthenticated] when _LoggedOut is added',
    build: () {
      when(firebaseAuth.signOut()).thenAnswer((_) async => {});
      return authenticationBloc;
    },
    act: (bloc) => bloc.add(const AuthenticationEvent.loggedOut()),
    expect: () => [const AuthenticationState.unauthenticated()],
  );

  blocTest<AuthenticationBloc, AuthenticationState>(
    'emits [unauthenticated] with message when _SessionExpiredEvent is added',
    build: () => authenticationBloc,
    act: (bloc) =>
        bloc.add(const AuthenticationEvent.sessionExpired('Session expired')),
    expect: () =>
        [const AuthenticationState.unauthenticated(message: 'Session expired')],
  );

  blocTest<AuthenticationBloc, AuthenticationState>(
    'emits [authenticated] when _AuthChange is added and user is not null',
    build: () => authenticationBloc,
    act: (bloc) => bloc.add(AuthenticationEvent.onAuthChanged(MockUser())),
    expect: () => [isA<AuthenticationStateAuthenticated>()],
  );

  blocTest<AuthenticationBloc, AuthenticationState>(
    'emits [unauthenticated] when _AuthChange is added and user is null',
    build: () => authenticationBloc,
    act: (bloc) => bloc.add(const AuthenticationEvent.onAuthChanged(null)),
    expect: () => [const AuthenticationState.unauthenticated()],
  );
}
