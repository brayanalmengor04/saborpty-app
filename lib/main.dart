import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:saborpty_app/core/constants/app_routes.dart';
import 'package:saborpty_app/firebase_options.dart';
import 'package:saborpty_app/shared/navegation/app_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

late final String initialRoute; 
Future<void> main() async {  
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  final prefs = await SharedPreferences.getInstance();
  final hasSeenIntro = prefs.getBool('hasSeenIntro') ?? false;
  initialRoute = hasSeenIntro ? AppRoutes.login : AppRoutes.introduction;
  runApp(const MainApp());
}
class MainApp extends StatelessWidget {
  const MainApp({super.key});
  @override
  Widget build(BuildContext context) {
     return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: appRouter, 
    );
  }
}
