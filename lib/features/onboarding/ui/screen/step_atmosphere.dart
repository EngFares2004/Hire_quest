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
                  itemCount:options.environmentTypes.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    childAspectRatio: 170 / 120,
                  ),
                  itemBuilder: (context, index) {
                    final env_name = options.environmentTypes[index];
                    final environments = [
                      [Assets.iconsOnSite, env_name],
                      [Assets.iconsRemote, env_name],
                    ];
                    final env = environments[index];
                    return SelectableCard(
                      isEnvironment: true,
                      text: env[1],
                      svgPath: env[0],
                      isSelected:  cubit.state.selectedEnvironment == env[1],
                      onTap: () {
                        context.read<AtmosphereCubit>().selectEnvironment(env[1]);
                        onValid?.call(
                          context.read<AtmosphereCubit>().state.isValid,
                        );
                      },
                    );
                  },
                ),
                const SubTitle(title: "Interviewer Persona"),
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount:options.interviewerPersonalities.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    childAspectRatio: 170 / 120,
                  ),
                  itemBuilder: (context, index) {
                    final personas = [
                      [Assets.iconsHuggingFace, options.interviewerPersonalities[index]],
                      [Assets.iconsSlightlySmilingFace, options.interviewerPersonalities[index]],
                      [Assets.iconsThinkingFac, options.interviewerPersonalities[index]],
                      [Assets.iconsExpressionlessFace, options.interviewerPersonalities[index]],
                    ];
                    final p = personas[index];
                    return SelectableCard(
                      text: p[1],
                      svgPath: p[0],
                      isSelected: cubit.state.selectedPersona == p[1],
                      onTap: () {
                        cubit.selectPersona(p[1]);
                        context.read<AtmosphereCubit>().selectPersona(p[1]);
                        onValid?.call(
                          context.read<AtmosphereCubit>().state.isValid,
                        );
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
