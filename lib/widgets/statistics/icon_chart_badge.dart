import 'package:flutter/material.dart';
import 'package:personal_finance/theme/colors.dart';

class IconChartBadge extends StatelessWidget {
  final IconData iconData;
  final Color? color;
  const IconChartBadge({super.key, required this.iconData, this.color});

  @override
  Widget build(BuildContext context) {
    final customColors = Theme.of(context).extension<CustomColors>()!;

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: customColors.chartBadgeShadow,
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
