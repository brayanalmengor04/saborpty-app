
import 'package:firebase_auth/firebase_auth.dart';
import 'package:go_router/go_router.dart';
import 'package:saborpty_app/core/constants/app_routes.dart';
import 'package:saborpty_app/features/auth/presentation/login_screen.dart';
import 'package:saborpty_app/features/auth/presentation/register_screen.dart';
import 'package:saborpty_app/features/category/presentation/category_detail.dart';
import 'package:saborpty_app/features/home/presentation/screen/home_screen.dart';
import 'package:saborpty_app/features/options/category_options.dart';
import 'package:saborpty_app/features/options/favorites_options.dart';
import 'package:saborpty_app/features/options/perfil_screen.dart';
import 'package:saborpty_app/shared/widgets/recipe_detailview.dart';

final appRouter = GoRouter(
  initialLocation: AppRoutes.login, 
    redirect: (context, state) {
      final user = FirebaseAuth.instance.currentUser;
      final loggingIn = state.uri.path == AppRoutes.login;
      final registering = state.uri.path == AppRoutes.register;

      if (user == null && !loggingIn && !registering) {
        return AppRoutes.login;
      }

      if (user != null && (loggingIn || registering)) {
        return AppRoutes.home;
      }

      return null;
    },
  routes: [
    GoRoute(
      path: AppRoutes.login,
      builder: (context, state) => const LoginScreen(),
    ),
     GoRoute(
      path: AppRoutes.register,
      builder: (context, state) =>  RegisterScreen(),
    ),
    GoRoute(
      path: AppRoutes.home,
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      path: AppRoutes.categoryDetail,
      builder: (context, state) => const CategoryDetail(),
    ),
   
     GoRoute(
      path: AppRoutes.navigation,
      builder: (context, state) => const HomeScreen(), 
      routes: [
        GoRoute(
          path: AppRoutes.homeNavegation,
          builder: (context, state) => const  HomeScreen(), // <- necesitas esta pantalla
        ),
        GoRoute(
          path: AppRoutes.perfil,
          builder: (context, state) => const PerfilScreen(),
        ),
        GoRoute(
          path: AppRoutes.categoryNavegation,
          builder: (context, state) => const CategoryOptions(), 
        ), 
         GoRoute(
          path: AppRoutes.favoritesNavegation,
          builder: (context, state) => const FavoritesOptions(), 
        ),
      ],

    ),
  ],
);
