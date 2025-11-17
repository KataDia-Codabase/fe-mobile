import 'package:flutter/material.dart';
import '../../../../../core/theme/index.dart';

class IconBubble extends StatelessWidget {
  final Color color;
  final IconData icon;
  final Color iconColor;
  final double size;

  const IconBubble({
    super.key,
    required this.color,
    required this.icon,
    required this.iconColor,
    this.size = 56,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: color.withValues(alpha: 0.25),
            blurRadius: AppSpacing.iconLarge,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Icon(icon, color: iconColor, size: size * 0.45),
    );
  }
}
