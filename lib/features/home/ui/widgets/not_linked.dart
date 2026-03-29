import 'package:flutter/material.dart';
import 'package:hire_quest/configuration/widgets/customer_sub_title.dart';
import '../../../../configuration/route/route.dart';
import '../../../../configuration/theme/theme.dart';
import '../../../../configuration/widgets/customer_bottom.dart';

class NotLinkedBottomSheet {
  static void show(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [

              Container(
                width: 80,
                height: 5,
                margin: const EdgeInsets.only(bottom: 12),
                decoration: BoxDecoration(
                  color: AppTheme.grey,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),

              const SizedBox(height: 24),

              Icon(
                Icons.error_outline_outlined,
                color: AppTheme.error,
                size: 50,
              ),

              SubTitle(
                title: "VR Headset Not Linked",
                spacebtw: 0,
                space: 16,
                size: 18,
                colorTitle: AppTheme.error,
              ),

              SubTitle(
                title: "To start interview, you need to link your VR",
                spacebtw: 16,
                space: 16,
                isCenter: true,
              ),

              const SizedBox(height: 10),

              CustomBottom(
                title: 'Link Headset Now',

                textSize: 16,
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pushReplacementNamed(
                    context,
                    AppRoute.interviewCode,
                  );
                },
              ),

              const SizedBox(height: 10),
            ],
          ),
        );
      },
    );
  }
}