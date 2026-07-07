import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../configuration/theme/theme.dart';
import '../../../../configuration/widgets/customer_arrow_back.dart';
import '../../../../configuration/widgets/customer_bottom.dart';
import '../../../../generated/assets.dart';
import '../../bloc/interview_code/interview_code_cubit.dart';
import 'header_vr_code.dart';

class CodeExpired extends StatelessWidget {
  const CodeExpired({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomerArrowBack(title:'Code Expired'),
        Spacer(),
        Center(
          child:Assets.icons.iconApp.svg(
            width: 70,
            height: 70,
            color: AppTheme.primary,
          ),

        ),

        const SizedBox(height: 24),

        Center(
          child: const Text(
            "Code Expired",
            style: TextStyle(
              color: AppTheme.primary,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
        ),

        const SizedBox(height: 12),

        Center(
          child: const Text(
            "Soon, you'll be able to experience immersive AI-powered interviews using VR technology.\n\n"
                "Practice real-world interview scenarios in a virtual environment.",
            textAlign: TextAlign.center,
            style: TextStyle(color:AppTheme.secondary),
          ),
        ),

        const Spacer(),

        CustomBottom(
          title: "Generate New Code",
          textSize: 16,
          onTap: () {
            context.read<InterviewCodeCubit>().regenerate();
          },
        ),
      ],
    );
  }
}
