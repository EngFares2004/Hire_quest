import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../generated/assets.dart';

class SocialMediaAuth extends StatelessWidget {
  final String title;
  const SocialMediaAuth({super.key, required this.title});

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
                color: theme.dividerColor, // 👈 Theme Aware
                thickness: 1,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Text(
                ' Or $title with ',
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.textTheme.bodyMedium?.color, // 👈 Theme Aware
                  fontWeight: FontWeight.w400,
                  fontSize: 15,
                ),
              ),
            ),
            Expanded(
              child: Divider(
                color: theme.dividerColor, // 👈 Theme Aware
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
            _socialButton(context, Assets.iconsLinkedIn),
            _socialButton(context, Assets.iconsGoogle),
            _socialButton(context, Assets.iconsGithub),
          ],
        ),
      ],
    );
  }

  Widget _socialButton(BuildContext context, String asset) {
    
    final theme = Theme.of(context);
    final double width = MediaQuery.of(context).size.width / 4;

    return Container(
      height: 60,
      width: width,
      padding: const EdgeInsets.all(13.0),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface.withOpacity(0.1), // 👈 Theme Aware
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: theme.dividerColor), // 👈 Theme Aware
      ),
      child: Center(
        child: SvgPicture.asset(
          asset,
          height: 24,
          width: 24,
         // color: theme.iconTheme.color, // 👈 Theme Aware
        ),
      ),
    );
  }
}
