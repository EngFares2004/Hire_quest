import 'dart:async';
import 'package:flutter/material.dart';
import 'package:hire_quest/configuration/route/route.dart';
import 'package:hire_quest/configuration/theme/theme.dart';
import '../../../generated/assets.dart';
import 'package:hire_quest/configuration/shared_handler/shared_handler.dart';
import 'package:hire_quest/configuration/shared_handler/shared_keys.dart';

class HireQuestOpening extends StatefulWidget {
  const HireQuestOpening({super.key});

  @override
  State<HireQuestOpening> createState() => _HireQuestOpeningState();
}

class _HireQuestOpeningState extends State<HireQuestOpening> {
  int _step = 0;

  @override
  void initState() {
    super.initState();
    _runSplash();
  }

  void _runSplash() async {
    await Future.delayed(const Duration(milliseconds: 800));
    if (mounted) setState(() => _step = 0);

    await Future.delayed(const Duration(milliseconds: 800));
    if (mounted) setState(() => _step = 1);

    await Future.delayed(const Duration(milliseconds: 800));
    if (mounted) setState(() => _step = 2);

    await Future.delayed(const Duration(milliseconds: 1600));
    if (!mounted) return;

    _navigateAfterSplash();
  }

  void _navigateAfterSplash() {
    final prefs = SharedHandler.instance;

    final isFirstOpen = prefs.readData(SharedKeys.isFirstOpen);
    final token = prefs.readData(SharedKeys.token);
    final isPreferences = prefs.readData(SharedKeys.isPreferences);

    if (isFirstOpen == null) {
      prefs.setData(SharedKeys.isFirstOpen, "done");
      Navigator.pushReplacementNamed(context, AppRoute.splash);
    } else if (isPreferences != null && isPreferences.isNotEmpty) {
      Navigator.pushReplacementNamed(context, AppRoute.bottomBarNavigator);
    } else if (token != null && token.isNotEmpty) {
      Navigator.pushReplacementNamed(context, AppRoute.onboarding);
    } else {
      Navigator.pushReplacementNamed(context, AppRoute.login);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 900),
        switchInCurve: Curves.easeOut,
        switchOutCurve: Curves.easeIn,
        child: _buildStep(_step),
      ),
    );
  }

  Widget _buildStep(int step) {
    switch (step) {
      case 0:
        return _splashView(
          bg: AppTheme.primary,
          showText: false,
          icon: Assets.icons.logoSvg,
         colorLogo: AppTheme.backgroundWhite
        );

      case 1:
        return _splashView(
          colorLogo: AppTheme.primary,
            bg: AppTheme.backgroundWhite,
          showText: false,
          icon: Assets.icons.logoSvg,
        );

      case 2:
        return _splashView(
          bg: AppTheme.backgroundWhite,
          showText: true,
          icon: Assets.icons.logoSvg,
            colorLogo: AppTheme.primary

        );

      default:
        return Container(color: AppTheme.backgroundWhite);
    }
  }

  Widget _splashView({
    required Color bg,
    Color? colorLogo,
    required bool showText,
    required SvgGenImage icon,
  }) {
    return Container(
      key: ValueKey(showText),
      color: bg,

      width: double.infinity,
      height: double.infinity,
      child: Center(
        child: showText
            ? Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            icon.svg(
                height: 60,
               color: colorLogo
            ),
            const SizedBox(width: 15),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text(
                  "HireQuest VR",
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.w700,
                    color: AppTheme.primary,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  "Where your interview journey begins.",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: AppTheme.secondary,
                  ),
                ),
              ],
            ),
          ],
        )
            : icon.svg(height: 95,
            color: colorLogo),
      ),
    );
  }
}