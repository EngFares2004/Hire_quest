import 'package:flutter/material.dart';

import '../../../../configuration/widgets/customer_arrow_back.dart';
import '../../../../generated/assets.dart';

class HeaderVrCode extends StatelessWidget {
  final String title;
  const HeaderVrCode({super.key,required this.title});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
         CustomerArrowBack(title: title),
        SizedBox(height: 40,),
        Center(
          child:Assets.images.interviewer.image(
            width: 250,
            height: 250,

          ),

        ),
      ],
    );
  }
}
