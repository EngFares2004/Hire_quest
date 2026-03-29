import 'package:flutter/material.dart';

import '../theme/theme.dart';

class CustomerArrowBack extends StatelessWidget {
  final String? title;

  const CustomerArrowBack({
    super.key,
    this.title = '',
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 32),
        Row(
          children: [
            GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Container(
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                  color: theme.colorScheme.surface,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: theme.dividerColor,
                  ),
                ),
                child: Icon(
                  Icons.arrow_back_ios_new,
                  color: AppTheme.primary,
                ),
              ),
            ),
            const Spacer(),
            Text(
              title ?? '',
              style: theme.textTheme.headlineSmall?.copyWith(
                color:AppTheme.primary,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Spacer(),
          ],
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}
