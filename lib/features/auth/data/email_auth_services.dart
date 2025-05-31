import 'package:firebase_auth/firebase_auth.dart';
import 'package:saborpty_app/features/auth/domain/auth_interface.dart';

class EmailAuthServices implements AuthStrategy { 

   final String email;
  final String password;

  EmailAuthServices({required this.email, required this.password});

  @override
  Future<User?> login() async {
    try {
      final userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      final user = userCredential.user;
      if (user != null && !user.emailVerified) {
        print('⚠️ El correo electrónico no ha sido verificado.');
        await user.sendEmailVerification(); 
        return null;
      }
      await user?.reload(); 
      return FirebaseAuth.instance.currentUser;
    } on FirebaseAuthException catch (e) {
      print('❌ Error al iniciar sesión con email: ${e.message}');
      return null;
    }
  }
 Future<User?> register() async {
  try {
    final userCredential = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);
    final user = userCredential.user;
    if (user != null && !user.emailVerified) {
      await user.sendEmailVerification();
      print('Se envió un correo de verificación a ${user.email}');
    }
    return user;
  } on FirebaseAuthException catch (e) {
    print('❌ Error al registrar usuario: ${e.message}');
    return null;
  }
}
  @override
  Future<void> logout() async {
    await FirebaseAuth.instance.signOut();
  } 
}