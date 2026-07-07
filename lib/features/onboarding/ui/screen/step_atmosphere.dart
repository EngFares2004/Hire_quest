import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:hire_quest/configuration/widgets/customer_sub_title.dart';
import 'package:hire_quest/generated/assets.dart';

import '../../bloc/atmosphere_cubit/atmosphere_cubit.dart';
import '../../bloc/atmosphere_cubit/atmosphere_state.dart';
import '../../bloc/options_cubit/user_preferences_options_cubit.dart';
import '../../../../configuration/widgets/customer_title.dart';
import '../../ui/widgets/selectable_Card.dart';

class StepAtmosphere extends StatelessWidget {
  final ValueChanged<bool>? onValid;

  const StepAtmosphere({super.key, this.onValid});

  @override
  Widget build(BuildContext context) {
    final options = context.watch<OptionsCubit>().state.data;
    final cubit = context.read<AtmosphereCubit>();

    if (options == null) {
      return const Center(child: CircularProgressIndicator());
    }

    final environments = [
      {
        "icon": Assets.icons.onSite,
        "key": options.environmentTypes.isNotEmpty
            ? options.environmentTypes[0]
            : "",
      },
      {
        "icon": Assets.icons.remote,
        "key": options.environmentTypes.length > 1
            ? options.environmentTypes[1]
            : "",
      },
    ];

    final personas = [
      {
        "icon": Assets.icons.huggingFace,
        "key": options.interviewerPersonalities.isNotEmpty
            ? options.interviewerPersonalities[0]
            : "",
      },
      {
        "icon": Assets.icons.slightlySmilingFace,
        "key": options.interviewerPersonalities.length > 1
            ? options.interviewerPersonalities[1]
            : "",
      },
      {
        "icon": Assets.icons.thinkingFac,
        "key": options.interviewerPersonalities.length > 2
            ? options.interviewerPersonalities[2]
            : "",
      },
      {
        "icon": Assets.icons.expressionlessFace,
        "key": options.interviewerPersonalities.length > 3
            ? options.interviewerPersonalities[3]
            : "",
      },
    ];

    return BlocBuilder<AtmosphereCubit, AtmosphereState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.fromLTRB(20, 130, 20, 0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                 CustomerTitle(
                  title: "Set The Atmosphere",
                  desc: "Choose where and how you want to be interviewed.",
                ),

                const SubTitle(title: "Environment"),

                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: environments.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    childAspectRatio: 170 / 120,
                  ),
                  itemBuilder: (context, index) {
                    final item = environments[index];

                    final icon = item["icon"] as SvgGenImage;
                    final key = item["key"] as String;

                    return SelectableCard(
                      isEnvironment: true,
                      text: key,
                      svgPath: icon,
                      isSelected: state.selectedEnvironment == key,
                      onTap: () {
                        cubit.selectEnvironment(key);
                        onValid?.call(state.isValid);
                      },
                    );
                  },
                ),

                const SizedBox(height: 10),

                const SubTitle(title: "Interviewer Persona"),

                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: personas.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    childAspectRatio: 170 / 120,
                  ),
                  itemBuilder: (context, index) {
                    final item = personas[index];

                    final icon = item["icon"] as AssetGenImage;
                    final key = item["key"] as String;

                    return SelectableCard(
                      text: key,
                      assetsPath: icon,
                      isSelected: state.selectedPersona == key,
                      onTap: () {
                        cubit.selectPersona(key);
                        onValid?.call(state.isValid);
                      },
                    );
                  },
                ),

                const SizedBox(height: 10),
              ],
            ),
          ),
        );
      },
    );
  }
}