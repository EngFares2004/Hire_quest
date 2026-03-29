

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hire_quest/features/account/ui/screens/profile_screen.dart';
import 'package:hire_quest/features/home/ui/screens/home_screen.dart';
import 'package:hire_quest/configuration/widgets/customer_sub_title.dart';
import 'package:hire_quest/generated/assets.dart';
import '../configuration/theme/theme.dart';
import 'interviews/ui/screens/interview_Screen.dart';


class BottomBarNavigator extends StatefulWidget {
  const BottomBarNavigator({super.key});

  @override
  State<BottomBarNavigator> createState() => _BottomBarNavigatorState();
}

class _BottomBarNavigatorState extends State<BottomBarNavigator> {
  int currentIndex = 0;

  List<Widget> pages = [
    const HomeScreen(),
    InterviewScreen(),
    Center(child: SubTitle(title: 'Practice'),),
    const ProfileScreen(),


  ];

  @override
  Widget build(BuildContext context, ) {

    return Scaffold(
      backgroundColor: AppTheme.backgroundWhite,
      body: pages[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: AppTheme.primary,
        unselectedItemColor: AppTheme.hinttextcolor,
        currentIndex: currentIndex,
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        elevation: 10,
        showUnselectedLabels: true,
        selectedLabelStyle: const TextStyle(color: AppTheme.primary,),
        unselectedLabelStyle: const TextStyle(color:AppTheme.hinttextcolor),
        items: [
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              Assets.iconsHome,
              width: 24,
              height: 24,
              color: currentIndex == 0 ? AppTheme.primary : AppTheme.hinttextcolor,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              Assets.iconsInterviews,
              width: 24,
              height: 24,
              color: currentIndex == 1 ? AppTheme.primary :AppTheme.hinttextcolor,
            ),
            label: 'Interviews',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              Assets.iconsPractice,
              width: 24,
              height: 24,

              color: currentIndex == 2 ? AppTheme.primary : AppTheme.hinttextcolor,
            ),
            label: 'Practice',
          ),

          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              Assets.iconsProfile,
              width: 24,
              height: 24,
              color: currentIndex == 3 ? AppTheme.primary :AppTheme.hinttextcolor,
            ),
            label: 'Profile',
          ),
        ],
      ),

    );
  }
}
