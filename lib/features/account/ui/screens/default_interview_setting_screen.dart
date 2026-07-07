import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:hire_quest/configuration/widgets/customer_arrow_back.dart';
import '../../../../configuration/theme/theme.dart';
import '../../../../configuration/widgets/custom_dropdown.dart';
import '../../../../configuration/widgets/customer_bottom.dart';
import '../../../../configuration/widgets/customer_sub_title.dart';
import '../../../../generated/assets.dart';

import '../../../onboarding/ui/widgets/selectable_Card.dart';

import '../cubit/default_iv_setting_cubit/default_iv_setting_cubit.dart';
import '../cubit/default_iv_setting_cubit/default_iv_setting_state.dart';

class DefaultInterviewSettingsScreen extends StatelessWidget {
  const DefaultInterviewSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<DefaultIVSettingCubit>();

    return Scaffold(
      body: BlocBuilder<DefaultIVSettingCubit, DefaultIVSettingState>(
        builder: (context, state) {
          final options = state.data;

          if (options == null) {
            return const Center(child: CircularProgressIndicator());
          }

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CustomerArrowBack(title: "Interview Settings"),

                const SubTitle(title: "Environment", size: 16),

                _buildEnvironmentGrid(options, state, cubit),

                const SubTitle(title: "Avatar Gender", size: 16),

                _buildGenderGrid(options, state, cubit),

            /*    const SubTitle(title: "Interviewer Role", size: 16),

                CustomDropdown(
                  value: state.selectedRole,
                  hint: "Select Role",
                  items: options.jobTitles,
                  onChanged: cubit.selectRole ,
                ),*/
                const SubTitle(title: "Interviewer Persona", size: 16),
                CustomDropdown(
                  value: state.selectedPersona,
                  hint: "Select Persona",
                  items: options.interviewerPersonalities,
                  onChanged: cubit.selectPersona,
                ),

                const SubTitle(
                  title: "Communication Language",
                  size: 16,
                ),

                CustomDropdown(
                  value: state.selectedLanguage,
                  hint: "Select Language",
                  items: options.interviewLanguages,
                  onChanged: cubit.selectLanguage,
                ),

                const SubTitle(
                  title: "Interview Duration (Minutes)",
                  size: 16,
                ),

                _buildDurationSelector(state, cubit),

                const SizedBox(height: 32),

                CustomBottom(
                  title: "Save as Default",
                  textSize: 16,
                  isDisabled: !state.isValid,
                  onTap: state.isValid
                      ? () async {
                    await cubit.updatePreferences();

                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                          "Default settings saved successfully ✅",
                        ),
                      ),
                    );
                  }
                      : () {},
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  // ================= ENVIRONMENT =================

  Widget _buildEnvironmentGrid(
      options,
      state,
      DefaultIVSettingCubit cubit,
      ) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: options.environmentTypes.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 12,
        crossAxisSpacing: 12,
        childAspectRatio: 170 / 120,
      ),
      itemBuilder: (context, index) {
        final env = options.environmentTypes[index];

        final icon = index == 0
            ? Assets.icons.onSite
            : Assets.icons.remote;

        return SelectableCard(
          isEnvironment: true,
          text: env,
          svgPath: icon,
          isSelected: state.selectedEnvironment == env,
          onTap: () => cubit.selectEnvironment(env),
        );
      },
    );
  }

  // ================= GENDER =================

  Widget _buildGenderGrid(
      options,
      state,
      DefaultIVSettingCubit cubit,
      ) {
    final icons = [
      Assets.icons.manOffice,
      Assets.icons.womanOffice,
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: options.interviewerGenders.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        childAspectRatio: 170 / 120,
      ),
      itemBuilder: (context, index) {
        final gender = options.interviewerGenders[index];

        final icon = index < icons.length
            ? icons[index]
            : Assets.icons.manOffice;

        return SelectableCard(
          text: gender,
          assetsPath: icon as AssetGenImage ,
          isSelected: state.selectedGender == gender,
          onTap: () => cubit.selectGender(gender),
        );
      },
    );
  }

  // ================= DURATION =================

  Widget _buildDurationSelector(state, cubit) {
    final durations = [15.0, 30.0, 45.0, 60.0];

    return Column(
      children: [
        Slider(
          value: state.selectedDuration,
          min: 10,
          max: 60,
          divisions: 5,
          label: state.selectedDuration.toInt().toString(),
          onChanged: cubit.selectDuration,
        ),

        Row(
          children: durations.map((dur) {
            final selected = state.selectedDuration == dur;

            return Expanded(
              child: GestureDetector(
                onTap: () => cubit.selectDuration(dur),
                child: AnimatedScale(
                  scale: selected ? 1.05 : 1.0,
                  duration: const Duration(milliseconds: 200),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 250),
                    margin: const EdgeInsets.only(right: 8),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    decoration: BoxDecoration(
                      color: selected
                          ? AppTheme.primary
                          : AppTheme.borderColor,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Center(
                      child: Text(
                        "${dur.toInt()} m",
                        style: TextStyle(
                          color: selected
                              ? AppTheme.white
                              : AppTheme.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}