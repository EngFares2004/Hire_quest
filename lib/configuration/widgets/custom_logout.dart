import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../route/route.dart';
import '../shared_handler/shared_handler.dart';
import '../theme/theme.dart';
import 'customer_bottom.dart';
import '../../generated/assets.dart';
import 'custom_build_tile.dart';

class CustomLogout extends StatelessWidget {
  const CustomLogout({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
        children: [

          CustomBuildTile(
            // icon: Icons.login_rounded,
            image: SvgPicture.asset(
              Assets.iconsLogout,
              width: 32,
              height: 32,
              color: AppTheme.error,
            ),
            title: "Logout",
            isLogout: true,
            onTap: () {
              showModalBottomSheet(
                context: context,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(20),
                  ),
                ),
                builder: (context) {
                  return Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
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
                        const SizedBox(height: 32),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                "Are you sure you want to log out of your"
                                    "\n HireQuest VR account",
                                style: TextStyle(
                                  fontSize: 16,
                                  color: AppTheme.primary,
                                  fontWeight: FontWeight.w600,

                              ),
                                textAlign: TextAlign.center,
                                                      ),
                            ],
                          ),
                        const SizedBox(height: 24),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            SizedBox(
                              height: 50,
                              width: MediaQuery.of(context).size.width / 2.5,
                              child: CustomBottom(
                                title: "Log out",
                                textSize: 16,
                                color: AppTheme.error,
                                onTap: ()async {
                                  await SharedHandler.instance.remove('token');
                                  // أو لو عايز تمسح كل الداتا:
                                  Navigator.pop(context); // close sheet
                                  Navigator.pushNamedAndRemoveUntil(
                                    context,
                                    AppRoute.login,
                                        (route) => false,
                                  );
                                },
                              ),
                            ),
                            SizedBox(
                              height: 50,
                              width: MediaQuery.of(context).size.width / 2.5,
                              child: CustomBottom(
                                title: "Cancel",
                                textSize: 16,
                                color: AppTheme.primary,
                                isOutline: true,
                                textColor: AppTheme.primary,
                                onTap: () {
                                  Navigator.pop(context);
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
            },
          ),

          const SizedBox(height: 20),
        ],

    );
  }
}
