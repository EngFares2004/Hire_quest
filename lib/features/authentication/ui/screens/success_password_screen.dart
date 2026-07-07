import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../configuration/route/route.dart';
import '../../../../configuration/theme/theme.dart';
import '../../../../configuration/widgets/customer_bottom.dart';
import '../../../../generated/assets.dart';

class SuccessPasswordScreen extends StatelessWidget {
  const SuccessPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            const SizedBox(height: 40),
            Assets.images.authentication.svg(

              height: MediaQuery.of(context).size.height * 0.40,
              //color: AppTheme.primary,
            ),


            const SizedBox(height: 20),

            const Text(
              'Password changed',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.w700,
                color: AppTheme.primary,
              ),
            ),

            const SizedBox(height: 8),

            Text(
              'Your password has been changed successfully',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: AppTheme.secondary,
                fontWeight: FontWeight.w500,
              ),
            ),

            const SizedBox(height: 40),

            SizedBox(
              width: double.infinity,
              child: CustomBottom(
                title: 'Back to login',
                color: AppTheme.primary,
                onTap: () {
                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    AppRoute.login,
                        (route) => false,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
