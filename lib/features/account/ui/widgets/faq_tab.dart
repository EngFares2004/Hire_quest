import 'package:flutter/material.dart';
import 'package:hire_quest/configuration/theme/theme.dart';

class FaqTab extends StatelessWidget {
  const FaqTab({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final isDark = theme.brightness == Brightness.dark;

    final primaryColor = AppTheme.primary;

    final textColor = isDark ? AppTheme.darkGrey : primaryColor;

    final List<Map<String, String>> faqs = [
      {
        "q": "What is HireQuest?",
        "a": "HireQuest helps you prepare for interviews using AI."
      },
      {
        "q": "How can I contact support?",
        "a": "You can contact us via email from the Help section."
      },
      {
        "q": "Is the app free?",
        "a": "Yes, HireQuest has a free plan with premium options."
      },
      {
        "q": "How do I pair my VR headset with the app?",
        "a": "Go to the VR Integration section in your profile, ensure Bluetooth and Wi-Fi are enabled, and tap Scan for Devices."
      },
      {
        "q": "Does HireQuest work without a VR headset?",
        "a": "Yes, you can practice interviews in standard mode without VR."
      },
      {
        "q": "How is the interview difficulty determined?",
        "a": "Difficulty adapts dynamically based on your performance."
      },
      {
        "q": "Can I change the interview language?",
        "a": "Yes, you can change it from settings anytime."
      },
      {
        "q": "Are my interview sessions recorded?",
        "a": "Sessions are analyzed but not stored as raw recordings."
      },
    ];

    return ListView.builder(

      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
      itemCount: faqs.length,
      itemBuilder: (context, index) {
        return Card(
          elevation: 0,
          color: theme.colorScheme.surface,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Theme(
            data: theme.copyWith(dividerColor: Colors.transparent),
            child: ExpansionTile(
              tilePadding: const EdgeInsets.symmetric(horizontal: 16),
              title: Text(
                faqs[index]["q"]!,
                style: theme.textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: textColor,
                ),
              ),
              children: [
                Divider(
                  height: 1,
                  thickness: 1,
                  color: theme.dividerColor,
                ),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Text(
                    faqs[index]["a"]!,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: theme.textTheme.bodyMedium?.color,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
