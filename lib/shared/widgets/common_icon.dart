import 'package:flutter/material.dart';

class CommonIcon extends StatelessWidget {
  final double size;
  final IconData icon;
  final Color tint;
  final VoidCallback? onPressed;

  const CommonIcon({
    super.key,
    required this.size,
    required this.icon,
    required this.tint,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(icon, size: size, color: tint),
      onPressed: onPressed,
    );
  }
}
