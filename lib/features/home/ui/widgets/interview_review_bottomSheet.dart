import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hire_quest/configuration/widgets/customer_sub_title.dart';
import 'package:hire_quest/features/home/ui/widgets/is_par_device.dart';
import '../../../../configuration/network/dio_client.dart';
import '../../../../configuration/theme/theme.dart';
import '../../../../configuration/widgets/customer_bottom.dart';
import '../../../account/domain/models/interview_setup.dart';
import '../../../account/ui/cubit/default_iv_setting_cubit/default_iv_setting_cubit.dart';
import '../../../account/ui/cubit/default_iv_setting_cubit/default_iv_setting_state.dart';
import '../../../account/ui/screens/default_interview_setting_screen.dart';
import '../../../onboarding/domain/repositories/onboarding_repository.dart';
import '../../../vr_sec/bloc/device_cubit/device_cubit.dart';
import '../../../vr_sec/domain/service/device_service.dart';

class InterviewSetupReviewBottomSheet extends StatelessWidget {
  const InterviewSetupReviewBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DefaultIVSettingCubit, DefaultIVSettingState>(
      builder: (context, state) {
        final data = InterviewSetupModel(
          environment: state.selectedEnvironment ?? 'On-Site',
          gender: state.selectedGender ?? 'Male',
          language: state.selectedLanguage ?? 'English',
          persona: state.selectedPersona ?? 'The Coach',
          duration: state.selectedDuration,
          level: state.selectedLevel ??'Entry',
          path: state.selectedPath ?? 'SoftWare Engineer',
          role: state.selectedRole ?? 'Flutter Developer',
        );


        return Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [

              Container(
                  width: 80,
                  height: 5,
                  margin: const EdgeInsets.only(bottom: 12),
                  decoration: BoxDecoration(
                    color: AppTheme.grey,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              SubTitle(title: "Review Your Setup",spacebtw:32,space: 16,),


              _row("Path", data.path),
              _row("Role", data.role),
              _row("Environment", data.environment),
              _row("Interview Persona", data.persona),
              _row("Avatar Gender", data.gender),
              _row("Language", data.language),
              _row("Duration", "${data.duration.toInt()} min"),

              const SizedBox(height: 16),

              Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: CustomBottom(
                      title: 'Start Interview',
                      textSize: 14,

                      onTap: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (_) => BlocProvider(
                              create: (_) =>
                              DeviceCubit(DeviceService(DioClient()))..checkDevice(),
                              child: const IsParDevice(),
                            ),
                          ),
                        );

                      },
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    flex: 1,
                    child: CustomBottom(
                      title: 'Edit Details',
                      isOutline: true,
                      textColor: AppTheme.primary,
                      textSize: 14,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => BlocProvider(
                              create: (_) =>
                              DefaultIVSettingCubit(context.read<OnboardingRepository>())
                                ..loadOptions(),
                              child: const DefaultInterviewSettingsScreen(),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),

            ],
          ),
        );
      },
    );
  }

  Widget _row(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SubTitle(title: '$title : ',size: 16,spacebtw: 12,space: 0,),
          SubTitle(title: '$value ',size: 16,spacebtw: 12,space: 0,colorTitle: AppTheme.secondary,),

        ],
      ),
    );
  }
}
