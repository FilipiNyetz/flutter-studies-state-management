import 'package:flutter/material.dart';
import 'package:state_flow_base/state_flow.dart';

class CardLogs extends StatelessWidget {
  final StatusLog statusLog;

  const CardLogs({super.key, required this.statusLog});

  Color get _dotColor {
    switch (statusLog.logState) {
      case .green:
        return const Color(0xFF3DFF8F);
      case .yellow:
        return const Color(0xFFFFD93D);
      case .red:
        return const Color(0xFFFF4D4D);
    }
  }

  String get _formattedTime {
    final h = statusLog.logDate.hour.toString().padLeft(2, '0');
    final m = statusLog.logDate.minute.toString().padLeft(2, '0');
    final s = statusLog.logDate.second.toString().padLeft(2, '0');
    return "$h:$m:$s";
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: const Color(0xFF111111),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFF1E1E1E)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                  color: _dotColor,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: _dotColor.withValues(alpha: 0.5),
                      blurRadius: 6,
                      spreadRadius: 1,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 10),
              Text(
                statusLog.logState.name,
                style: const TextStyle(
                  color: Color(0xFFCCCCCC),
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          Text(
            _formattedTime,
            style: const TextStyle(
              color: Color(0xFF444444),
              fontSize: 12,
              fontFeatures: [FontFeature.tabularFigures()],
            ),
          ),
        ],
      ),
    );
  }
}
