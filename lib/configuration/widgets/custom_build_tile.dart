import 'package:flutter/material.dart';
import 'package:hire_quest/configuration/theme/theme.dart';

class CustomBuildTile extends StatelessWidget {
  final VoidCallback? onTap;
  final String title;
  final bool isLogout;
  final bool isTrailing;
  final IconData? icon;
  final Color? colorIcon;
  final Widget? trailing;
  final Widget? image;

  const CustomBuildTile({
    super.key,
    this.icon,
    this.image,
    this.isLogout = false,
    this.isTrailing = false,
    required this.title,
    this.trailing,
    this.colorIcon,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final primaryColor = AppTheme.primary;
    final errorColor = AppTheme.error;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Card(
        margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 12),
        color: theme.colorScheme.surface,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
        ),
        child: InkWell(
          borderRadius: BorderRadius.circular(14),
          onTap: onTap,
          child: ListTile(
            leading: image ??
                Icon(
                  icon,
                  size: 28,
                  color: isLogout
                      ? errorColor
                      : (colorIcon ?? primaryColor),
                ),
            title: Text(
              title,
              style: theme.textTheme.bodyMedium?.copyWith(
                fontSize: 15,
                fontWeight: FontWeight.w500,
                color: primaryColor,
              ),
            ),
            trailing: isLogout
                ? null
                : (isTrailing
                ? trailing
                : Icon(
              Icons.arrow_forward_ios_rounded,
              size: 16,
              color: primaryColor,
            )),
          ),
        ),
      ),
    );
  }
}
