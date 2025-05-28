import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:saborpty_app/firebase_options.dart';
import 'package:saborpty_app/shared/navegation/app_router.dart';
Future<void> main() async {  
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
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
