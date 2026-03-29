import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hire_quest/configuration/widgets/customer_sub_title.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../configuration/theme/theme.dart';
import '../../../../configuration/widgets/custom_dropdown.dart';
import '../../../../configuration/widgets/customer_bottom.dart';
import '../cubit/default_iv_setting_cubit/default_iv_setting_cubit.dart';
import '../cubit/default_iv_setting_cubit/default_iv_setting_state.dart';
import 'faq_tab.dart';
import 'live_chat_screen.dart';

class CareerConfigBottomSheet extends StatelessWidget {
  const CareerConfigBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<DefaultIVSettingCubit>();

    return Scaffold(
        body: BlocBuilder<DefaultIVSettingCubit, DefaultIVSettingState>(
        builder: (context, state)
    {
      final options = state.data;

      if (options == null) {
        return const Center(child: CircularProgressIndicator());
      }

      return Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          //mainAxisSize: MainAxisSize.values,
          children: [
            Center(
              child: Container(
                width: 80,
                height: 5,
                margin: const EdgeInsets.only(bottom: 12),
                decoration: BoxDecoration(
                  color: AppTheme.grey,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),


            SubTitle(title: "Career Path", space: 32, size: 16,),
            CustomDropdown(
              value: state.selectedPath,
              hint: "Select Path",
              items: options.jobPaths,
              onChanged: (v) => cubit.selectPath(v),
            ),

            SubTitle(title: "Experience Level", space: 16, size: 16,),
            CustomDropdown(
              value: state.selectedLevel,
              hint: "Select Level",
              items: options.userLevels,
              onChanged: (v) => cubit.selectLevel(v),
            ),

            SubTitle(title: "Target Role", space: 16, size: 16,),
            CustomDropdown(
              value: state.selectedRole,
              hint: "Select Role",
              items: options.jobTitles,
              onChanged: (v) => cubit.selectRole(v),
            ),


            const SizedBox(height: 32,),
            CustomBottom(
              textSize: 16,
              title: " Apply Career Changes",
              isDisabled: state.isValid,
              onTap: state.isValid
                  ? ()async {
                await context.read<DefaultIVSettingCubit>().saveSetup();

                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text(
                      "Career Changed saved successfully ✅",
                    ),
                  ),
                );
              }
                  : () {},
            ),

            const SizedBox(height: 10),
          ],
        ),
      );
    }



  )
  );
  }
}
