import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class WeekHeader extends StatelessWidget {
  final List<DateTime> weekDates;
  final DateTime currentDate;

  const WeekHeader({
    super.key,
    required this.weekDates,
    required this.currentDate,
  });

  String getSpanishWeekdayAbbr(DateTime date) {
    const days = {
      1: 'L', // Lunes
      2: 'M', // Martes
      3: 'X', // Miércoles
      4: 'J', // Jueves
      5: 'V', // Viernes
      6: 'S', // Sábado
      7: 'D', // Domingo
    };
    return days[date.weekday] ?? '';
  }

  String getCurrentMonth(DateTime date) {
    final formatter = DateFormat('MMMM'); 
    return formatter.format(date)[0].toUpperCase() + formatter.format(date).substring(1); 
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Mes actual
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            getCurrentMonth(currentDate),
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
          ),
        ),
        const SizedBox(height: 10),
        // Carrusel de fechas
        SizedBox(
          height: 80,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            itemCount: weekDates.length,
            itemBuilder: (context, index) {
              final date = weekDates[index];
              final isToday = date.day == currentDate.day &&
                  date.month == currentDate.month &&
                  date.year == currentDate.year;

              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Column(
                  children: [
                    Text(
                      getSpanishWeekdayAbbr(date),
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: isToday ? Colors.orange : Colors.grey.shade700,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Container(
                      width: 42,
                      height: 42,
                      decoration: BoxDecoration(
                        color: isToday ? Colors.orange : Colors.transparent,
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: isToday ? Colors.orange : Colors.grey.shade400,
                          width: 1.2,
                        ),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        date.day.toString(),
                        style: TextStyle(
                          color: isToday ? Colors.white : Colors.black87,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
