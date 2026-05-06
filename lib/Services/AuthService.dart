import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  Future<UserCredential> signUp({
    required String email,
    required String password,
    required String username,
  }) async {
    final credential = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(
      email: email.trim(),
      password: password.trim(),
    );

    await credential.user?.updateDisplayName(username.trim());
    await credential.user?.reload();

    return credential;
  }
}