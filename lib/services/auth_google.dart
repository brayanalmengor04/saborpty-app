
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthUser {
  Future loginGoogle() async {  
    final accountGoogle = await GoogleSignIn().signIn();
    final  googleAuth = await accountGoogle?.authentication;
    
    final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken
    );
    final userCredential = await FirebaseAuth.instance.signInWithCredential(credential);
    return userCredential.user;
  } 

  Future<void> signOut() async {
    await GoogleSignIn().signOut();
    await FirebaseAuth.instance.signOut();
  }
}