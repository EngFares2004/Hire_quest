import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hire_quest/configuration/widgets/customer_arrow_back.dart';
import 'package:hire_quest/configuration/widgets/customer_sub_title.dart';
import 'package:hire_quest/configuration/widgets/customer_title.dart';
import '../../../../configuration/theme/theme.dart';
import '../../../../generated/assets.dart';

class AboutHireQuestScreen extends StatelessWidget {
  const AboutHireQuestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomerArrowBack(
                title: "About HireQuest",
              ),

              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [

                  CircleAvatar(
                    radius: 60,
                    backgroundColor: Theme.of(context).colorScheme.primary.withOpacity(0.1), // 👈 Theme Aware
                    child: Assets.icons.vrGlasses.svg(
                      width: 60,
                      height: 60,
                      color: AppTheme.primary,
                    ),

                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SubTitle(
                        title: "     HireQuest",
                        size: 24,
                        space: 16,
                      ),
                      IconButton(
                        onPressed: () {
                          showAboutDialog(
                            context: context,
                            applicationName: "HireQuest",
                            applicationVersion: "v1.0.0",
                            applicationIcon:
                            Assets.icons.vrGlasses.svg(
                              width: 32,
                              height: 32,
                              color:Theme.of(context).colorScheme.primary,
                            ),

                            children: [
                              Text(
                                "HireQuest helps you prepare for interviews using AI-driven questions.",
                                style: TextStyle(
                                  color: Theme.of(context).textTheme.bodyMedium?.color, // 👈 Theme Aware
                                ),
                              ),
                            ],
                          );
                        },
                        icon: Icon(
                          CupertinoIcons.arrow_down_right_arrow_up_left,
                          color: Theme.of(context).colorScheme.primary, // 👈 Theme Aware
                        ),
                      ),
                    ],
                  ),

                  const Text(
                    "HireQuest helps job seekers prepare for interviews, "
                    "build strong skills, and land better opportunities "
                    "through guided practice and smart tools.",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16, color: AppTheme.secondary),
                  ),

                  const SizedBox(height: 24),

                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: ListTile(
                      leading: Icon(
                        Icons.info_outline,
                        color: AppTheme.primary,
                      ),
                      title: const Text(
                        "App Version",
                        style: TextStyle(color: AppTheme.secondary),
                      ),
                      trailing: const Text(
                        "1.0.0",
                        style: TextStyle(color: AppTheme.secondary),
                      ),
                    ),
                  ),
                ],
              ),
              SubTitle(title: "App Mission  ", size: 16),

              const Text(
                "HireQuest VR is a cutting-edge career preparation platform that "
                "bridges the gap between traditional learning and real-world experience. "
                "By leveraging the power of Artificial Intelligence and Virtual Reality, "
                "we provide an immersive environment for candidates to master their "
                "interview skills and conquer their career goals.",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 15, color: AppTheme.secondary),
              ),
              const SizedBox(height: 12),
              SubTitle(title: "Key Features", size: 18),
              CustomerTitle(
                title: "AI-Driven Interviews:",
                desc:
                    "Realistic simulations with intelligent personas that adapt to your performance.",
                sizeTitle: 15,
                descSize: 14,
              ),
              SizedBox(height: 4),

              CustomerTitle(
                title: "Immersive VR Environments:",
                desc:
                    "Experience high-fidelity 3D office settings from the comfort of your home.",
                sizeTitle: 15,
                descSize: 14,
              ),
              SizedBox(height: 4),

              CustomerTitle(
                title: "AI-Driven Interviews:",
                desc:
                    "Realistic simulations with intelligent personas that adapt to your performance.",
                sizeTitle: 15,
                descSize: 14,
              ),
              SizedBox(height: 4),
              CustomerTitle(
                title: "Personalized Career Blueprints:",
                desc:
                    "Tailored question banks and feedback based on your specific role and experience level.",
                sizeTitle: 15,
                descSize: 14,
              ),
              SizedBox(height: 4),
              CustomerTitle(
                title: "Performance Analytics:",
                desc:
                    "Detailed insights into your communication skills, body language, and technical accuracy.",
                sizeTitle: 15,
                descSize: 14,
              ),
              SubTitle(title: "App Info ", size: 16),
              SubTitle(
                title: "Version : 1.0.0 (Build 2026) ",
                size: 12,
                space: 8,
                spacebtw: 1,
              ),
              SubTitle(
                title: "Last Update : Aug 2026",
                size: 12,
                space: 1,
                spacebtw: 1,
              ),
              SubTitle(
                title: "Powered by : HQA Engine & Flutter & Meta XR SDK ",
                size: 12,
                space: 1,
                spacebtw: 32,
              ),

              // const Spacer(),
              Center(
                child: const Text(
                  "© 2026 HireQuest. All rights reserved.",
                  style: TextStyle(fontSize: 12, color: AppTheme.secondary),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
