import 'package:flutter/material.dart';

import '../../../../configuration/theme/theme.dart';
import '../../../../configuration/widgets/customer_sub_title.dart';

class ScoreCard extends StatelessWidget {
  final String title;
  final String value;

  const ScoreCard({
    super.key,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      width: 140,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical:12),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SubTitle(
            isCenter: true,
            title: title,
            size: 12,
            spacebtw: 4,
            space: 0,
            colorTitle: AppTheme.primary,
          ),
          const SizedBox(height: 10),
          SubTitle(
            isCenter: true,
            title: value,
            size: 18,
            spacebtw: 0,
            space: 0,
            colorTitle: AppTheme.hinttextcolor,
          ),
        ],
      ),
    );
  }
}