import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:saborpty_app/core/constants/app_colors.dart';
import 'package:saborpty_app/core/constants/app_routes.dart';
import '../domain/auth_factory.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final auth = AuthFactory.createAuth(AuthType.google);
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    FontAwesomeIcons.utensils,
                    size: 36,
                    color: AppColors.textSecondary,
                  ),
                  const SizedBox(width: 12),
                  Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: "Sabor ",
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF1E1E2C),
                          ),
                        ),
                          TextSpan(
                            text: "PTY",
                            style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.w900,
                              color: AppColors.textSecondary, 
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 48),
                emailInput(),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () async {
                      try {
                        final user = await auth.login();
                        if (user != null) {
                          context.go(AppRoutes.home);
                        }
                      } catch (e) {
                        _showAwesomeSnackBar(
                          context,
                          title: 'Error',
                          message: 'Hubo un problema al iniciar sesión.',
                          contentType: ContentType.failure,
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.textSecondary,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    ),
                    child: const Text('Iniciar sesión', style: TextStyle(fontSize: 16 , 
                    color: AppColors.primary , fontWeight: FontWeight.w700)),
                  ),
                ),
                const SizedBox(height: 24),

                const Text("O", style: TextStyle(fontSize: 16, color: Colors.grey)),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _socialButton(
                        context,
                        FontAwesomeIcons.google,
                        Colors.red,
                        () async {
                          try {
                            final user = await auth.login();
                            user != null ? context.go(AppRoutes.home) : null;
                          } catch (e) {
                            _showAwesomeSnackBar(
                              context,
                              title: 'Error Autenticacion',
                              message: 'Ocurrió un error inesperado: Vuelva Iniciar Nuevamente!',
                              contentType: ContentType.failure,
                            );
                          }
                        },
                      ),
                    _socialButton(context, FontAwesomeIcons.facebookF, Colors.blueAccent, () {
                      _showAwesomeSnackBar(
                        context,
                        title: 'Próximamente',
                        message: 'El inicio con Facebook estará disponible muy pronto.',
                        contentType: ContentType.warning,
                      );
                    }),
                    _socialButton(context, FontAwesomeIcons.apple, Colors.black, () {
                      _showAwesomeSnackBar(
                        context,
                        title: 'Próximamente',
                        message: 'El inicio con Apple estará disponible muy pronto.',
                        contentType: ContentType.warning,
                      );
                    }),
                    _socialButton(context, FontAwesomeIcons.github, Colors.black87, () {
                      _showAwesomeSnackBar(
                        context,
                        title: 'Próximamente',
                        message: 'El inicio con GitHub estará disponible muy pronto.',
                        contentType: ContentType.warning,
                      );
                    }),
                  ],
                ),
                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }
  TextFormField emailInput() {
    return TextFormField(
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  hintText: 'Correo electrónico',
                  prefixIcon: const Icon(Icons.email_outlined, color:AppColors.textSecondary),
                  contentPadding: const EdgeInsets.symmetric(vertical: 18.0, horizontal: 20.0),
                  filled: true,
                  fillColor: Colors.grey.shade100,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0),
                    borderSide: BorderSide.none,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0),
                    borderSide: const BorderSide(color: AppColors.textSecondary, width: 2),
                  ),
                ),
                style: const TextStyle(fontSize: 16),
              );
  }
  // Botón social reutilizable
  Widget _socialButton(BuildContext context, IconData icon, Color color, VoidCallback onPressed) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(32),
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: FaIcon(icon, size: 22, color: color),
      ),
    );
  }
  void _showAwesomeSnackBar(
    BuildContext context, {
    required String title,
    required String message,
    required ContentType contentType,
  }) {
    final snackBar = SnackBar(
      elevation: 0,
      backgroundColor: Colors.transparent,
      behavior: SnackBarBehavior.floating,
      content: AwesomeSnackbarContent(
        title: title,
        message: message,
        contentType: contentType,
      ),
    );

    ScaffoldMessenger.of(context)
      ..clearSnackBars()
      ..showSnackBar(snackBar);
  }
}
