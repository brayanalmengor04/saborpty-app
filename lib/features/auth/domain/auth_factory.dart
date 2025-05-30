import 'package:saborpty_app/features/auth/domain/auth_interface.dart';

import '../data/google_auth_service.dart';

enum AuthType { google }

class AuthFactory {
  static AuthStrategy createAuth(AuthType type) {
    switch (type) {
      case AuthType.google:
        return GoogleAuthService();
      default:
        throw UnimplementedError('Auth type not supported');
    }
  }
}
