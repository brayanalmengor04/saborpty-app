import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:saborpty_app/core/constants/app_colors.dart';
import 'package:saborpty_app/core/constants/app_routes.dart';
import 'package:saborpty_app/services/auth_google.dart';

class MenuWidgets {
   static AppBar appBar(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false, 
      title: const Text('Sabor Panameño',style: TextStyle(color: AppColors.textSecondary,
          fontWeight: FontWeight.bold,
          fontSize: 26,
        ),
      ),
      elevation: 1,shadowColor: AppColors.accent,actions: [
        IconButton(
           onPressed: () => AuthUser().signOut().then((_) {
            if (context.mounted) {
              context.go(AppRoutes.login);
            }
          }),
          icon: const Icon(Icons.logout),
          color: AppColors.textSecondary,
          tooltip: 'Cerrar sesión',
        )
      ],
    );
  }
  static BottomNavigationBar bottomNavigationBar({ 
    required BuildContext context,
    required int currentIndex,
    required void Function(int) onTabChanged,
  }) {
    return BottomNavigationBar(
      backgroundColor: AppColors.primary,
      type: BottomNavigationBarType.fixed,
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.list),
          label: 'Category',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.bookmark),
          label: 'Saved',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.face_retouching_natural_outlined),
          label: 'Perfil',
        ),
      ],
      currentIndex: currentIndex,
      unselectedItemColor: AppColors.accent,
      selectedItemColor: AppColors.textSecondary,
      onTap: (index){
          onTabChanged(index); 
        switch (index) {
          case 0:
            context.go('${AppRoutes.navigation}/${AppRoutes.homeNavegation}');
            break;
          case 1:
             context.go('${AppRoutes.navigation}/${AppRoutes.categoryNavegation}');
            break;
          case 2:
            context.go('${AppRoutes.navigation}/${AppRoutes.favoritesNavegation}');
            break;
          case 3:
           context.go('${AppRoutes.navigation}/${AppRoutes.perfil}');
            break;
      }
      },
    );
  }
}
