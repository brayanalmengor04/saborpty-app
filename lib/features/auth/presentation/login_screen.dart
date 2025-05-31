import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:lottie/lottie.dart';
import 'package:saborpty_app/core/constants/app_colors.dart';
import 'package:saborpty_app/core/constants/app_routes.dart';
import '../domain/auth_factory.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;
  bool _obscurePassword = true;
  String _emailError = '';
  String _passwordError = '';
  final List<String> _tips = [
    "Cocinar es amor hecho visible 🍳",
    "Un buen plato comienza con buenos ingredientes 🥦",
    "Sazonar con pasión hace la diferencia 🌶️",
  ]; 
  
  String get _randomTip => (_tips..shuffle()).first;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Lottie.asset('assets/lottie/chef.json', height: 180),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(FontAwesomeIcons.utensils,
                        size: 36, color: AppColors.textSecondary),
                    const SizedBox(width: 12),
                    titleLogin(),
                  ],
                ),
                const SizedBox(height: 8),
                Text(_randomTip,
                    style: const TextStyle(
                        fontSize: 14, fontStyle: FontStyle.italic, color: Colors.grey)),
                const SizedBox(height: 40),
                emailInput(),
                if (_emailError.isNotEmpty)
                  Text(_emailError, style: const TextStyle(color: Colors.red)),
                const SizedBox(height: 20),
                passwordInput(),
                if (_passwordError.isNotEmpty)
                  Text(_passwordError, style: const TextStyle(color: Colors.red)),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _isLoading ? null : _handleLogin,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.textSecondary,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                    ),
                    child: _isLoading
                        ? const SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: AppColors.primary,
                            ),
                          )
                        : const Text(
                            'Iniciar sesión',
                            style: TextStyle(
                                fontSize: 16,
                                color: AppColors.primary,
                                fontWeight: FontWeight.w700),
                          ),
                  ),
                ),
                TextButton(
                  onPressed: () => context.go(AppRoutes.register),
                  child: const Text("¿No tienes cuenta? Regístrate aquí"),
                ),
                const SizedBox(height: 24),
                const Text("O",
                    style: TextStyle(fontSize: 16, color: Colors.grey)),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _socialButton(context, FontAwesomeIcons.google, Colors.red,
                        () async {
                      final auth = AuthFactory.createAuth(AuthType.google);
                      try {
                        final user = await auth.login();
                        if (user != null) context.go(AppRoutes.home);
                      } catch (e) {
                        _showAwesomeSnackBar(
                          context,
                          title: 'Error',
                          message: 'Error con Google: inténtalo nuevamente.',
                          contentType: ContentType.failure,
                        );
                      }
                    }),
                    _socialButton(context, FontAwesomeIcons.facebookF,
                        Colors.blueAccent, () {
                      _showAwesomeSnackBar(
                        context,
                        title: 'Próximamente',
                        message:
                            'Inicio con Facebook estará disponible pronto.',
                        contentType: ContentType.warning,
                      );
                    }),
                    _socialButton(context, FontAwesomeIcons.apple, Colors.black,
                        () {
                      _showAwesomeSnackBar(
                        context,
                        title: 'Próximamente',
                        message: 'Inicio con Apple estará disponible pronto.',
                        contentType: ContentType.warning,
                      );
                    }),
                    _socialButton(
                        context, FontAwesomeIcons.github, Colors.black87, () {
                      _showAwesomeSnackBar(
                        context,
                        title: 'Próximamente',
                        message: 'Inicio con GitHub estará disponible pronto.',
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

  void _handleLogin() async {
    setState(() {
      _emailError = '';
      _passwordError = '';
    });

    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

    if (!email.contains("@")) {
      setState(() => _emailError = "Correo inválido");
      return;
    }
    if (password.length < 6) {
      setState(() => _passwordError = "Mínimo 6 caracteres");
      return;
    }

    setState(() => _isLoading = true);
    final auth = AuthFactory.createAuth(
      AuthType.email,
      email: email,
      password: password,
    );
    try {
      final user = await auth.login();
      if (user != null) {
        await user.reload();
        final refreshedUser = AuthFactory.getCurrentUser();

        if (refreshedUser != null && refreshedUser.emailVerified) {
          context.go(AppRoutes.home);
        } else {
          await auth.logout();
          _showAwesomeSnackBar(
            context,
            title: 'Verificación requerida',
            message: 'Por favor, confirma tu correo electrónico.',
            contentType: ContentType.warning,
          );
        }
      } else {
        _showAwesomeSnackBar(
          context,
          title: 'Error Cuenta',
          message: 'Correo o contraseña incorrectos.',
          contentType: ContentType.warning,
        );
      }
    } catch (e) {
      _showAwesomeSnackBar(
        context,
        title: 'Error',
        message: 'Ocurrió un error inesperado.',
        contentType: ContentType.failure,
      );
    } finally {
      setState(() => _isLoading = false);
    }
  }

  Text titleLogin() {
    return Text.rich(
      TextSpan(
        children: [
          TextSpan(
            text: "Sabor ",
            style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.w600,
                color: Color(0xFF1E1E2C)),
          ),
          TextSpan(
            text: "PTY",
            style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.w900,
                color: AppColors.textSecondary),
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
        prefixIcon: const Icon(Icons.email_outlined,
            color: AppColors.textSecondary),
        contentPadding:
            const EdgeInsets.symmetric(vertical: 18.0, horizontal: 20.0),
        filled: true,
        fillColor: Colors.grey.shade100,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide:
              const BorderSide(color: AppColors.textSecondary, width: 2),
        ),
      ),
      style: const TextStyle(fontSize: 16),
    );
  }

  TextFormField passwordInput() {
    return TextFormField(
      controller: _passwordController,
      obscureText: _obscurePassword,
      decoration: InputDecoration(
        hintText: 'Contraseña',
        prefixIcon: const Icon(Icons.lock_outline,
            color: AppColors.textSecondary),
        suffixIcon: IconButton(
          icon: Icon(
            _obscurePassword ? Icons.visibility_off : Icons.visibility,
            color: Colors.grey,
          ),
          onPressed: () => setState(() => _obscurePassword = !_obscurePassword),
        ),
        contentPadding:
            const EdgeInsets.symmetric(vertical: 18.0, horizontal: 20.0),
        filled: true,
        fillColor: Colors.grey.shade100,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide:
              const BorderSide(color: AppColors.textSecondary, width: 2),
        ),
      ),
      style: const TextStyle(fontSize: 16),
    );
  }

  Widget _socialButton(
      BuildContext context, IconData icon, Color color, VoidCallback onPressed) {
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
