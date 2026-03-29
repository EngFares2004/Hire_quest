import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hire_quest/configuration/theme/theme.dart';

import '../../../../configuration/network/dio_client.dart';
import '../../../../configuration/widgets/customer_sub_title.dart';
import '../../bloc/interview_code/interview_code_cubit.dart';
import '../../domain/service/vr_code_service.dart';
import '../widgets/code_box.dart';
import '../widgets/code_expired.dart';
import '../widgets/header_vr_code.dart';
class InterviewCodeScreen extends StatelessWidget {
  const InterviewCodeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          InterviewCodeCubit(VrCodeService(DioClient()))..generateCode(),
      child: const _InterviewView(),
    );
  }
}

class _InterviewView extends StatefulWidget {
  const _InterviewView();

  @override
  State<_InterviewView> createState() => _InterviewViewState();
}

class _InterviewViewState extends State<_InterviewView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
          padding: const EdgeInsets.all( 20),
          child: BlocBuilder<InterviewCodeCubit, InterviewCodeState>(
            builder: (context, state) {
              /// 🔄 Loading
              if (state is InterviewCodeLoading) {
                return const Center(child: CircularProgressIndicator());
              }

              /// ✅ Code Generated
              if (state is InterviewCodeGenerated) {
                final minutes = (state.remainingSeconds ~/ 60)
                    .toString()
                    .padLeft(2, '0');

                final seconds = (state.remainingSeconds % 60)
                    .toString()
                    .padLeft(2, '0');

                final codeChars = state.code.replaceAll("-", "").split("");

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    HeaderVrCode(title: 'Start Interview'),
                    const SubTitle(
                      title: 'Enter this code in your VR headset to begin',
                      size: 16,
                    ),
                    const SizedBox(height: 16),


                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: List.generate(
                        codeChars.length,
                        (index) => CodeBox(value: codeChars[index]),
                      ),
                    ),


                    const SizedBox(height: 30),

                    /// ⏱ Timer
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "This code is valid for 10 minutes ",
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: AppTheme.secondary ,
                          ),
                        ),
                        Text(
                          " $minutes:$seconds",
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: AppTheme.error ,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 20),

                    /// 📋 Copy Button
                    ElevatedButton.icon(
                      onPressed: () {
                        Clipboard.setData(ClipboardData(text: state.code));

                        ScaffoldMessenger.of(context).showSnackBar(

                           SnackBar(content:
                           Text("Code copied",style: TextStyle(
                             color: AppTheme.white
                           ),
                           ),backgroundColor: AppTheme.primary,
                           ),
                        );
                      },
                      icon: const Icon(Icons.copy),
                      label: const Text("Copy Code"),
                    ),
                  ],
                );
              }

              /// ⛔ Expired
              if (state is InterviewCodeExpired) {
                return CodeExpired();
              }

              /// ❌ Error
              if (state is InterviewCodeError) {
                return Center(
                  child: Text(
                    state.message,
                    style: const TextStyle(color: AppTheme.error),
                  ),
                );
              }

              return const SizedBox();
            },
          ),

      ),
    );
  }
}




