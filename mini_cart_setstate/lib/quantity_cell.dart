import 'package:flutter/material.dart';

class QuantityCell extends StatelessWidget {
  final int quantity;
  final ValueChanged<int> onChanged;

  const QuantityCell({
    super.key,
    required this.quantity,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        _CircleButton(
          icon: Icons.remove_rounded,
          onTap: () => onChanged(quantity - 1),
          filled: false,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14),
          child: Text(
            '$quantity',
            style: const TextStyle(
              color: Color(0xFF1A1A1A),
              fontSize: 15,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        _CircleButton(
          icon: Icons.add_rounded,
          onTap: () => onChanged(quantity + 1),
          filled: true,
        ),
      ],
    );
  }
}

class _CircleButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  final bool filled;

  const _CircleButton({
    required this.icon,
    required this.onTap,
    required this.filled,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 32,
        height: 32,
        decoration: BoxDecoration(
          color: filled ? const Color(0xFF1A1A1A) : const Color(0xFFF0EDEA),
          shape: BoxShape.circle,
        ),
        child: Icon(
          icon,
          size: 16,
          color: filled ? Colors.white : const Color(0xFF1A1A1A),
        ),
      ),
    );
  }
}
