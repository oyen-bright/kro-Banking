part of 'authentication_bloc.dart';

@freezed
abstract class AuthenticationState with _$AuthenticationState {
  const factory AuthenticationState.authenticated() = _Authenticated;
  const factory AuthenticationState.unauthenticated({String? message}) =
      _Unauthenticated;
  const factory AuthenticationState.unknown() = _Unknown;

  factory AuthenticationState.fromJson(Map<String, dynamic> json) =>
      _$AuthenticationStateFromJson(json);
}
