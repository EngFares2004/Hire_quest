import 'package:flutter/material.dart';

class UserAvatar extends StatelessWidget {
  final String? avatarUrl;
  final double size;
  final Color borderColor;
  final double borderWidth;

  const UserAvatar({
    super.key,
    required this.avatarUrl,
    this.size = 48,
    this.borderColor = Colors.transparent,
    this.borderWidth = 2,
  });

  @override
  Widget build(BuildContext context) {
    String? imageUrl;

    if (avatarUrl != null &&
        avatarUrl!.isNotEmpty &&
        avatarUrl != "string") {
      if (avatarUrl!.startsWith("http")) {
        imageUrl = avatarUrl;
      } else if (avatarUrl!.startsWith("/")) {
        imageUrl = "https://hirequest.runasp.net$avatarUrl";
      }
    }

    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: borderColor,
          width: borderWidth,
        ),
      ),
      child: ClipOval(
        child: imageUrl != null
            ? Image.network(
          imageUrl,
          fit: BoxFit.cover,
          errorBuilder: (_, __, ___) => _placeholder(),
          loadingBuilder: (context, child, progress) {
            if (progress == null) return child;
            return _placeholder();
          },
        )
            : _placeholder(),
      ),
    );
  }

  Widget _placeholder() {
    return Container(
      color: Colors.grey.shade300,
      alignment: Alignment.center,
      child: Icon(
        Icons.person,
        size: size * .55,
        color: Colors.grey.shade700,
      ),
    );
  }
}