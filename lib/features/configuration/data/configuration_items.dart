import 'package:flutter/material.dart';
import 'package:saborpty_app/core/constants/app_routes.dart';
import 'package:saborpty_app/services/auth_google.dart';
import 'package:go_router/go_router.dart';
import '../presentation/configuration_list.dart';
import 'package:shared_preferences/shared_preferences.dart';

List<ConfigurationItem> getConfigurationItems(BuildContext context) {
  return [
    ConfigurationItem(
      icon: Icons.notifications_none,
      title: 'Notificaciones',
      description: 'Gestiona tus notificaciones',
      onTap: () => print("Navegar a Notificaciones"),
    ),
    ConfigurationItem(
      icon: Icons.dark_mode_outlined,
      title: 'Modo Oscuro',
      description: 'Cambia el tema de la aplicación',
      onTap: () => print("Cambiar tema"),
    ),
    ConfigurationItem(
      icon: Icons.help_outline,
      title: 'Ayuda y Soporte',
      description: 'Obtén ayuda o contacta soporte',
      onTap: () => print("Navegar a Ayuda y Soporte"),
    ),
    ConfigurationItem(
      icon: Icons.logout,
      title: 'Cerrar Sesión',
      description: 'Salir de tu cuenta',
      onTap: () async {
        await AuthUser().signOut();
        await clearSessionData();
        if (context.mounted) {
          context.go(AppRoutes.login);
        }
      },
    ),
  ];
}
Future<void> clearSessionData() async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.clear(); 
}