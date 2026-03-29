import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hire_quest/configuration/route/route.dart';
import 'package:hire_quest/configuration/widgets/customer_title.dart';
import 'package:hire_quest/generated/assets.dart';

import '../../../account/ui/cubit/profile_edit_cubit/profile_edit_cubit.dart';
import '../../domain/entities/home_entity.dart';

class HeaderSection extends StatelessWidget {
  final HomeEntity data;

  const HeaderSection({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final name = context.read<ProfileEditCubit>().state.profile?.firstName ?? "user dev";

    return Container(
      margin: const EdgeInsets.only(top: 20),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface, // 👈 Theme Aware background
        borderRadius: const BorderRadius.vertical(bottom: Radius.circular(30)),
      ),
      child: Row(
        children: [
          CustomerTitle(
            title: "Hi, $name",
            desc: "${data.role} • ${data.level} Level",
            sizeTitle: 24,
          ),
          const Spacer(),
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, AppRoute.notifications);
            },
            icon: SvgPicture.asset(
              Assets.iconsNotification,
              height: 30,
              width: 20,
              color: theme.iconTheme.color, // 👈 Theme Aware
            ),
          ),
        ],
      ),
    );
  }
}
