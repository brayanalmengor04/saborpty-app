
import 'package:go_router/go_router.dart';
import 'package:saborpty_app/features/home/presentation/screen/home_screen.dart';

final appRouter = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const HomeScreen(),
    ),
    
  ],
);