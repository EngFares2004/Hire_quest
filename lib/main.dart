import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hire_quest/features/home/data/datasources/home_datasource.dart';

import 'configuration/route/route.dart';
import 'configuration/network/dio_client.dart';
import 'configuration/shared_handler/shared_handler.dart';

import 'configuration/theme/app_theme_data.dart';
import 'configuration/theme/theme_cubit.dart';
import 'features/account/domain/repo/user_preferences_repo.dart';
import 'features/account/domain/service/interview_api_service.dart';
import 'features/account/ui/cubit/default_iv_setting_cubit/default_iv_setting_cubit.dart';
import 'features/home/bloc/home_cubit/home_cubit.dart';
import 'features/home/data/repositories/home_repository_impl.dart';
import 'features/home/domain/repositories/home_repository.dart';
import 'features/onboarding/bloc/onboarding_cubit/onboarding_cubit.dart';
import 'features/onboarding/bloc/define_path_cubit/DefinePathCubit.dart';
import 'features/onboarding/bloc/atmosphere_cubit/atmosphere_cubit.dart';
import 'features/onboarding/bloc/customize_cubit/customize_cubit.dart';
import 'features/onboarding/bloc/options_cubit/user_preferences_options_cubit.dart';
import 'features/onboarding/data/datasources/onboarding_remote_datasource.dart';
import 'features/onboarding/data/repositories/onboarding_repository_impl.dart';
import 'features/onboarding/domain/repositories/onboarding_repository.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedHandler.instance.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final dioClient = DioClient();


    final homeRepository = HomeRepositoryImpl(HomeDataSource());

    final onboardingRepository = OnboardingRepositoryImpl(
      OnboardingRemoteDataSourceImpl(dioClient.dio),
    );

    return MultiRepositoryProvider(
      providers: [

        RepositoryProvider<UserPreferencesRepository>(
          create: (_) => UserPreferencesRepository(UserPreferencesApiService(dioClient)),
        ),
        RepositoryProvider<HomeRepository>.value(value: homeRepository),
        RepositoryProvider<OnboardingRepository>.value(value: onboardingRepository),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => ThemeCubit()),

          BlocProvider<HomeCubit>(
            create: (context) => HomeCubit(context.read<HomeRepository>())..loadHome(),
          ),
          BlocProvider<OptionsCubit>(
            create: (context) => OptionsCubit(context.read<OnboardingRepository>())..loadOptions(),
          ),
          BlocProvider<OnboardingCubit>(
            create: (context) => OnboardingCubit(context.read<OnboardingRepository>()),
          ),
          BlocProvider<DefinePathCubit>(create: (_) => DefinePathCubit()),
          BlocProvider<AtmosphereCubit>(create: (_) => AtmosphereCubit()),
          BlocProvider<CustomizeCubit>(create: (_) => CustomizeCubit()),
        ],
        child: BlocBuilder<ThemeCubit, ThemeMode>(
          builder: (context, themeMode) {
            return MaterialApp(
              title: 'HireQuest A Graduation project.',
              debugShowCheckedModeBanner: false,
              theme: AppThemeData.lightTheme,
              darkTheme: AppThemeData.darkTheme,
              themeMode: themeMode,
              initialRoute: AppRoute.opening,
              onGenerateRoute: generateRoute,
            );
          },
        ),
      ),
    );
  }
}