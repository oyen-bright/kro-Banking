import 'package:firebase_auth/firebase_auth.dart';
import 'package:kro_banking/service/authentication_service.dart';

abstract class AuthenticationRepository {
  Future<void> signIn(String email, String password);
  FirebaseAuth get auth;
}

class FirebaseAuthenticationRepository implements AuthenticationRepository {
  final AuthenticationService _authenticationService;

  FirebaseAuthenticationRepository(this._authenticationService);

  @override
  Future<void> signIn(String email, String password) async {
    try {
      await _authenticationService.signInWithEmailAndPassword(email, password);
    } catch (e) {
      rethrow;
    }
  }

  @override
  FirebaseAuth get auth => FirebaseAuth.instance;
}
