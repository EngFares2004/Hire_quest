import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../configuration/theme/theme.dart';
import '../../../../configuration/widgets/customer_title.dart';
import '../../../../generated/assets.dart';
import '../cubit/profile_edit_cubit/profile_edit_cubit.dart';
import '../cubit/profile_edit_cubit/profile_edit_state.dart';

class AccountTile extends StatelessWidget {
  const AccountTile({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BlocBuilder<ProfileEditCubit, ProfileEditState>(
      builder: (context, state) {
        final cubit = context.read<ProfileEditCubit>();

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
              backgroundImage: cubit.getProfileImage(),
              backgroundColor: AppTheme.grey,
            ),
            title: CustomerTitle(
              title:state.profile?.fullName??'user dev',
              desc: "Flutter Developer • Junior Level",
              descSize: 9,
              sizeTitle: 14,
              height: false,
            ),
            onTap: () => _showProfileDialog(context, cubit),
          ),
        );
      },
    );
  }

  void _showProfileDialog(BuildContext context, ProfileEditCubit cubit) {
    final state = cubit.state;
    final fullName = context.read<ProfileEditCubit>().state.profile?.fullName ?? "user dev";
     showDialog(
        context: context,
        builder: (_) {
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
                backgroundImage: cubit.getProfileImage(),
                backgroundColor: AppTheme.grey,
              ),
              const SizedBox(height: 16),
              Text(
                    fullName,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.primary,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                "Flutter Developer • Junior Level",
                style: TextStyle(fontSize: 14, color: AppTheme.grey),
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