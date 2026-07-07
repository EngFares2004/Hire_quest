import 'package:flutter/material.dart';
import '../theme/theme.dart';

class CustomerTitle extends StatelessWidget {
  final String title;
  final String desc;
 final double sizeTitle;
  final double descSize;
  final bool height;
  final Color? colorTitle;
  final Color colorSubtitle;

  const CustomerTitle({
    super.key,
    required this.title,
    required this.desc,
    this.sizeTitle = 32,
    this.height = true,
    this.descSize = 12,
    this.colorTitle,
    this.colorSubtitle = AppTheme.secondary,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final isDark = theme.brightness == Brightness.dark;

    final primaryColor = AppTheme.primary;

    final textColor = isDark ? AppTheme.darkGrey : primaryColor;
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: sizeTitle,
            fontWeight: FontWeight.w700,
            color: colorTitle ?? textColor,
          ),
        ),
        SizedBox(height: height ? 8 : 0),
        Text(
          desc,
          style: TextStyle(
            fontSize: descSize,
            color: colorSubtitle,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
