class AppRoutes {
  AppRoutes._(); 
    static const String login = '/login';
    static const String register = '/register';
    static const String home = '/home';
    static const String recipeDetail = '/recipe/:id';  

     // Nuevas rutas agrupadas navegacion
    static const String navigation = '/navigation'; 
    static const String homeNavegation = 'home';
    static const String categoryNavegation = 'category';
    static const String favoritesNavegation = 'favorites';
    static const String perfil = 'perfil';
}