import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:saborpty_app/core/constants/app_colors.dart';
import 'package:saborpty_app/core/constants/app_routes.dart';
import 'dart:ui'; 


class MenuWidgets {
 static AppBar appBar(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: Colors.white.withOpacity(0.05),
      elevation: 0,
      toolbarHeight: 70,
      flexibleSpace: ClipRRect(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.1),
              border: Border(
                bottom: BorderSide(
                  color: Colors.white.withOpacity(0.2),
                  width: 0.5,
                ),
              ),
            ),
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Icon(Icons.fastfood_rounded, color: Colors.orangeAccent, size: 28),
                    ),
                    Icon(Icons.notifications_none_rounded, color: AppColors.textSecondary),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
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
