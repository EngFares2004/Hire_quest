import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:hire_quest/configuration/theme/theme.dart';
import 'package:hire_quest/configuration/widgets/customer_sub_title.dart';
import 'package:hire_quest/configuration/widgets/customer_bottom.dart';

import '../../../../configuration/network/dio_client.dart';
import '../../../account/ui/cubit/default_iv_setting_cubit/default_iv_setting_cubit.dart';
import '../../../account/ui/screens/default_interview_setting_screen.dart';
import '../../../onboarding/domain/repositories/onboarding_repository.dart';
import '../../../vr_sec/bloc/device_cubit/device_cubit.dart';
import '../../../vr_sec/domain/service/device_service.dart';
import '../../bloc/interview_setup_review_cubit/interview_setup_review_cubit.dart';
import '../../bloc/interview_setup_review_cubit/interview_setup_review_state.dart';
import 'is_par_device.dart';

class InterviewSetupReviewBottomSheet extends StatelessWidget {
  const InterviewSetupReviewBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<InterviewSetupReviewCubit,
        InterviewSetupReviewState>(
      builder: (context, state) {

        if (state is InterviewSetupReviewLoading) {
          return const Padding(
            padding: EdgeInsets.all(30),
            child: Center(child: CircularProgressIndicator()),
          );
        }

        if (state is InterviewSetupReviewError) {
          return Padding(
            padding: const EdgeInsets.all(20),
            child: Text(state.message),
          );
        }

        if (state is! InterviewSetupReviewLoaded) {
          return const SizedBox();
        }

        final data = state.data;

        return Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            mainAxisSize: MainAxisSize.min,
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

              const SubTitle(
                title: "Review Your Setup",
                spacebtw: 16,
                space: 16,
              ),

              _row("Role", data.jobTitle),
              _row("Level", data.userLevel),
              _row("Environment", data.environmentType),
              _row("Persona", data.interviewerPersonality),
              _row("Gender", data.interviewerGender),
              _row("Language", data.interviewLanguage),
              _row("Experience", "${data.yearsOfExperience} years"),


              Row(
                children: [

                  /// START
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
                              create: (_) => DeviceCubit(
                                DeviceService(DioClient()),
                              )..checkDevice(),
                              child: const IsParDevice(),
                            ),
                          ),
                        );
                      },
                    ),
                  ),

                  const SizedBox(width: 12),

                  /// CLOSE
                  Expanded(
                    child: CustomBottom(
                      title: 'Edit',
                      isOutline: true,
                      textColor: AppTheme.primary,
                      textSize: 14,
                      onTap: () =>Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (_) => BlocProvider(
                            create: (_) => DefaultIVSettingCubit(
                              context.read<OnboardingRepository>(),
                            )..loadOptions(),
                            child: const DefaultInterviewSettingsScreen(),
                          ),
                        ),
                      ),
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
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: Row(
        children: [
          SubTitle(
            title: '$title : ',
            size: 16,
            spacebtw: 12,
            space: 0,
          ),
          SubTitle(
            title: value,
            size: 16,
            spacebtw: 12,
            space: 0,
            colorTitle: AppTheme.secondary,
          ),
        ],
      ),
    );
  }
}