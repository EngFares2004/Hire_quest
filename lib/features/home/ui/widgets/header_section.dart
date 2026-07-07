import 'package:flutter/material.dart';

import 'package:hire_quest/configuration/route/route.dart';
import 'package:hire_quest/configuration/widgets/customer_title.dart';
import 'package:hire_quest/generated/assets.dart';
import '../../domain/entities/home_entity.dart';

class HeaderSection extends StatelessWidget {
  final HomeEntity data;

  const HeaderSection({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

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
            title: "Hi, ${data.userName}",
            desc: "${data.role} • ${data.level} Level",
            sizeTitle: 24,
          ),
          const Spacer(),
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, AppRoute.notifications);
            },
            icon: Assets.icons.notification.svg(
              width: 20,
              height: 30,
              color:theme.iconTheme.color ,
            ),
                     ),
        ],
      ),
    );
  }
}
