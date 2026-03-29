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
                CustomerArrowBack(
                  title: "Interview Settings",
                ),
                const SubTitle(title: "Environment", size: 16,space: 16,spacebtw: 0,),
                GridView.builder(
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
                    return SelectableCard(
                      isEnvironment: true,
                      text: env,
                      svgPath: index == 0
                          ? Assets.iconsOnSite
                          : Assets.iconsRemote,
                      isSelected: state.selectedEnvironment == env,
                      onTap: () => cubit.selectEnvironment(env),
                    );
                  },
                ),



                const SubTitle(title: "Avatar Gender",size: 16,space: 12,spacebtw: 0,),
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: options.interviewerGenders.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                   // mainAxisSpacing: 12,
                    crossAxisSpacing: 12,
                    childAspectRatio: 170 / 120,
                  ),
                  itemBuilder: (context, index) {
                    final gender = options.interviewerGenders[index];
                    return SelectableCard(
                      text: gender,
                      svgPath: index == 0
                          ? Assets.iconsManOffice
                          : Assets.iconsWomanOffice,
                      isSelected: state.selectedGender == gender,
                      onTap: () => cubit.selectGender(gender),
                    );
                  },
                ),

                const SubTitle(title: "Interviewer Persona", size: 16,space: 0,),
                CustomDropdown(
                  value: state.selectedPersona,
                  hint: "Select Persona",
                  items: options.userLevels,
                  onChanged: (v) => cubit.selectPersona(v),
                ),


                const SubTitle(title: "Communication Language", size: 16,space: 12,),
                CustomDropdown(
                  value: state.selectedLanguage,
                  hint: "Select Language",
                  items: options.interviewLanguages,
                  onChanged: (v) => cubit.selectLanguage(v),
                ),

                const SubTitle(title: "Interview Duration (Minutes)", size: 16,space: 16,),

                /// Slider
                Slider(
                  value: state.selectedDuration,
                  min: 10,
                  max: 60,
                  divisions: 5,
                  label: state.selectedDuration.toInt().toString(),
                  onChanged: (value) {
                    cubit.selectDuration(value);
                  },
                ),

                /// Animated Preset Buttons
                Row(
                  children: [15.0, 30.0, 45.0, 60.0].map((dur) {
                    final bool selected = state.selectedDuration == dur;

                    return Expanded(
                      child: GestureDetector(
                        onTap: () {
                          cubit.selectDuration(dur);
                        },
                        child: AnimatedScale(
                          scale: selected ? 1.05 : 1.0,
                          duration: const Duration(milliseconds: 200),
                          curve: Curves.easeOut,
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 250),
                            curve: Curves.easeInOut,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            margin: const EdgeInsets.only(right: 8),
                            decoration: BoxDecoration(
                              color: selected
                                  ? AppTheme.primary
                                  : AppTheme.borderColor,
                              borderRadius: BorderRadius.circular(12),
                              boxShadow: selected
                                  ? [
                                BoxShadow(
                                  color: AppTheme.primary.withOpacity(0.35),
                                  blurRadius: 8,
                                  offset: const Offset(0, 4),
                                )
                              ]
                                  : [],
                            ),
                            child: Center(
                              child: Text(
                                '${dur.toInt()} m',
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

                const SizedBox(height: 32),
                CustomBottom(
                  title: "Save as Default",
                  textSize: 16,
                  isDisabled: !state.isValid,
                  onTap: state.isValid
                      ? ()async {
                     await context.read<DefaultIVSettingCubit>().saveSetup();
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
}
