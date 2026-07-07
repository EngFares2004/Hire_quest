import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:hire_quest/generated/assets.dart';

import '../theme/theme.dart';

class CustomPhoneField extends StatefulWidget {
  final TextEditingController? controller;
  final String initialCountryCode;
  final String? Function(String?)? validator;
  final VoidCallback? onTap;
  final String? label;
  final IconData? suffixIcon;
  final bool isSuffix;

  const CustomPhoneField({
    super.key,
    this.label,
    this.controller,
    this.initialCountryCode = 'EG',
    this.validator,
    this.onTap,
    this.suffixIcon,
    this.isSuffix = false,
  });

  @override
  State<CustomPhoneField> createState() => _CustomPhoneFieldState();
}

class _CustomPhoneFieldState extends State<CustomPhoneField> {
  bool _isValid = true;
  bool _validated = false;

  void _handleValidation(String value) {
    final result = widget.validator?.call(value);

    setState(() {
      _validated = true;
      _isValid = result == null;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final borderColor = !_validated
        ? theme.dividerColor
        : (_isValid ? AppTheme.green : AppTheme.error);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.label != null)
          Text(
            widget.label!,
            style: theme.textTheme.bodyLarge?.copyWith(
              fontWeight: FontWeight.bold,
              color: AppTheme.primary,
            ),
          ),

        const SizedBox(height: 10),

        IntlPhoneField(
          controller: widget.controller,
          initialCountryCode: widget.initialCountryCode,
          autovalidateMode: AutovalidateMode.onUserInteraction,

          decoration: InputDecoration(
            hintText: 'Phone number',
            hintStyle: theme.textTheme.bodyMedium?.copyWith(
              color: theme.hintColor,
            ),
            filled: true,
            fillColor: theme.colorScheme.surface,

            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: borderColor, width: 1.5),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                color: _isValid ? AppTheme.primary : AppTheme.error,
                width: 2,
              ),
            ),

            suffixIcon: _buildSuffix(),
          ),

          onChanged: (phone) {
            _handleValidation(phone.completeNumber);
          },
        ),
      ],
    );
  }

  Widget? _buildSuffix() {
    if (widget.isSuffix) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            widget.suffixIcon ?? Icons.phone,
            color: AppTheme.primary,
          ),

          if (_validated)
            Padding(
              padding: const EdgeInsets.only(right: 8),
              child: (_isValid
                  ? Assets.icons.success
                  : Assets.icons.error)
                  .svg(height: 20, width: 20),
            ),
        ],
      );
    }

    if (_validated) {
      return Padding(
        padding: const EdgeInsets.only(right: 8),
        child: (_isValid
            ? Assets.icons.success
            : Assets.icons.error)
            .svg(height: 20, width: 20),
      );
    }

    return null;
  }
}