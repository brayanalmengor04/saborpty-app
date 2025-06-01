class FavoriteRecipe {
  final String title;
  final String category;
  final int timeMinutes;
  final double rating;
  final bool cooked;
  final String savedSince;

  FavoriteRecipe({
    required this.title,
    required this.category,
    required this.timeMinutes,
    required this.rating,
    required this.cooked,
    required this.savedSince,
  });
}