import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:saborpty_app/core/constants/app_colors.dart';

class ProfileSummary extends StatelessWidget {
  final User? user;

  const ProfileSummary({super.key, this.user});

  bool get isGoogleSignIn {
    return user?.providerData.any((info) => info.providerId == 'google.com') ?? false;
  }
  bool get isEmailPasswordSignIn {
    return user?.providerData.any((info) => info.providerId == 'password') ?? false;
  }

  @override
  Widget build(BuildContext context) {
    final displayName = isGoogleSignIn
        ? (user?.displayName ?? 'Usuario')
        : (user?.email ?? 'Usuario');  
        

    return Card(
      color: AppColors.primary,
      margin: const EdgeInsets.all(16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 3,
      shadowColor: AppColors.shawdowCard,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 32,
                  backgroundImage: user?.photoURL != null
                      ? NetworkImage(user!.photoURL!)
                      : null,
                  child: user?.photoURL == null
                      ? const Icon(Icons.person, size: 32)
                      : null,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        displayName,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Text("Amante de la cocina panameña"),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          const Icon(Icons.emoji_food_beverage,
                              size: 16, color: AppColors.textSecondary),
                          const SizedBox(width: 4),
                          Text(
                            "Chef SaborPTY",
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                              color: AppColors.textSecondary,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _StatColumn(title: "Recetas Guardadas", value: "12"),
                _StatColumn(title: "Cocinadas", value: "8"),
                _StatColumn(title: "Tiempo Total", value: "24h"),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _StatColumn extends StatelessWidget {
  final String title;
  final String value;

  const _StatColumn({required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
            color: AppColors.textSecondary,
          ),
        ),
        Text(
          title,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
