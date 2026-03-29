import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/define_path_cubit/DefinePathCubit.dart';
import '../../bloc/define_path_cubit/define_path_state.dart';
import '../../bloc/options_cubit/user_preferences_options_cubit.dart';
import '../../../../configuration/widgets/customer_sub_title.dart';
import '../../../../configuration/widgets/customer_title.dart';
import '../../bloc/options_cubit/user_preferences_options_state.dart';
import '../widgets/selectable_Card.dart';

class StepDefinePath extends StatelessWidget {
  const StepDefinePath({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OptionsCubit, OptionsState>(
      builder: (context, optionsState) {
        if (optionsState.loading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (optionsState.error != null) {
          return Center(child: Text(optionsState.error!));
        }

        final options = optionsState.data;
        if (options == null) {
          return const SizedBox();
        }


        final cubit = context.read<DefinePathCubit>();
        final theme = Theme.of(context);
        return Padding(
          padding: const EdgeInsets.fromLTRB(20, 130, 20, 0),
          child: SingleChildScrollView(
            child: BlocBuilder<DefinePathCubit, DefinePathState>(
              builder: (context, state) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomerTitle(
                      title: "Define Your Path",
                      desc:
                      "Select your specialization and experience to tailor the questions.",
                    ),
                    SubTitle(title: "Target Role"),

                    /// Dropdown
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 14),
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.surface,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          isExpanded: true,
                          value: state.selectedTrack,
                          hint: const Text("Select your track"),
                          items: options.jobTitles
                              .map((e) =>
                              DropdownMenuItem(value: e, child: Text(e)))
                              .toList(),
                          onChanged: (v) => cubit.selectTrack(v!),
                        ),
                      ),
                    ),

                    if (state.selectedTrack == "Other") ...[
                      const SizedBox(height: 8),
                      TextField(
                        onChanged: cubit.writeRole,
                        decoration: InputDecoration(
                          hintText: "Write your track",
                          filled: true,
                          fillColor:  Theme.of(context).colorScheme.surface,

                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(color: theme.dividerColor),
                          ),
                        ),
                      ),
                    ],

                    SubTitle(title: "Experience Level"),
                    GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: options.userLevels.length,
                      gridDelegate:
                      const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 12,
                        mainAxisSpacing: 12,
                        childAspectRatio: 170 / 120,
                      ),
                      itemBuilder: (context, index) {
                        final level = options.userLevels[index];
                        return SelectableCard(
                          text: level,
                          svgPath: null,
                          isSelected: state.selectedLevel == level,
                          onTap: () => cubit.selectLevel(level),
                        );
                      },
                    ),
                  ],
                );
              },
            ),
          ),
        );
      },
    );
  }
}
