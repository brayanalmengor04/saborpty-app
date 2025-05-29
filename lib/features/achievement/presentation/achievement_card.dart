import 'package:flutter/material.dart';
import 'package:saborpty_app/core/constants/app_colors.dart';

class AchievementCard extends StatefulWidget {
  final IconData icon;
  final String title;
  final String description;
  final Color color;

  const AchievementCard({
    super.key,
    required this.icon,
    required this.title,
    required this.description,
    required this.color,
  });

  @override
  State<AchievementCard> createState() => _AchievementCardState();
}
class _AchievementCardState extends State<AchievementCard> {
  bool _showDescription = false;
  void _toggleCard() {
    setState(() {
      _showDescription = !_showDescription;
    });
  }
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _toggleCard,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        padding: const EdgeInsets.all(1),
        decoration: BoxDecoration(
          color: AppColors.primary,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: AppColors.shawdowCard,
              blurRadius: 8,
              offset: const Offset(2, 4),
            ),
          ],
        ),
        child:  AnimatedSwitcher(
      duration: const Duration(milliseconds: 400),
      transitionBuilder: (Widget child, Animation<double> animation) {
        return ScaleTransition(scale: animation, child: child);
      },
      child: _showDescription
      ? Container(
          key: const ValueKey(1),
          decoration: BoxDecoration(
            color: widget.color,
            borderRadius: BorderRadius.circular(16),
          ),
          alignment: Alignment.center,
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Text(
              widget.description,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 12,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        )
      : Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
            key: const ValueKey(2),
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(widget.icon, color: widget.color, size: 30),
              const SizedBox(height: 10),
              Text(
                widget.title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                  color: AppColors.secondary,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
      ),
),
      ),
    );
  }

  Stack stackDefault() {
    return Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(widget.icon, color: widget.color, size: 30),
              const SizedBox(height: 10),
              Text(
                widget.title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                  color: AppColors.secondary,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
          AnimatedOpacity(
            opacity: _showDescription ? 1.0 : 0.0,
            duration: const Duration(milliseconds: 300),
            child: Visibility(
              visible: _showDescription,
              child: Container(
                decoration: BoxDecoration(
                  color: widget.color,
                  borderRadius: BorderRadius.circular(16),
                ),
                alignment: Alignment.center,
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Text(
                    widget.description,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
          ),
        ],
      );
  }
}
