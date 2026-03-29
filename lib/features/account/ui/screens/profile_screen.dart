import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hire_quest/configuration/network/dio_client.dart';
import 'package:hire_quest/features/account/ui/screens/support_screen.dart';
import 'package:hire_quest/features/account/ui/screens/personal_information_screen.dart';
import 'package:hire_quest/features/account/ui/screens/setting_screen.dart';
import 'package:hire_quest/features/account/ui/widgets/career_configuration_btn_sheet.dart';
import 'package:hire_quest/configuration/widgets/custom_logout.dart';
import 'package:hire_quest/generated/assets.dart';

import '../../../vr_sec/ui/widgets/device_router.dart';
import '../../../../configuration/theme/theme.dart';
import '../../../onboarding/domain/repositories/onboarding_repository.dart';
import '../../../vr_sec/bloc/device_cubit/device_cubit.dart';
import '../../../vr_sec/domain/service/device_service.dart';
import '../../domain/service/profile_api_service.dart';
import '../cubit/default_iv_setting_cubit/default_iv_setting_cubit.dart';
import '../cubit/profile_edit_cubit/profile_edit_cubit.dart';
import '../../../../configuration/widgets/custom_build_tile.dart';
import 'about_hirequest_screen.dart';
import '../widgets/account_sce.dart';
import 'default_interview_setting_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              const SizedBox(height: 24),

              // ===== Profile Card =====
              AccountTile(),
              const SizedBox(height: 12),

              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  "Profile Setup",
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.grey,
                  ),
                ),
              ),

              const SizedBox(height: 10),
              CustomBuildTile(
                image: SvgPicture.asset(
                  Assets.iconsProfile,
                  width: 32,
                  height: 32,
                  color: AppTheme.primary,
                ),
                title: "Personal Information",
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => BlocProvider(
                        create: (_) => ProfileEditCubit(ProfileApiService(DioClient())),
                        child: const ProfileEditScreen(),
                      ),
                    ),
                  );


                }),
              CustomBuildTile(
                image: SvgPicture.asset(
                  Assets.iconsBag,
                  width: 32,
                  height: 32,
                  color: AppTheme.primary,
                ),
                title: "Career Configuration",
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(20),
                      ),
                    ),
                    isScrollControlled: true,
                    builder: (_) => BlocProvider(
                      create: (context) =>
                      DefaultIVSettingCubit(
                        context.read<OnboardingRepository>(),
                      )..loadOptions(),
                  child: SizedBox(
                  height: MediaQuery.of(context).size.height * 0.55,
                  child: const CareerConfigBottomSheet(),
                  ),)
                  );
                },

              ),
              CustomBuildTile(
                image: SvgPicture.asset(
                  Assets.iconsSetting,
                  width: 32,
                  height: 32,
                  color: AppTheme.primary,
                ),
                title: "Default Interview Settings",
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
              CustomBuildTile(
                image: SvgPicture.asset(
                  Assets.iconsVrGlasses,
                  width: 32,
                  height: 32,
                  color: AppTheme.primary,
                ),
                title: "VR Headset Management",
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => BlocProvider(
                        create: (_) =>
                        DeviceCubit(DeviceService(DioClient()))..checkDevice(),
                        child: const DeviceRouterScreen(),
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(height: 20),
              // ===== Section Title =====
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Support & Help",
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.grey,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              // ===== Tiles with Icons =====
              CustomBuildTile(
                image: SvgPicture.asset(
                  Assets.iconsMessages,
                  width: 32,
                  height: 32,
                  color: AppTheme.primary,
                ),
                //icon: CupertinoIcons.chat_bubble_2,
                title: "Help Center",
                onTap: () {
                  Navigator.push(
                    context,MaterialPageRoute(builder:
                      (context) => SupportScreen(),
                  )
                  );

                },
              ),
              CustomBuildTile(
                icon: CupertinoIcons.settings_solid,
                title: "Settings",
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const SettingsScreen(),
                    ),
                  );
                },
              ),
              CustomBuildTile(
               // icon: CupertinoIcons.star,
                image: SvgPicture.asset(
                  Assets.iconsStar,
                  width: 32,
                  height: 32,
                  color: AppTheme.primary,
                ),
                title: "Rate App",
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        title: const Text("Rate HireQuest"),
                        content: const Text(
                          "If you like the app, please take a moment to rate us ⭐",
                        ),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: const Text("Later"),
                          ),

                          ElevatedButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text("Rate Now"),
                          ),
                        ],
                      );
                    },
                  );
                },
              ),
              CustomBuildTile(
               // icon: Icons.info_outlined,
                image: SvgPicture.asset(
                  Assets.iconsInfoCircle,
                  width: 32,
                  height: 32,
                  color: AppTheme.primary,
                ),
                title: "About HireQuest",
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const AboutHireQuestScreen(),
                    ),
                  );
                },
              ),
              CustomLogout(),
            ],
          ),
        ),
      ),
    );
  }
}
