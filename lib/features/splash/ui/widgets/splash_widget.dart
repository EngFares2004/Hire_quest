import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../configuration/theme/theme.dart';
import '../../../../generated/assets.dart';
import '../../models/splash_model.dart';


class SplashWidget extends StatelessWidget {
  final SplashModel data;

  const SplashWidget({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Padding(

          padding: const EdgeInsets.symmetric(horizontal: 20),

      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
          data.title,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w700,
            color: AppTheme.primary
          ),
        ),
          const SizedBox(height: 8),

            Text(
              data.subtitle,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: AppTheme.secondary,
                fontWeight: FontWeight.w500,
              ),
            ),
          const SizedBox(height: 4),

          data.image.svg(
            height: MediaQuery.of(context).size.height * 0.40,
          ),


        ],
      ),
    );
  }
}
