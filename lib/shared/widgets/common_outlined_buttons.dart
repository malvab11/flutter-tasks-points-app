import 'package:flutter/material.dart';

class CommonOutlinedButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final double fontSize;
  final Color containerColor;
  final Color borderColor;
  final Color textColor;
  final Widget? icon;
  final bool enabled;

  const CommonOutlinedButton({
    Key? key,
    required this.text,
    required this.onPressed,
    required this.fontSize,
    required this.containerColor,
    this.borderColor = Colors.transparent,
    this.textColor = Colors.white,
    this.icon,
    this.enabled = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: enabled ? onPressed : null,
      style: OutlinedButton.styleFrom(
        backgroundColor: containerColor,
        side: BorderSide(color: borderColor),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (icon != null) ...[icon!, const SizedBox(width: 5)],
          Text(
            text,
            style: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: textColor,
            ),
          ),
        ],
      ),
    );
  }
}
