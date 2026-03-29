import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hire_quest/configuration/network/dio_client.dart';
import 'package:hire_quest/features/account/domain/service/profile_api_service.dart';
import 'package:hire_quest/features/account/ui/cubit/profile_edit_cubit/profile_edit_cubit.dart';
import 'package:hire_quest/features/account/ui/screens/personal_information_screen.dart';
import 'package:hire_quest/features/authentication/blocs/otp_verification_bloc/otp_cubit.dart';
import 'package:hire_quest/features/authentication/domain/services/otp_service.dart';
import 'package:hire_quest/features/authentication/ui/screens/otp_screen.dart';
import 'package:hire_quest/features/bottombarNavigator.dart';
import 'package:hire_quest/features/home/ui/screens/home_screen.dart';
import 'package:hire_quest/features/vr_sec/ui/screens/interview_code_screen.dart';
import 'package:hire_quest/features/home/ui/screens/notifications_screen.dart';
import 'package:hire_quest/features/onboarding/ui/screen/onboarding_screen.dart';
import 'package:hire_quest/features/splash/ui/splash_screen.dart';

import '../../features/authentication/blocs/singupbloc/singup.dart';
import '../../features/authentication/ui/screens/forgetpassword_screen.dart';
import '../../features/authentication/ui/screens/login_screen.dart';
import '../../features/authentication/ui/screens/reset_pass_screen.dart';
import '../../features/authentication/ui/screens/singup_screen.dart';
import '../../features/authentication/ui/screens/success_password_screen.dart';
import '../../features/splash/ui/opening_screen.dart';

abstract class AppRoute {
  static const String opening = "/";
  static const String splash = "/splash";
  static const String login = "/login";
  static const String signup = "/signup";
  static const String forgetPassword = "/forgetPassword";
  static const String otpVerification = "/otpVerification";
  static const String passwordChanged = "/passwordChanged";
  static const String successPassword = "/successPassword";
  static const String onboarding = "/onboarding";
  static const String bottomBarNavigator = "/bottomBarNavigator";

  static const String home = "/Home";
  static const String notifications = "/Notifications";
  static const String interviewCode = "/InterviewCode";
  static const String profileEdit = "/ProfileEditScreen";
}

Route<dynamic>? generateRoute(RouteSettings settings) {
  Route pageRoute(Widget page) => MaterialPageRoute(builder: (_) => page);

  switch (settings.name) {
    case AppRoute.opening:
      return pageRoute(const HireQuestOpening());

    case AppRoute.splash:
      return pageRoute(const SplashScreen());

    case AppRoute.login:
      return pageRoute(LoginScreen());

    case AppRoute.signup:
      return MaterialPageRoute(
        builder: (context) => BlocProvider(
          create: (context) => SignupBloc(),
          child: SingUpScreen(),
        ),
      );

    case AppRoute.forgetPassword:
      return pageRoute(ForgetPassword());

    case AppRoute.otpVerification:
      return MaterialPageRoute(
        builder: (context) => BlocProvider(
          create: (context) => OtpCubit(OtpService()),
          child: OtpScreen(email: ''),
        ),
      );
    case AppRoute.passwordChanged:
      return pageRoute(ResetPassScreen());
    case AppRoute.successPassword:
      return pageRoute(SuccessPasswordScreen());

    case AppRoute.onboarding:
      return pageRoute(const OnBoardingScreen());

    case AppRoute.bottomBarNavigator:
      return MaterialPageRoute(
        builder: (context) => BlocProvider(
          create: (context) => ProfileEditCubit(ProfileApiService(DioClient())),
          child: BottomBarNavigator(),
        ),
      );

    case AppRoute.home:
      return pageRoute(const HomeScreen());
    case AppRoute.notifications:
      return pageRoute(const NotificationsScreen());

    case AppRoute.interviewCode:
      return pageRoute(const InterviewCodeScreen());

    case AppRoute.profileEdit:
      return pageRoute(ProfileEditScreen());

    default:
      return pageRoute(const SplashScreen());
  }
}
