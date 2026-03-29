import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hire_quest/configuration/widgets/customer_title.dart';

import '../../../../configuration/route/route.dart';
import '../../../../configuration/theme/theme.dart';
import '../../../../configuration/widgets/customer_bottom.dart';
import '../../../../configuration/widgets/customer_sub_title.dart';
import '../../../../generated/assets.dart';
import '../widgets/header_vr_code.dart';

class AddVr extends StatelessWidget {
  final Map<String, dynamic> device;

  const AddVr({super.key, required this.device});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final deviceName = device["deviceName"] ?? "Unknown Device";
    final platform = device["platform"] ?? "";
    final lastUsed = device["lastUsedAt"];

    String lastUsedText = "";

    if (lastUsed != null) {
      final date = DateTime.parse(lastUsed);
      final difference = DateTime.now().difference(date).inMinutes;
      lastUsedText = "Last synced: $difference minutes ago";
    }

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            HeaderVrCode(title: 'Start Interview'),
            const SizedBox(height: 16),

            CustomBottom(
              title: 'Pair New Device',
              onTap: () {
                Navigator.pushNamed(context, AppRoute.interviewCode);
              },
              textSize: 16,
            ),

            const Divider(height: 16),
            SubTitle(title: 'Device Status'),

            Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: Card(
                margin:
                const EdgeInsets.symmetric(vertical: 4, horizontal: 12),
                color: theme.colorScheme.surface,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
                child: ListTile(
                  leading: SvgPicture.asset(
                    Assets.iconsVrGlasses,
                    width: 32,
                    height: 32,
                    color: AppTheme.primary,
                  ),
                  title: CustomerTitle(
                    title: "$deviceName ($platform)",
                    desc: lastUsedText,
                    descSize: 10,
                    sizeTitle: 14,
                  ),
                  trailing: SvgPicture.asset(
                    Assets.iconsLogout,
                    width: 28,
                    height: 28,
                    color: AppTheme.error,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}