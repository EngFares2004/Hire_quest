import 'package:flutter/material.dart';
import 'package:hire_quest/configuration/theme/theme.dart';

import '../../data/model/leaderboard_user.dart';
import 'user_avatar.dart';

class LeaderboardListTile extends StatelessWidget {
  final LeaderboardUser user;

  const LeaderboardListTile({
    super.key,
    required this.user,
  });

  Color get rankColor {
    switch (user.rank) {
      case 1:
        return  Colors.green;
      case 2:
        return const Color(0xffC0C0C0);
      case 3:
        return const Color(0xffCD7F32);
      default:
        return AppTheme.primary;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 6,
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: 14,
        vertical: 12,
      ),
      decoration: BoxDecoration(
        color: AppTheme.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.05),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          //================ Rank =================

          SizedBox(
            width: 40,
            child: Text(
              "#${user.rank}",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: rankColor,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ),

          const SizedBox(width: 12),

          //================ Avatar =================

          UserAvatar(
            avatarUrl: user.profilePictureUrl,
            size: 52,
            borderColor: rankColor,
            borderWidth: 2,
          ),

          const SizedBox(width: 12),

          //================ Name =================

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  user.fullName,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 15,
                    color: AppTheme.primary,
                  ),
                ),

                const SizedBox(height: 4),

                Text(
                  user.userLevel,
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 12,
                  ),
                ),

                const SizedBox(height: 2),

                Text(
                  "${user.completedSessions} Sessions",
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 11,
                  ),
                ),
              ],
            ),
          ),

          //================ Score =================

          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                "${user.averageScore.toStringAsFixed(1)}%",
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: AppTheme.primary,
                ),
              ),

              const SizedBox(height: 4),

              Text(
                "Best ${user.highestScore}",
                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 11,
                ),
              ),

              const SizedBox(height: 2),

              Text(
                "${user.currentStreakDays} 🔥",
                style: const TextStyle(
                  fontSize: 11,
                  color: Colors.orange,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}