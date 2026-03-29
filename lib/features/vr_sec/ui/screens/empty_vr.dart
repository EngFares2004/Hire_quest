import 'package:flutter/material.dart';

import '../../../../configuration/route/route.dart';
import '../../../../configuration/widgets/customer_bottom.dart';
import '../../../../configuration/widgets/customer_sub_title.dart';
import '../widgets/header_vr_code.dart';

class EmptyVr extends StatelessWidget {
  const EmptyVr({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,

          children: [
            HeaderVrCode(title: 'Start Interview'),
            const SubTitle(
              isCenter: true,
                title: 'To access the full experience, you need to pair your VR headset with this account.',
                size: 16),
            const SizedBox(height: 16),
            CustomBottom(
              title: 'Pair New Device',
              onTap: () {
                Navigator.pushNamed(context, AppRoute.interviewCode);
              },
              textSize: 16,
            ),

          ],
        ),
      ),
    );
  }
}
