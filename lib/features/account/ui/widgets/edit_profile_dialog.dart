import 'package:flutter/material.dart';

import '../../../../configuration/theme/theme.dart';
import '../../../../configuration/widgets/customer_bottom.dart';

Future<void> showEditProfileDialog({
  required BuildContext context,
  required String title,
  required TextEditingController controller,
  required VoidCallback onSave,
  TextInputType? keyboardType,
  String? hint,
  String? Function(String?)? validator, // 👈 إضافة validator
}) {
  final _formKey = GlobalKey<FormState>();

  return showDialog(
    context: context,
    barrierDismissible: true,
    builder: (_) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        insetPadding: const EdgeInsets.symmetric(horizontal: 24),
        title: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        content: Form(
          key: _formKey,
          child: TextFormField(
            controller: controller,
            autofocus: true,
            keyboardType: keyboardType,
            validator: validator,
            decoration: InputDecoration(
              hintText: hint ?? title,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ),
        actionsPadding:
        const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        actions: [
          SizedBox(
            height: 50,
            child: Row(
              children: [
                Expanded(
                  child: CustomBottom(
                    title: "Cancel",
                    textSize: 16,
                    color: AppTheme.white,
                    isOutline: true,
                    textColor: AppTheme.primary,
                    onTap: () => Navigator.pop(context),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: CustomBottom(
                    title: "Save",
                    textSize: 16,
                    onTap: () {
                      if (_formKey.currentState?.validate() ?? false) {

                        onSave();
                        Navigator.pop(context);
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      );
    },
  );
}
