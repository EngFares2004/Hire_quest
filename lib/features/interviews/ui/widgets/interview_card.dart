import 'package:flutter/material.dart';

import '../../../../configuration/theme/theme.dart';
import '../../../../configuration/widgets/customer_bottom.dart';
import '../../../../configuration/widgets/customer_sub_title.dart';

class InterviewCardWidget extends StatelessWidget {
  final String title;
  final String score;
  final String subtitle;
  final VoidCallback? onTap;

  const InterviewCardWidget({
    super.key,
    required this.title,
    required this.score,
    this.subtitle = '',
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color:theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.05),
            blurRadius: 6,
            offset: const Offset(0, 3),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SubTitle(
            title: title,
            size: 16,
            spacebtw: 6,
            space: 12,
            colorTitle: AppTheme.primary,
          ),
          SubTitle(
            title: score,
            size: 18,
            spacebtw: 6,
            space: 6,
            colorTitle: AppTheme.hinttextcolor,
          ),
          if (subtitle.isNotEmpty)
            SubTitle(
              title: subtitle,
              size: 12,
              spacebtw: 12,
              colorTitle: AppTheme.hinttextcolor,
              space: 0,
            ),
          if (onTap != null)
            CustomBottom(
              textSize: 14,
              textColor: AppTheme.primary,
              isOutline: true,
              title: 'View Report',
              onTap: onTap!,
            ),
        ],
      ),
    );
  }
}
