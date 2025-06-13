class WeeklyMealModel {
  final String day;
  final String date;
  final String? name;
  final String? category;
  final String? time;

  WeeklyMealModel({
    required this.day,
    required this.date,
    this.name,
    this.category,
    this.time,
  });
}
