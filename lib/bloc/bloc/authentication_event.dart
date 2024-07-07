part of 'authentication_bloc.dart';

@freezed
abstract class AuthenticationEvent with _$AuthenticationEvent {
  const factory AuthenticationEvent.started() = _Started;
  const factory AuthenticationEvent.loggedOut() = _LoggedOut;
  const factory AuthenticationEvent.onAuthChanged(User? user) = _AuthChange;
  const factory AuthenticationEvent.sessionExpired({required String message}) =
      _SessionExpiredEvent;
}
