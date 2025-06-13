
import 'package:firebase_auth/firebase_auth.dart';
import 'package:go_router/go_router.dart';
import 'package:saborpty_app/core/constants/app_routes.dart';
import 'package:saborpty_app/features/auth/presentation/login_screen.dart';
import 'package:saborpty_app/features/auth/presentation/register_screen.dart';
import 'package:saborpty_app/features/category/presentation/category_detail.dart';
import 'package:saborpty_app/features/home/presentation/screen/home_screen.dart';
import 'package:saborpty_app/features/introduction/introduction_screen.dart';
import 'package:saborpty_app/features/options/category_options.dart';
import 'package:saborpty_app/features/options/week_options.dart';
import 'package:saborpty_app/features/options/perfil_screen.dart';
import 'package:saborpty_app/main.dart';
import 'package:saborpty_app/shared/widgets/recipe_detailview.dart';
final appRouter = GoRouter(
  initialLocation: initialRoute, 
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
    path: AppRoutes.introduction,
    builder: (context, state) => const SaborIntroductionScreen(),
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
      builder: (context, state) {
        final category = state.pathParameters['category']!;
        final imageUrl = state.uri.queryParameters['imageUrl'] ??
            'https://uning.es/wp-content/uploads/2016/08/ef3-placeholder-image.jpg';
        return CategoryDetail(
          categoryName: category,
          categoryImage: imageUrl,
        );
      },
    ),

   GoRoute(
    path: AppRoutes.recipeDetail,
    builder: (context, state) {
      final idParam = state.pathParameters['id'];
        final recipeId = int.parse(idParam!);
        return RecipeDetailview(recipeId: recipeId, user: FirebaseAuth.instance.currentUser
        );
      },
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
          path: AppRoutes.OtherNavegation,
          builder: (context, state) => const OtherOptions(), 
        ),
      ],

    ),
  ],
);
