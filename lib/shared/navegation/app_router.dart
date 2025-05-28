
import 'package:go_router/go_router.dart';
import 'package:saborpty_app/core/constants/app_routes.dart';
import 'package:saborpty_app/features/auth/presentation/login_screen.dart';
import 'package:saborpty_app/features/home/presentation/screen/home_screen.dart';
import 'package:saborpty_app/shared/widgets/recipe_detailview.dart';

final appRouter = GoRouter(
  initialLocation: AppRoutes.login,
  routes: [
    GoRoute(
      path: AppRoutes.login,
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: AppRoutes.home,
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      path: AppRoutes.recipeDetail,
      builder: (context, state) {
        final id = int.tryParse(state.pathParameters['id'] ?? '0') ?? 0;
        return RecipeDetailview(recipeId: id);
      },
    ),
  ],
);
