class ApiRoutes {
  static const String _hostname = "https://saborpty-backend-production.up.railway.app/api/v1";
  static const String pathGetAllRecipes = "$_hostname/recipes/enriched/all";
  static String pathGetDetailRecipes(int id) => "$_hostname/recipe/$id/ingredients"; 
  
  // Filters category
  static String pathGetAllRecipesByCategory(String categoryName){
    return "$_hostname/recipes/filterby-category/$categoryName/category";
  }
  // Filter PreparationFilters
  static String pathGetAllPreparationFilter(String categoryName){
    return "$_hostname/recipes/filterby-preparation/asc/$categoryName/category";
  }
  static String pathGetAllRatingFilter(String categoryName)=> "$_hostname/recipes/filterby-rating/$categoryName";
  static String pathGetAllRecentFilter(String categoryName)=> "$_hostname/recipes/filterby-recent/$categoryName"; 

  // Post Favorite Endpoints (post)
  static String pathAddFavorite ()=> "$_hostname/favorites";
  static String pathGetFavoriteByUser (String firebaseUID) => "$_hostname/favorites/$firebaseUID"; 
  static String pathDeleteFavoriteByUser (String firebaseUID ,int recipeID ){
    return "$_hostname/favorites/$firebaseUID/recipe/$recipeID";
  }

}