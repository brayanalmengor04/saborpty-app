import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:saborpty_app/services/auth_google.dart';



class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Bienvenido a SaborPTY',
                style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 40),
              Image.asset('assets/logo/google_logo.png', height: 120), // Asegúrate de tener el logo
              const SizedBox(height: 40),
              ElevatedButton.icon(
                onPressed: () async {
                  try {
                      final authUser = AuthUser(); 
                      final user = await authUser.loginGoogle();  

                      if (user!=null) {
                       print('Usuario autenticado: ${user?.email}'); 
                      }
                  }on FirebaseException catch (e) {
                    print(e); 
                     ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('An error occurred: ${e.message}'),
                        duration: Duration(seconds: 3),
                      ),
                    );
                  }
                } ,
                icon: Image.asset('assets/logo/google_logo.png', height: 24), // icono de Google
                label: const Text('Iniciar sesión con Google'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.black,
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  side: const BorderSide(color: Colors.black12),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
