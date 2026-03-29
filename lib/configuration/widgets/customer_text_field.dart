import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hire_quest/generated/assets.dart';
import '../theme/theme.dart';


class CustomTextField extends StatefulWidget {
  final String hintText;
  final String? label;
  final TextEditingController? controller;
  final bool isPassword;
  final bool isSuffix;
  final bool isEnabled;
  final TextInputType keyboardType;
  final Widget? prefixIcon;
  final  IconData?  suffixIcon;
  final String? Function(String?)? validator;

  const CustomTextField({
    super.key,
    required this.hintText,
    this.controller,
    this.isPassword = false,
    this.isSuffix = false,
    this.isEnabled= true,
    this.keyboardType = TextInputType.text,
    this.prefixIcon,
    this.suffixIcon,
    this.validator,
    this.label,
  });

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool _isObscured = true;
  bool _isValid = true;
  bool _isValidatedOnce = false;

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

        TextFormField(
          controller: widget.controller,
          obscureText: widget.isPassword ? _isObscured : false,
          keyboardType: widget.keyboardType,
          enabled: widget.isEnabled,

          validator: (value) {
            final message = widget.validator?.call(value);

            setState(() {
              _isValidatedOnce = true;
              _isValid = (message == null);
            });

            return message;
          },

          decoration: InputDecoration(
            iconColor:theme.dividerColor ,
            hintText: widget.hintText,
            hintStyle: theme.textTheme.bodyMedium?.copyWith(
              color: theme.hintColor, // 👈 Theme Aware
            ),
            filled: true,
            fillColor: theme.colorScheme.surface, // 👈 Theme Aware

            // ---------- BORDER STYLES ----------
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                color: !_isValidatedOnce
                    ? theme.dividerColor
                    : (_isValid ? AppTheme.green : AppTheme.error),
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
            disabledBorder:OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(

          color: !_isValidatedOnce
              ? theme.dividerColor
              : (_isValid ? AppTheme.green : AppTheme.error),
          width: 1.5,
        ),
      ),
            // ---------- ICONS ----------
            prefixIcon: widget.prefixIcon,

            suffixIcon: () {
              if (widget.isPassword) {
                // لو الحقل Password
                return Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: Icon(
                        _isObscured ? Icons.visibility_off : Icons.visibility,
                        color: AppTheme.primary,
                      ),
                      onPressed: () {
                        setState(() {
                          _isObscured = !_isObscured;
                        });
                      },
                    ),
                    if (_isValidatedOnce)
                      Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: SvgPicture.asset(
                          _isValid ? Assets.iconsSuccess : Assets.iconsError,
                          height: 24,
                          width: 24,
                        ),
                      ),
                  ],
                );
              } else if (widget.isSuffix && widget.suffixIcon != null) {
                return Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      widget.suffixIcon,
                      color: AppTheme.primary,
                    ),
                    if (_isValidatedOnce && widget.isEnabled)
                      Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: SvgPicture.asset(
                          _isValid ? Assets.iconsSuccess : Assets.iconsError,
                          height: 24,
                          width: 24,
                        ),
                      ),
                  ],
                );
              } else if (_isValidatedOnce) {
                return Padding(
                  padding: const EdgeInsets.only(right: 8, top: 10, bottom: 10),
                  child: SvgPicture.asset(
                    _isValid ? Assets.iconsSuccess : Assets.iconsError,
                    height: 8,
                    width: 8,
                  ),
                );
              } else {
                // لا suffix ولا validation
                return null;
              }
            }(),

          ),
        ),
      ],
    );
  }
}


