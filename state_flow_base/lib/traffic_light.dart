import 'package:flutter/material.dart';

class TrafficLight extends StatelessWidget {
  final Color color;
  final bool active;

  const TrafficLight({required this.color, required this.active, super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 400),
      width: 44,
      height: 44,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: active ? color : const Color(0xFF1C1C1C),
        boxShadow: active
            ? [
                BoxShadow(
                  color: color.withValues(alpha: 0.4),
                  blurRadius: 20,
                  spreadRadius: 2,
                ),
              ]
            : [],
      ),
    );
  }
}
