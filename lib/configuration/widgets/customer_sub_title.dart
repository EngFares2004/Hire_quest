import 'package:flutter/material.dart';
import '../theme/theme.dart';

class SubTitle extends StatelessWidget {
  final String title;
  final Color? colorTitle;
 final double space;
 final bool isCenter ;
 final double spacebtw;
 final double size;
  const SubTitle({
    super.key,
    required this.title,
    this.colorTitle,
    this.space = 32,
    this.spacebtw =8,
    this.size =20,
    this.isCenter =false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final isDark = theme.brightness == Brightness.dark;

    final primaryColor = AppTheme.primary;

    final textColor = isDark ? AppTheme.darkGrey : primaryColor;
    return
       Column(
         children: [
           SizedBox(height: space),
           Text(
            title,
            style:  TextStyle(
              color:colorTitle ?? textColor,
              fontWeight: FontWeight.w500,
              fontSize: size,
            ),
             textAlign:isCenter? TextAlign.center: TextAlign.left,
               ),
           SizedBox(height:spacebtw),
         ],
       );
  }
}
