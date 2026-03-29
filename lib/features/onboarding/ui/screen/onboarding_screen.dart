import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../configuration/route/route.dart';
import '../../../../configuration/shared_handler/shared_handler.dart';
import '../../../../configuration/shared_handler/shared_keys.dart';
import '../../../../configuration/theme/theme.dart';
import '../../../../configuration/widgets/customer_bottom.dart';

import '../../bloc/onboarding_cubit/onboarding_cubit.dart';
import '../../bloc/onboarding_cubit/onboarding_state.dart';

import '../../bloc/define_path_cubit/DefinePathCubit.dart';
import '../../bloc/define_path_cubit/define_path_state.dart';

import '../../bloc/atmosphere_cubit/atmosphere_cubit.dart';
import '../../bloc/atmosphere_cubit/atmosphere_state.dart';

import '../../bloc/customize_cubit/customize_cubit.dart';
import '../../bloc/customize_cubit/customize_state.dart';

import '../screen/step_define_path.dart';
import '../screen/step_atmosphere.dart';
import '../screen/step_customize.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  final PageController _controller = PageController();

  final prefs = SharedHandler.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocListener<OnboardingCubit, OnboardingState>(
          listenWhen: (prev, curr) =>
          prev.submitted != curr.submitted ||
              prev.error != curr.error,
          listener: (context, state) {
            if (state.submitted) {
              prefs.setData(SharedKeys.isPreferences, "done");
              Navigator.pushNamedAndRemoveUntil(
                context,
                AppRoute.bottomBarNavigator,
                    (route) => false,
              );
            }
            if(state.isLoading){
              const Center(child: CircularProgressIndicator());
            }
            if (state.error != null) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.error!)),
              );
            }
          },
          child: BlocBuilder<OnboardingCubit, OnboardingState>(
            builder: (context, onboardingState) {
              return Stack(
                children: [
                  /// ---------- PAGE VIEW ----------
                  PageView(
                    controller: _controller,
                    physics: const NeverScrollableScrollPhysics(),
                    onPageChanged: (index) {
                      context.read<OnboardingCubit>().setPage(index);
                    },
                    children: [
                      /// STEP 1 - Define Path
                      BlocListener<DefinePathCubit, DefinePathState>(
                        listenWhen: (p, c) => p.isValid != c.isValid,
                        listener: (context, state) {
                          context
                              .read<OnboardingCubit>()
                              .setDefinePathValid(state.isValid);
                        },
                        child: const StepDefinePath(),
                      ),

                      /// STEP 2 - Atmosphere
                      BlocListener<AtmosphereCubit, AtmosphereState>(
                        listenWhen: (p, c) => p.isValid != c.isValid,
                        listener: (context, state) {
                          context
                              .read<OnboardingCubit>()
                              .setAtmosphereValid(state.isValid);
                        },
                        child: const StepAtmosphere(),
                      ),

                      /// STEP 3 - Customize
                      BlocListener<CustomizeCubit, CustomizeState>(
                        listenWhen: (p, c) => p.isValid != c.isValid,
                        listener: (context, state) {
                          context
                              .read<OnboardingCubit>()
                              .setCustomizeValid(state.isValid);
                        },
                        child: const StepCustomize(),
                      ),
                    ],
                  ),

                  /// ---------- BACK BUTTON ----------
                  Positioned(
                    right: 20,
                    top: 50,
                    child: onboardingState.page == 0
                        ? const SizedBox()
                        : TextButton.icon(
                      onPressed: () {
                        context.read<OnboardingCubit>().back();
                        _controller.previousPage(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                        );
                      },
                      icon: const Icon(
                        Icons.arrow_back_ios,
                        size: 16,
                        color: AppTheme.primary,
                      ),
                      label: const Text(
                        "Back",
                        style: TextStyle(
                          color: AppTheme.primary,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),

                  /// ---------- STEP INDICATOR ----------
                  Positioned(
                    top: 35,
                    left: 20,
                    child: Row(
                      children: List.generate(
                        3,
                            (index) => AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          margin: const EdgeInsets.only(right: 16),
                          height: 8,
                          width: MediaQuery.of(context).size.width / 3.8,
                          decoration: BoxDecoration(
                            color: index <= onboardingState.page
                                ? AppTheme.primary
                                :AppTheme.borderColor,
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ),
                  ),

                  Positioned(
                    top: 65,
                    left: 20,
                    child: Text(
                      "Step ${onboardingState.page + 1} of 3",
                      style: const TextStyle(
                        fontSize: 15,
                        color: AppTheme.secondary,
                      ),
                    ),
                  ),

                  /// ---------- BOTTOM BUTTON ----------
                  Positioned(
                    bottom: 25,
                    left: 20,
                    right: 20,
                    child: CustomBottom(
                      color: onboardingState.canContinue
                          ? AppTheme.primary
                          : Theme.of(context).colorScheme.surface,
                      textColor: onboardingState.canContinue
                          ? Theme.of(context).colorScheme.surface
                          : AppTheme.secondary,
                      title: onboardingState.page == 2
                          ? "Finalize Setup"
                          : onboardingState.page == 1
                          ? "Next: Persona"
                          : "Next: Environment",
                      onTap: onboardingState.canContinue
                          ? () async {
                        final onboardingCubit = context.read<OnboardingCubit>();

                        if (onboardingState.page < 2) {
                          onboardingCubit.next();

                          _controller.nextPage(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                          );
                          return;
                        }
                        final cubit =
                        context.read<OnboardingCubit>();
                        final definePath =
                            context.read<DefinePathCubit>().state;
                        final atmosphere =
                            context.read<AtmosphereCubit>().state;
                        final customize =
                            context.read<CustomizeCubit>().state;

                        if (!definePath.isValid ||
                            !atmosphere.isValid ||
                            !customize.isValid) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content:
                              Text("Please complete all steps"),
                            ),
                          );
                          return;
                        }

                        final jobTitle =
                        definePath.selectedTrack == "Other"
                            ? definePath.role
                            : definePath.selectedTrack!;


                        await cubit.submitAllPreferences(
                          jobTitle: jobTitle,
                          userLevel: definePath.selectedLevel!,
                          environmentType:
                          atmosphere.selectedEnvironment!,
                          interviewerBehavior:
                          atmosphere.selectedPersona!,
                          interviewerGender:
                          customize.selectedGender!,
                          interviewLanguage:
                          customize.selectedLanguage!,
                        );
                      }
                          : (){},
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
