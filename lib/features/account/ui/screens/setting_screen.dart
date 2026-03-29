import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hire_quest/configuration/widgets/custom_logout.dart';

import '../../../../configuration/route/route.dart';
import '../../../../configuration/theme/theme.dart';
import '../../../../configuration/theme/theme_cubit.dart';
import '../../../../configuration/widgets/customer_arrow_back.dart';
import '../../../../generated/assets.dart';
import '../widgets/add_account_screen.dart';
import '../../../../configuration/widgets/custom_build_tile.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool isDarkMode = false;
  bool notificationsEnabled = true;
  bool soundEnabled = true;

  String language = "English";

  Widget sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 24, 16, 8),
      child: Text(
        title.toUpperCase(),
        style: TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.bold,
          color: AppTheme.grey,
        ),
      ),
    );
  }

  void _showLanguageDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Select Language"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            RadioListTile(
              title: const Text("English"),
              value: "English",
              groupValue: language,
              onChanged: (value) {
                setState(() => language = value!);
                Navigator.pop(context);
              },
            ),
            RadioListTile(
              title: const Text("Arabic"),
              value: "Arabic",
              groupValue: language,
              onChanged: (value) {
                setState(() => language = value!);
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }

  void _confirmDeleteAccount() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Delete Account"),
        content: const Text("Are you sure you want to delete your account?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          TextButton(
            onPressed: () {
              // هنا تحط كود حذف الحساب
              Navigator.pop(context);
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(const SnackBar(content: Text("Account deleted")));
            },
            child: const Text("Delete", style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  void _addAccount() {
    // هنا تحط كود إضافة الحساب
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text("Add Account clicked")));
  }

  @override
  Widget build(BuildContext context) {
    final themeMode = context.watch<ThemeCubit>().state;

    return Scaffold(
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: CustomerArrowBack(title: "Settings"),
          ),

          // -------- Account --------
          sectionTitle("Account"),

          CustomBuildTile(
            icon: Icons.person_2,
            title: "Add Account",
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const AddAccountScreen(),
                ),
              );
            },
          ),

          CustomBuildTile(
            icon: Icons.delete_outline,
            title: "Delete Account",
            onTap: _confirmDeleteAccount,
          ),

          // -------- Preferences --------
          sectionTitle("Preferences"),

          CustomBuildTile(
            isTrailing: true,
            icon: Icons.language,
            title: "Language",
            trailing: Text(
              language,
              style: const TextStyle(color: AppTheme.grey),
            ),
            onTap: _showLanguageDialog,
          ),

          CustomBuildTile(
            isTrailing: true,
            icon: themeMode == ThemeMode.dark
                ? Icons.dark_mode
                : Icons.light_mode,
            title: "Dark Mode",
            trailing: Switch(
              value: themeMode == ThemeMode.dark,
              onChanged: (value) {
                context.read<ThemeCubit>().changeTheme(
                  value ? ThemeMode.dark : ThemeMode.light,
                );
              },
            ),
          ),

          // -------- Notifications --------
          sectionTitle("Notifications"),

          CustomBuildTile(
            icon: Icons.notifications_active_outlined,
            title: "Notifications",
            isTrailing: true,
            trailing: Switch(
              value: notificationsEnabled,
              activeColor: AppTheme.primary,
              onChanged: (value) {
                setState(() => notificationsEnabled = value);
              },
            ),
          ),

          CustomBuildTile(
            isTrailing: true,
            icon: Icons.volume_up_outlined,
            title: "App Sounds",
            trailing: Switch(
              value: soundEnabled,
              activeColor: AppTheme.primary,
              onChanged: (value) {
                setState(() => soundEnabled = value);
              },
            ),
          ),

          // -------- Support --------
          sectionTitle("Support"),

          CustomBuildTile(
            icon: Icons.info_outline,
            title: "About HireQuest",
            onTap: () {
              showAboutDialog(
                context: context,
                applicationName: "HireQuest",
                applicationVersion: "v1.0.0",
                applicationIcon: SvgPicture.asset(
                  Assets.iconsVrGlasses,
                  width: 32,
                  height: 32,
                  color: Theme.of(context).colorScheme.primary, // 👈 Theme Aware
                ),
                children: [
                  Text(
                    "HireQuest helps you prepare for interviews using AI-driven questions.",
                    style: TextStyle(
                      color: Theme.of(context).textTheme.bodyMedium?.color,
                    ),
                  ),
                ],
              );
            },
          ),

          const SizedBox(height: 32),

          CustomLogout(),
        ],
      ),
    );
  }
}
