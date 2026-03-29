import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hire_quest/configuration/widgets/customer_arrow_back.dart';
import '../../../../configuration/theme/theme.dart';
import '../../../../configuration/widgets/customer_bottom.dart';
import '../../../../generated/assets.dart';

class VrIntegrationScreen extends StatelessWidget {
  const VrIntegrationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(


      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
           CustomerArrowBack(
             title: "VR Integration",
           ),
             Spacer(),
             Center(
               child: SvgPicture.asset(
                Assets.iconsIconApp,
                width:70,
                height: 70,
                color: AppTheme.primary,
                           ),
             ),

            const SizedBox(height: 24),

            Center(
              child: const Text(
                "Virtual Reality Interviews",
                style: TextStyle(
                  color: AppTheme.primary,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),

            const SizedBox(height: 12),

            Center(
              child: const Text(
                "Soon, you'll be able to experience immersive AI-powered interviews using VR technology.\n\n"
                    "Practice real-world interview scenarios in a virtual environment.",
                textAlign: TextAlign.center,
                style: TextStyle(color:AppTheme.secondary),
              ),
            ),

            const Spacer(),

            CustomBottom(
              title: "Notify Me When Available",
              textSize: 16,
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("You’ll be notified once VR is available 🚀",style:
                    TextStyle(color: AppTheme.white, backgroundColor: AppTheme.primary),),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
