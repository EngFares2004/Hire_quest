import 'package:flutter/material.dart';
import 'package:hire_quest/configuration/theme/theme.dart';

class CustomBottom extends StatelessWidget {
  final GestureTapCallback onTap;
  final String title;

  final Color? color;
  final Color? textColor;
  final double textSize;

  final bool isDisabled;
  final bool isOutline;

  const CustomBottom({
    super.key,
    required this.title,
    required this.onTap,
    this.color=AppTheme.primary,
    this.textColor,
    this.textSize = 20,
    this.isDisabled = false,
    this.isOutline = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);


    final buttonTextColor = isDisabled
        ? theme.hintColor
        : (textColor ??
        (isOutline
            ? theme.colorScheme.primary
            : AppTheme.white));

    return InkWell(
      onTap: isDisabled ? null : onTap,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        height: 60,
        width: double.infinity,
        padding: const EdgeInsets.all(13.0),
        decoration: BoxDecoration(
          color: isOutline ? Colors.transparent : color,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: color!,
          ),
        ),
        child: Center(
          child: Text(
            title,
            style: theme.textTheme.titleMedium?.copyWith(
              fontSize: textSize,
              fontWeight: FontWeight.w500,
              color: buttonTextColor,
            ),
          ),
        ),
      ),
    );
  }
}
