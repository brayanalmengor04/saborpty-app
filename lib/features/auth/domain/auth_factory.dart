import 'package:firebase_auth/firebase_auth.dart';
import 'package:saborpty_app/features/auth/data/email_auth_services.dart';
import 'package:saborpty_app/features/auth/domain/auth_interface.dart';

import '../data/google_auth_service.dart';
enum AuthType { google ,email}

class AuthFactory {
  static AuthStrategy createAuth(AuthType type,{String? email, String? password}) {
    switch (type) {
      case AuthType.google:
        return GoogleAuthService(); 

      case AuthType.email:
        if (email == null || password == null) {
          throw ArgumentError('Email y password son requeridos para login por correo');
        }
        return EmailAuthServices(email: email, password: password);
    }
  } 

  static User? getCurrentUser() {
    return FirebaseAuth.instance.currentUser;
  }
}
