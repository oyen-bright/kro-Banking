import 'package:kro_banking/service/authentication_service.dart';

abstract class AuthenticationRepository {
  Future<void> signIn(String email, String password);
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
}
