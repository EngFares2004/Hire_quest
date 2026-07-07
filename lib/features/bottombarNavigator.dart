import 'package:flutter/material.dart';
import 'package:hire_quest/features/account/ui/screens/profile_screen.dart';
import 'package:hire_quest/features/home/ui/screens/home_screen.dart';
import 'package:hire_quest/configuration/widgets/customer_sub_title.dart';
import 'package:hire_quest/features/leaderboard/ui/screens/leaderboard_screen.dart';
import 'package:hire_quest/generated/assets.dart';
import '../configuration/theme/theme.dart';
import 'interviews/ui/screens/interview_screen.dart';

class BottomBarNavigator extends StatefulWidget {
  const BottomBarNavigator({super.key});

  @override
  State<BottomBarNavigator> createState() => _BottomBarNavigatorState();
}

class _BottomBarNavigatorState extends State<BottomBarNavigator> {
  int currentIndex = 0;

  final List<Widget> pages = [
    const HomeScreen(),
    InterviewScreen(),
    LeaderboardScreen(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundWhite,
      body: pages[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (index) {
          setState(() => currentIndex = index);
        },

        elevation: 10,
        showUnselectedLabels: true,

        selectedItemColor: AppTheme.primary,
        unselectedItemColor: AppTheme.hinttextcolor,

        items: [
          /// 🏠 Home
          BottomNavigationBarItem(
            icon: Assets.icons.home.svg(
              width: 24,
              height: 24,
              color: currentIndex == 0
                  ? AppTheme.primary
                  : AppTheme.hinttextcolor,
            ),
            label: 'Home',
          ),

          /// 🎤 Interviews
          BottomNavigationBarItem(
            icon: Assets.icons.interviews.svg(
              width: 24,
              height: 24,
              color: currentIndex == 1
                  ? AppTheme.primary
                  : AppTheme.hinttextcolor,
            ),
            label: 'Interviews',
          ),

          /// 🧠 Practice
          BottomNavigationBarItem(
            icon: Assets.icons.leaderboard.svg(
              width: 24,
              height: 24,
              color: currentIndex == 2
                  ? AppTheme.primary
                  : AppTheme.hinttextcolor,
            ),
            label: 'leaderb',
          ),

          /// 👤 Profile
          BottomNavigationBarItem(
            icon: Assets.icons.profile.svg(
              width: 24,
              height: 24,
              color: currentIndex == 3
                  ? AppTheme.primary
                  : AppTheme.hinttextcolor,
            ),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}