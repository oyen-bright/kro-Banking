import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:kro_banking/bloc/error/error_bloc.dart';
import 'package:kro_banking/bloc/loading/loading_bloc.dart';
import 'package:kro_banking/repository/authentication.dart';

part 'authentication_bloc.freezed.dart';
part 'authentication_bloc.g.dart';
part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends HydratedBloc<AuthenticationEvent, AuthenticationState> {
  late final FirebaseAuth _firebaseAuth;
  final AuthenticationRepository _authRepository;
  final LoadingBloc _loadingBloc;
  final ErrorBloc _errorBloc;
  late StreamSubscription<User?> _authSubscription;

  AuthenticationBloc(this._authRepository, this._loadingBloc, this._errorBloc)
      : super(const AuthenticationState.unknown()) {
    on<_Started>(_onStarted);
    on<_LoggedOut>(_onLoggedOut);
    on<_SessionExpiredEvent>(_onSessionExpired);
    on<_AuthChange>(_onAuthStateChanged);
    _firebaseAuth = _authRepository.auth;
    _authSubscription = _firebaseAuth.authStateChanges().listen((User? user) {
      add(AuthenticationEvent.onAuthChanged(user));
    });
  }

  void _onStarted(_Started event, Emitter<AuthenticationState> emit) {
    final user = _firebaseAuth.currentUser;
    if (user != null) {
      emit(const AuthenticationState.authenticated());
    } else {
      emit(const AuthenticationState.unauthenticated());
    }
  }

  void _onLoggedOut(_LoggedOut event, Emitter<AuthenticationState> emit) async {
    await _firebaseAuth.signOut();
    emit(const AuthenticationState.unauthenticated());
  }

  void _onSessionExpired(
      _SessionExpiredEvent event, Emitter<AuthenticationState> emit) {
    emit(AuthenticationState.unauthenticated(message: event.message));
  }

  void _onAuthStateChanged(
      _AuthChange event, Emitter<AuthenticationState> emit) {
    if (event.user != null) {
      emit(const AuthenticationState.authenticated());
    } else {
      emit(const AuthenticationState.unauthenticated());
    }
  }

  void loginWithEmailPassword(String email, String password) async {
    _loadingBloc.add(const LoadingEvent.loading());

    _authRepository.signIn(email, password).then((res) {
      _loadingBloc.add(const LoadingEvent.loaded());

      if (res != null) {
        _errorBloc.add(ErrorEvent.showError(res));
      }
    });
  }

  @override
  AuthenticationState fromJson(Map<String, dynamic> json) {
    try {
      return AuthenticationState.fromJson(json);
    } catch (_) {
      return const AuthenticationState.unknown();
    }
  }

  @override
  Map<String, dynamic> toJson(AuthenticationState state) {
    return state.toJson();
  }

  @override
  Future<void> close() {
    _authSubscription.cancel();
    return super.close();
  }
}
