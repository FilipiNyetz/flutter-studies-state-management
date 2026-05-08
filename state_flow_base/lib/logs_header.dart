import 'package:flutter/material.dart';
import 'package:state_flow_base/state_flow.dart';

class LogsHeader extends StatelessWidget {
  final List<StatusLog> statusLog;
  const LogsHeader({super.key, required this.statusLog});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          "HISTÓRICO",
          style: TextStyle(
            color: Color(0xFF444444),
            fontSize: 11,
            letterSpacing: 2,
            fontWeight: FontWeight.w500,
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          decoration: BoxDecoration(
            color: const Color(0xFF1A1A1A),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            "${statusLog.length} ${statusLog.length == 1 ? 'evento' : 'eventos'}",
            style: const TextStyle(color: Color(0xFF444444), fontSize: 12),
          ),
        ),
      ],
    );
  }
}
