import 'package:flutter/material.dart';
import 'package:saborpty_app/features/weekly_meal/data/models/weekly_meal_model.dart';
import 'package:saborpty_app/features/weekly_meal/presentation/widgets/meal_day_card.dart';
import 'package:saborpty_app/features/weekly_meal/presentation/widgets/week_header.dart';

class WeeklyMealScreen extends StatelessWidget {
  WeeklyMealScreen({super.key});

  final List<DateTime> currentWeek = _getCurrentWeekDates();

  static List<DateTime> _getCurrentWeekDates() {
    final now = DateTime.now();
    final monday = now.subtract(Duration(days: now.weekday - 1));
    return List.generate(7, (index) => monday.add(Duration(days: index)));
  }

  List<WeeklyMealModel> generateDummyMeals() {
    return currentWeek.map((date) {
      return WeeklyMealModel(
        day: _getDayLabel(date.weekday),
        date: date.day.toString(),
        name: date.weekday == DateTime.monday
            ? "Sancocho Panameño"
            : date.weekday == DateTime.tuesday
                ? "Arroz con Pollo"
                : date.weekday == DateTime.friday
                    ? "Patacones"
                    : date.weekday == DateTime.sunday
                        ? "Ropa Vieja"
                        : null,
        category: date.weekday == DateTime.monday
            ? "Sopas"
            : date.weekday == DateTime.tuesday
                ? "Tradicionales"
                : date.weekday == DateTime.friday
                    ? "Platos Rápidos"
                    : date.weekday == DateTime.sunday
                        ? "Tradicionales"
                        : null,
        time: date.weekday == DateTime.monday
            ? "45 min"
            : date.weekday == DateTime.tuesday
                ? "45 min"
                : date.weekday == DateTime.friday
                    ? "20 min"
                    : date.weekday == DateTime.sunday
                        ? "60 min"
                        : null,
      );
    }).toList();
  }

  static String _getDayLabel(int weekday) {
    const days = ['Lun', 'Mar', 'Mié', 'Jue', 'Vie', 'Sáb', 'Dom'];
    return days[weekday - 1];
  }

  @override
  Widget build(BuildContext context) {
    final meals = generateDummyMeals();
    final today = DateTime.now();

    return Column(
      children: [
        WeekHeader(
          weekDates: currentWeek,
          currentDate: today, // ⬅️ Ahora pasamos DateTime directamente
        ),
        Expanded(
          child: ListView.builder(
            itemCount: meals.length,
            itemBuilder: (context, index) {
              return WeeklyMealCard(meal: meals[index]);
            },
          ),
        ),
      ],
    );
  }
}
