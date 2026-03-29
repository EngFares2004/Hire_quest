import 'package:flutter/material.dart';
import '../theme/theme.dart';

class SubTitle extends StatelessWidget {
  final String title;
  final Color colorTitle;
 final double space;
 final bool isCenter ;
 final double spacebtw;
 final double size;
  const SubTitle({
    super.key,
    required this.title,
    this.colorTitle= AppTheme.primary,
    this.space = 32,
    this.spacebtw =8,
    this.size =20,
    this.isCenter =false,
  });

  @override
  Widget build(BuildContext context) {
    return
       Column(
         children: [
           SizedBox(height: space),
           Text(
            title,
            style:  TextStyle(
              color:colorTitle,
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
