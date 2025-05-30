import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthStrategy {
  Future<User?> login();
  Future<void> logout();
}