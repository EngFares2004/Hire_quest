import 'package:flutter/material.dart';
import '../../../../generated/assets.dart';

class SocialMediaAuth extends StatelessWidget {
  final String title;

  const SocialMediaAuth({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      children: [
        const SizedBox(height: 30),

        /// Divider + Title
        Row(
          children: [
            Expanded(
              child: Divider(
                color: theme.dividerColor,
                thickness: 1,
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Text(
                ' Or $title with ',
                style: theme.textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w400,
                  fontSize: 15,
                ),
              ),
            ),

            Expanded(
              child: Divider(
                color: theme.dividerColor,
                thickness: 1,
              ),
            ),
          ],
        ),

        const SizedBox(height: 20),

        /// Social Buttons
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _socialButton(context, Assets.icons.linkedIn),
            _socialButton(context, Assets.icons.google),
            _socialButton(context, Assets.icons.github),
          ],
        ),
      ],
    );
  }

  Widget _socialButton(BuildContext context, SvgGenImage asset) {
    final theme = Theme.of(context);
    final double width = MediaQuery.of(context).size.width / 4;

    return Container(
      height: 60,
      width: width,
      padding: const EdgeInsets.all(13),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: theme.dividerColor),
      ),
      child: Center(
        child: asset.svg(
          height: 24,
          width: 24,
          color: theme.iconTheme.color,
        ),
      ),
    );
  }
}