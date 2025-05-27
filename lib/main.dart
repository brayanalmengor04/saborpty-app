import 'package:flutter/material.dart';
import 'package:saborpty_app/shared/navegation/app_router.dart';
void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    // return const MaterialApp(
    //   home: HomeScreen(),
    // ); 

     return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: appRouter, // <- Aquí se conecta GoRouter
    );
  }
}
