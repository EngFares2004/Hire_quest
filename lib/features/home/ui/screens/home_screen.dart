import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hire_quest/features/home/ui/widgets/header_section.dart';

import '../../../account/ui/cubit/default_iv_setting_cubit/default_iv_setting_cubit.dart';
import '../../../onboarding/domain/repositories/onboarding_repository.dart';
import '../../bloc/home_cubit/home_cubit.dart';
import '../../bloc/home_cubit/home_state.dart';
import '../sections/before_interview_section.dart';
import '../sections/after_interview_section.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  Column(
          children: [
            BlocBuilder<HomeCubit, HomeState>(
              builder: (context, state) {
                if (state is HomeLoading) {
                  return Column(
                    children: [
                      SizedBox(height: MediaQuery.of(context).size.height / 2),
                      Center(child: CircularProgressIndicator()),
                    ],
                  );
                }
                if (state is HomeBeforeInterview) {
                 return BeforeInterviewSection(data: state.data);
                }
                if (state is HomeAfterInterview) {
                  return AfterInterviewSection(data: state.data);
                }
                return const SizedBox();
              },
            ),
          ],
        ),

    );
  }
}
