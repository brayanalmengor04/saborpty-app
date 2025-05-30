import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:saborpty_app/features/auth/domain/auth_interface.dart';

class GoogleAuthService implements AuthStrategy {
  @override
  Future<User?> login() async {
    final accountGoogle = await GoogleSignIn().signIn();
    final googleAuth = await accountGoogle?.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    final userCredential =
        await FirebaseAuth.instance.signInWithCredential(credential);

    return userCredential.user;
  }

  @override
  Future<void> logout() async {
    await GoogleSignIn().signOut();
    await FirebaseAuth.instance.signOut();
  }
}
