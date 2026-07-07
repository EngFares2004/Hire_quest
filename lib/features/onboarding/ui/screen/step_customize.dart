import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:hire_quest/configuration/widgets/customer_sub_title.dart';
import 'package:hire_quest/configuration/widgets/customer_title.dart';
import '../../../../configuration/widgets/custom_dropdown.dart';
import '../../../../generated/assets.dart';

import '../../bloc/customize_cubit/customize_cubit.dart';
import '../../bloc/customize_cubit/customize_state.dart';
import '../../bloc/options_cubit/user_preferences_options_cubit.dart';
import '../widgets/selectable_Card.dart';

class StepCustomize extends StatelessWidget {
  final ValueChanged<bool>? onValid;

  const StepCustomize({super.key, this.onValid});

  @override
  Widget build(BuildContext context) {
    final options = context.watch<OptionsCubit>().state.data;
    final cubit = context.read<CustomizeCubit>();

    if (options == null) {
      return const Center(child: CircularProgressIndicator());
    }

    final genders = [
      {
        "icon": Assets.icons.manOffice,
        "key": options.interviewerGenders.isNotEmpty
            ? options.interviewerGenders[0]
            : "",
      },
      {
        "icon": Assets.icons.womanOffice,
        "key": options.interviewerGenders.length > 1
            ? options.interviewerGenders[1]
            : "",
      },
    ];

    return BlocBuilder<CustomizeCubit, CustomizeState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.fromLTRB(20, 130, 20, 0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                 CustomerTitle(
                  title: "Customize Interviewer",
                  desc: "Who will conduct your interview session?",
                ),

                const SubTitle(title: "Avatar Gender"),

                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: genders.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    childAspectRatio: 170 / 120,
                  ),
                  itemBuilder: (context, index) {
                    final item = genders[index];

                    final icon = item["icon"] as AssetGenImage;
                    final genderKey = item["key"] as String;

                    return SelectableCard(
                      text: genderKey,
                      assetsPath: icon,
                      isSelected: state.selectedGender == genderKey,
                      onTap: () {
                        cubit.selectGender(genderKey);

                        onValid?.call(state.isValid);
                      },
                    );
                  },
                ),

                const SizedBox(height: 20),

                const SubTitle(title: "Communication Language"),

                CustomDropdown(
                  value: state.selectedLanguage,
                  hint: "Select Language",
                  items: options.interviewLanguages,
                  onChanged: (v) {
                    cubit.selectLanguage(v);
                    onValid?.call(state.isValid);
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}