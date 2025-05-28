import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:saborpty_app/shared/widgets/menu/menu_widgets.dart';

class PerfilScreen extends StatefulWidget {
  const PerfilScreen({super.key});

  @override
  State<PerfilScreen> createState() => _PerfilScreenState();
}

class _PerfilScreenState extends State<PerfilScreen> { 
  int _selectedIndex = 3; 
  
  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      appBar: MenuWidgets.appBar(context),
      body: Center(
        child: user != null
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('UID: ${user.uid}'),
                  Text('Email: ${user.email}'),
                  Text('Nombre: ${user.displayName ?? 'No disponible'}'),
                ],
              )
            : const Text('Usuario no autenticado'),
      ),
            bottomNavigationBar: MenuWidgets.bottomNavigationBar(
            context: context,
            currentIndex: _selectedIndex,
            onTabChanged: (int index) {
                setState(() {
                  _selectedIndex = index;
                });
              },
       ), 
    );
  }
}