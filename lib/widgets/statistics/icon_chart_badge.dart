import 'package:flutter/material.dart';

class IconChartBadge extends StatelessWidget {
  final IconData iconData;
  final Color? color;
  const IconChartBadge({super.key, required this.iconData, this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withAlpha(128),
            spreadRadius: 2,
            blurRadius: 2,
          )
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(4),
        child: Icon(iconData, size: 16, color: color),
      ),
    );
  }
}
