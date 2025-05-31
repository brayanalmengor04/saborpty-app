import 'package:flutter/material.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:saborpty_app/core/constants/app_colors.dart';
import 'package:saborpty_app/core/constants/app_routes.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart'; // AÑADIDO

import '../domain/auth_factory.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({super.key});

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final RegExp emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$'); 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Fondo degradado naranja
          Container(
            height: double.infinity,
            width: double.infinity,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [AppColors.textSecondary, AppColors.background],
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
              ),
            ),
          ),
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 28),
              child: Column(
                children: [
                  const SizedBox(height: 40),
                  Lottie.asset(
                    'assets/lottie/registerbooks.json',
                    width: 500, 
                    
                    repeat: true,
                    fit: BoxFit.contain,
                  ),

                  // Card blanca con los inputs
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(24),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 10,
                          offset: const Offset(0, 5),
                        )
                      ],
                    ),
                    child: Column(
                      children: [
                        const Text(
                          "Crear Cuenta",
                          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 24),
                        emailInput(),
                        const SizedBox(height: 16),
                        passwordInput(),
                        const SizedBox(height: 24),

                        ElevatedButton(
                          onPressed: () async {
                            final email = _emailController.text.trim();
                            final password = _passwordController.text.trim();

                            if (!emailRegex.hasMatch(email)) {
                              _showSnackBar(context, 'Correo inválido', 'Por favor ingresa un correo válido.', ContentType.warning);
                              return;
                            }

                            if (password.length < 6) {
                              _showSnackBar(context, 'Contraseña débil', 'Debe contener al menos 6 caracteres.', ContentType.warning);
                              return;
                            }
                            final auth = AuthFactory.createAuth(AuthType.email, email: email, password: password);
                            final user = await (auth as dynamic).register();

                            if (user != null) {
                              await auth.logout();

                              _showSnackBar(
                                context,
                                'Verificación requerida',
                                'Te enviamos un correo de verificación. Verifica antes de iniciar sesión.',
                                ContentType.warning,
                              );
                              Future.delayed(const Duration(seconds: 3), () => context.go(AppRoutes.login));
                            } else {
                              _showSnackBar(
                                context,
                                'Error',
                                'No se pudo crear la cuenta. Inténtalo de nuevo.',
                                ContentType.failure,
                              );
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.textSecondary,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                            minimumSize: const Size.fromHeight(50),
                          ),
                          child: const Text('Registrarse', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
                        ),

                        const SizedBox(height: 20),

                        Row(
                          children: const [
                            Expanded(child: Divider()),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 8),
                              child: Text("O regístrate con"),
                            ),
                            Expanded(child: Divider()),
                          ],
                        ),

                        const SizedBox(height: 16),

                        // Redes sociales
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Icon(FontAwesomeIcons.google, color: Colors.redAccent),
                            SizedBox(width: 20),
                            Icon(FontAwesomeIcons.facebook, color: Colors.blue),
                            SizedBox(width: 20),
                            Icon(FontAwesomeIcons.github, color: Colors.black),
                          ],
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Ya tienes cuenta
                  TextButton(
                    onPressed: () => context.go(AppRoutes.login),
                    child: const Text(
                      "¿Ya tienes una cuenta? Inicia sesión",
                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  TextFormField emailInput() {
    return TextFormField(
      controller: _emailController,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        hintText: 'Correo electrónico',
        prefixIcon: const Icon(Icons.email_outlined, color: AppColors.textSecondary),
        contentPadding: const EdgeInsets.symmetric(vertical: 18.0, horizontal: 20.0),
        filled: true,
        fillColor: Colors.grey.shade100,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.0), borderSide: BorderSide.none),
      ),
    );
  }

  TextFormField passwordInput() {
    return TextFormField(
      controller: _passwordController,
      obscureText: true,
      decoration: InputDecoration(
        hintText: 'Contraseña',
        prefixIcon: const Icon(Icons.lock_outline, color: AppColors.textSecondary),
        contentPadding: const EdgeInsets.symmetric(vertical: 18.0, horizontal: 20.0),
        filled: true,
        fillColor: Colors.grey.shade100,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.0), borderSide: BorderSide.none),
      ),
    );
  }

  void _showSnackBar(BuildContext context, String title, String message, ContentType type) {
    final snackBar = SnackBar(
      elevation: 0,
      backgroundColor: Colors.transparent,
      behavior: SnackBarBehavior.floating,
      content: AwesomeSnackbarContent(title: title, message: message, contentType: type),
    );

    ScaffoldMessenger.of(context)
      ..clearSnackBars()
      ..showSnackBar(snackBar);
  }
}
