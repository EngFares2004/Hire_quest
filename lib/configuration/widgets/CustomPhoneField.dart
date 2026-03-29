import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import '../../generated/assets.dart';
import '../theme/theme.dart';
import '../validatoin.dart';

class CustomPhoneField extends StatefulWidget {
  final TextEditingController? controller;
  final String initialCountryCode;
  final String? Function(String? )? validator;
  final void Function()? onTap;
  final String? label;
  final IconData? suffixIcon;
  final bool isSuffix;

  const CustomPhoneField({
    super.key,
    this.label,
    this.controller,
    this.initialCountryCode = 'EG',
    this.validator,
    this.suffixIcon,
    this.isSuffix = false,
    this.onTap,
  });

  @override
  State<CustomPhoneField> createState() => _CustomPhoneFieldState();
}

class _CustomPhoneFieldState extends State<CustomPhoneField> {
  bool _isValid = true;
  bool _isValidatedOnce = false;

  void _validate(String phone) {
    final message = widget.validator?.call(phone);

    setState(() {
      _isValidatedOnce = true;
      _isValid = message == null;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.label != null)
          Text(
            widget.label!,
            style: theme.textTheme.bodyLarge?.copyWith(
              fontWeight: FontWeight.bold,
              color: AppTheme.primary, // 👈 Theme Aware
            ),
          ),
        const SizedBox(height: 10),
        IntlPhoneField(
          controller: widget.controller,
          initialCountryCode: widget.initialCountryCode,
         /* validator: (value) {
            final phone = value?.completeNumber ?? '';
            return Validation.validatePhoneNumber(phone);
          },*/
          autovalidateMode: AutovalidateMode.onUserInteraction,

          decoration: InputDecoration(
            hintText: 'Phone number',

            hintStyle: theme.textTheme.bodyMedium?.copyWith(
              color: theme.hintColor,
            ),
            filled: true,
            fillColor: theme.colorScheme.surface,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                color: !_isValidatedOnce
                    ? theme.dividerColor
                    : (_isValid ? AppTheme.success : AppTheme.error),
                width: 1.5,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                color: !_isValidatedOnce
                    ? AppTheme.primary
                    : (_isValid ? AppTheme.green : AppTheme.error),
                width: 2,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: AppTheme.error, width: 1.5),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: AppTheme.error, width: 2),
            ),

            suffixIcon: widget.isSuffix
                ? Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (widget.suffixIcon == null)
                        Icon(Icons.phone, color: AppTheme.primary),

                      IconButton(
                        onPressed: widget.onTap,
                        icon: Icon(widget.suffixIcon, color: AppTheme.primary),
                      ),
                      if (_isValidatedOnce)
                        Padding(
                          padding: const EdgeInsets.only(right: 8),
                          child: SvgPicture.asset(
                            _isValid ? Assets.iconsSuccess : Assets.iconsError,
                            height: 20,
                            width: 20,
                          ),
                        ),
                    ],
                  )
                : (_isValidatedOnce
                      ? Padding(
                          padding: const EdgeInsets.only(right: 8),
                          child: SvgPicture.asset(
                            _isValid ? Assets.iconsSuccess : Assets.iconsError,
                            height: 20,
                            width: 20,
                          ),
                        )
                      : null),
          ),
          onChanged: (phone) {
            final value = phone.completeNumber;
            _validate(value);
          },
        ),
      ],
    );
  }
}
