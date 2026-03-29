import 'package:flutter/material.dart';
import '../theme/theme.dart';

class CustomerTitle extends StatelessWidget {
  final String title;
  final String desc;
  double sizeTitle = 32;
  final double descSize ;
  bool height ;
  Color colorTitle;
  Color colorSubtitle;

  CustomerTitle({
    super.key,
    required this.title,
    required this.desc,
    this.sizeTitle = 32,
    this.height=true,
    this.descSize=12,
    this.colorTitle = AppTheme.primary,
    this.colorSubtitle = AppTheme.secondary,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: sizeTitle,
            fontWeight: FontWeight.w700,
            color: colorTitle,
          ),
        ),
          SizedBox(height: height ? 8 : 0 ),
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
