import 'package:flutter/material.dart';
import 'package:hire_quest/configuration/theme/theme.dart';
import '../../data/model/leaderboard_user.dart';
import 'user_avatar.dart';

class TopThreePodium extends StatelessWidget {
  final List<LeaderboardUser> topThree;

  const TopThreePodium({
    super.key,
    required this.topThree,
  });

  @override
  Widget build(BuildContext context) {
    if (topThree.length < 3) {
      return const SizedBox.shrink();
    }

    final rank1 = topThree.firstWhere((e) => e.rank == 1);
    final rank2 = topThree.firstWhere((e) => e.rank == 2);
    final rank3 = topThree.firstWhere((e) => e.rank == 3);

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 8,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          _PodiumUser(
            user: rank2,
            avatarSize: 72,
          ),

          _PodiumUser(
            user: rank1,
            avatarSize: 90,
            showCrown: true,
          ),

          _PodiumUser(
            user: rank3,
            avatarSize: 72,
          ),
        ],
      ),
    );
  }
}

class _PodiumUser extends StatelessWidget {
  final LeaderboardUser user;
  final double avatarSize;
  final bool showCrown;

  const _PodiumUser({
    required this.user,
    required this.avatarSize,
    this.showCrown = false,
  });

  Color get medalColor {
    switch (user.rank) {
      case 1:
        return const Color(0xffFFD700);

      case 2:
        return const Color(0xffC0C0C0);

      default:
        return const Color(0xffCD7F32);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          clipBehavior: Clip.none,
          alignment: Alignment.center,
          children: [
            UserAvatar(
              avatarUrl: user.profilePictureUrl,
              size: avatarSize,
              borderColor: medalColor,
              borderWidth: 3,
            ),

            if (showCrown)
              const Positioned(
                top: -18,
                child: Icon(
                  Icons.emoji_events,
                  color: Color(0xffFFD700),
                  size: 28,
                ),
              ),

            Positioned(
              bottom: -8,
              child: Container(
                width: 26,
                height: 26,
                decoration: BoxDecoration(
                  color: medalColor,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: AppTheme.white,
                    width: 2,
                  ),
                ),
                alignment: Alignment.center,
                child: Text(
                  "${user.rank}",
                  style: const TextStyle(
                    color: AppTheme.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),

        const SizedBox(height: 16),

        SizedBox(
          width: 95,
          child: Text(
            user.fullName,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 14,
            ),
          ),
        ),

        const SizedBox(height: 4),

        Text(
          "${user.averageScore.toStringAsFixed(1)}%",
          style: const TextStyle(
            color: AppTheme.grey,
            fontSize: 12,
          ),
        ),

        const SizedBox(height: 2),

        Text(
          user.userLevel,
          style: const TextStyle(
            fontSize: 11,
            color: Colors.blueGrey,
          ),
        ),
      ],
    );
  }
}