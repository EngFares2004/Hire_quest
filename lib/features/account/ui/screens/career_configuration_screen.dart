import 'package:flutter/material.dart';
import 'package:hire_quest/configuration/widgets/customer_arrow_back.dart';
import '../../../../configuration/theme/theme.dart';
import '../../../../configuration/widgets/customer_bottom.dart';

class CareerConfigurationScreen extends StatefulWidget {
  const CareerConfigurationScreen({super.key});

  @override
  State<CareerConfigurationScreen> createState() =>
      _CareerConfigurationScreenState();
}

class _CareerConfigurationScreenState
    extends State<CareerConfigurationScreen> {
  String careerPath = "Software Development";
  String experienceLevel = "Junior";
  String targetRole = "Flutter Developer";

  final List<String> skills = [
    "Flutter",
    "Dart",
    "Problem Solving",
    "Git",
    "APIs",
  ];

  final List<String> selectedSkills = [];

  final TextEditingController newSkillController = TextEditingController();

  @override
  void dispose() {
    newSkillController.dispose();
    super.dispose();
  }

  void _addNewSkill() {
    final newSkill = newSkillController.text.trim();
    if (newSkill.isNotEmpty && !skills.contains(newSkill)) {
      setState(() {
        skills.add(newSkill);
        selectedSkills.add(newSkill);
        newSkillController.clear();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(


      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomerArrowBack(title: 'Career Configuration',),
            _sectionTitle("Career Path"),
            _dropdown(
              value: careerPath,
              items: const [
                "Software Development",
                "UI/UX Design",
                "Data Science",
                "Cyber Security",
              ],
              onChanged: (v) => setState(() => careerPath = v),
            ),

            const SizedBox(height: 16),

            _sectionTitle("Experience Level"),
            _dropdown(
              value: experienceLevel,
              items: const ["Junior", "Mid-Level", "Senior"],
              onChanged: (v) => setState(() => experienceLevel = v),
            ),

            const SizedBox(height: 16),

            _sectionTitle("Target Role"),
            _dropdown(
              value: targetRole,
              items: const [
                "Flutter Developer",
                "Frontend Developer",
                "Backend Developer",
                "Full Stack Developer",
              ],
              onChanged: (v) => setState(() => targetRole = v),
            ),

            const SizedBox(height: 16),

            _sectionTitle("Main Skills"),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: skills.map((skill) {
                final isSelected = selectedSkills.contains(skill);
                return ChoiceChip(
                  label: Text(skill),
                  selected: isSelected,
                  selectedColor: AppTheme.primary.withOpacity(0.15),
                  onSelected: (_) {
                    setState(() {
                      isSelected
                          ? selectedSkills.remove(skill)
                          : selectedSkills.add(skill);
                    });
                  },
                );
              }).toList(),
            ),

            const SizedBox(height: 12),

            // Add new skill input
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: newSkillController,
                    decoration: InputDecoration(
                      hintText: "Add a new skill",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 10,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                 SizedBox(
                   width: 70,
                   height: 45,
                   child: CustomBottom(title:"Add" , onTap:_addNewSkill,
                   textSize: 14,),
                 )

              ],
            ),

            const Spacer(),

            CustomBottom(
              title: "Save Career Settings",
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      "Career configuration saved!\n"
                          "Skills: ${selectedSkills.join(", ")}",
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        title,
        style: const TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 14,
        ),
      ),
    );
  }

  Widget _dropdown({
    required String value,
    required List<String> items,
    required Function(String) onChanged,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(12),
      ),
      child: DropdownButton<String>(
        value: value,
        isExpanded: true,
        underline: const SizedBox(),
        items: items
            .map(
              (e) => DropdownMenuItem(
            value: e,
            child: Text(e),
          ),
        )
            .toList(),
        onChanged: (v) => onChanged(v!),
      ),
    );
  }
}
