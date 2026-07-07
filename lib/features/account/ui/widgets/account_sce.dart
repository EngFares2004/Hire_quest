import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../configuration/theme/theme.dart';
import '../../../../configuration/widgets/customer_title.dart';
import '../../../home/bloc/home_cubit/home_cubit.dart';
import '../../../home/bloc/home_cubit/home_state.dart';
import '../cubit/profile_edit_cubit/profile_edit_cubit.dart';
import '../cubit/profile_edit_cubit/profile_edit_state.dart';

class AccountTile extends StatelessWidget {
  const AccountTile({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BlocBuilder<ProfileEditCubit, ProfileEditState>(
      builder: (context, profileState) {
        final profileCubit = context.read<ProfileEditCubit>();

        return BlocBuilder<HomeCubit, HomeState>(
          builder: (context, homeState) {
            if (homeState is! HomeLoaded) {
              return const SizedBox();
            }

            final home = homeState.data;

            return Container(
              padding: const EdgeInsets.all(8),
              margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: theme.colorScheme.surface,
                borderRadius: BorderRadius.circular(14),
                boxShadow: [
                  BoxShadow(
                    color: theme.brightness == Brightness.dark
                        ? Colors.black54
                        : Colors.black12,
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: ListTile(
                leading: CircleAvatar(
                  radius: 40,
                  backgroundImage: profileCubit.getProfileImage(),
                  backgroundColor: AppTheme.grey,
                ),

                title: CustomerTitle(
                  title: home.userName,
                  desc: "${home.role} • ${home.level}",
                  descSize: 14,
                  sizeTitle: 20,
                  height: false,
                ),

                onTap: () => _showProfileDialog(context, profileCubit, home),
              ),
            );
          },
        );
      },
    );
  }

  void _showProfileDialog(
    BuildContext context,
    ProfileEditCubit profileCubit,
    home,
  ) {
    showDialog(
      context: context,
      builder: (_) {
        final theme = Theme.of(context);

        final isDark = theme.brightness == Brightness.dark;

        final primaryColor = AppTheme.primary;

        final textColor = isDark ? AppTheme.darkGrey : primaryColor;
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircleAvatar(
                  radius: 60,
                  backgroundImage: profileCubit.getProfileImage(),
                  backgroundColor: AppTheme.grey,
                ),

                const SizedBox(height: 16),

                Text(
                  home.userName,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: textColor,
                  ),
                ),

                const SizedBox(height: 8),

                Text(
                  "${home.role} • ${home.level}",
                  style: const TextStyle(fontSize: 14, color: AppTheme.hinttextcolor),
                  textAlign: TextAlign.center,
                ),

                const SizedBox(height: 20),

                ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    minimumSize: const Size(120, 40),
                  ),
                  child: const Text(
                    "Close",
                    style: TextStyle(color: AppTheme.white),
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
