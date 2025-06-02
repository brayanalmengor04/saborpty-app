import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:go_router/go_router.dart';
import 'package:saborpty_app/core/constants/app_colors.dart';
import 'package:saborpty_app/core/constants/app_routes.dart';
import 'package:saborpty_app/features/introduction/introduction_pages.dart';
import 'package:shared_preferences/shared_preferences.dart'; // No olvides importar esto

class SaborIntroductionScreen extends StatelessWidget {
  const SaborIntroductionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return IntroductionScreen(
      globalBackgroundColor: Colors.white,
      pages: introductionPages,
      onDone: () async {
        final prefs = await SharedPreferences.getInstance();
        await prefs.setBool('hasSeenIntro', true);
        context.go(AppRoutes.login);
      },
      onSkip: () async {
        final prefs = await SharedPreferences.getInstance();
        await prefs.setBool('hasSeenIntro', true);
        context.go(AppRoutes.login);
      },
      showSkipButton: true,
      skip: const Text("Saltar"),
      next: const Icon(Icons.navigate_next),
      done: const Text("¡Comenzar!", style: TextStyle(fontWeight: FontWeight.w600)),
      dotsDecorator: DotsDecorator(
        size: const Size.square(10.0),
        activeSize: const Size(22.0, 10.0),
        activeShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25.0)),
        activeColor: AppColors.textSecondary,
      ),
    );
  }
}
