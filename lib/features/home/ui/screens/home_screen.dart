import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/home_cubit/home_cubit.dart';
import '../../bloc/home_cubit/home_state.dart';
import '../sections/after_interview_section.dart';
import '../sections/before_interview_section.dart';
import '../widgets/header_section.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          if (state is HomeLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is HomeLoaded) {
            final data = state.data;

            return SingleChildScrollView(
              child: Column(
                children: [
                  HeaderSection(data: data),

                  data.hasInterview
                      ? BeforeInterviewSection(data: data)
                      :  AfterInterviewSection(data: data),
                ],
              ),
            );
          }

          if (state is HomeError) {
            return Center(child: Text(state.message));
          }

          return const SizedBox();
        },
      ),
    );
  }
}