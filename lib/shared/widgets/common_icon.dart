import 'package:flutter/material.dart';

class CommonIcon extends StatelessWidget {
  final double size;
  final String name;
  final String semanticLabel;
  final Color tint;
  final VoidCallback? onTap;

  const CommonIcon({
    super.key,
    required this.size,
    required this.name,
    required this.semanticLabel,
    required this.tint,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final iconWidget = Image.asset(name, width: size, height: size);

    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: size,
        height: size,
        child: Center(child: iconWidget),
      ),
    );
  }
}
