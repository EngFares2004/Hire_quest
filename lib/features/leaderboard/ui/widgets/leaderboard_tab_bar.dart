import 'package:flutter/material.dart';

import '../../../../configuration/theme/theme.dart';
import '../cubit/leaderboard_cubit/leaderboard_cubit.dart';

class LeaderboardTabBar extends StatelessWidget {
  final LeaderboardTab selected;
  final ValueChanged<LeaderboardTab> onTab;

  const LeaderboardTabBar({
    super.key,
    required this.selected,
    required this.onTab,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 12,
      ),
      child: Container(
        height: 48,
        decoration: BoxDecoration(
          color: AppTheme.white,
          borderRadius:
          BorderRadius.circular(14),
          boxShadow: [
            BoxShadow(
              color: Colors.black
                  .withOpacity(.05),
              blurRadius: 6,
              offset:
              const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            Expanded(
              child: _TabItem(
                title: "Daily",
                selected: selected == LeaderboardTab.daily,
                onTap: () => onTab(LeaderboardTab.daily),
              ),
            ),
            Expanded(
              child: _TabItem(
                title: "Monthly",
                selected: selected == LeaderboardTab.monthly,
                onTap: () => onTab(LeaderboardTab.monthly),
              ),
            ),
            Expanded(
              child: _TabItem(
                title: "All Time",
                selected: selected == LeaderboardTab.allTime,
                onTap: () => onTab(LeaderboardTab.allTime),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TabItem extends StatelessWidget {
  final String title;
  final bool selected;
  final VoidCallback onTap;

  const _TabItem({
    required this.title,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        margin: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: selected
              ? const Color(0xff1A2B5F)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(10),
        ),
        alignment: Alignment.center,
        child: Text(
          title,
          style: TextStyle(
            color: selected
                ? AppTheme.white
                :AppTheme.hinttextcolor,
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}