import 'package:flutter/material.dart';
import 'package:mission_up/ui/styles/button_styles.dart';
import 'package:mission_up/ui/styles/text_styles.dart';

class CommonButton extends StatelessWidget {
  final String texto;
  final Color fondo;
  final TextStyle? textStyle;
  final IconData? icon;
  final VoidCallback? onPressed;

  const CommonButton({
    super.key,
    required this.texto,
    required this.fondo,
    this.textStyle,
    this.icon,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: FilledButton(
        onPressed: onPressed,
        style: ButtonStyles.buttonStyle(background: fondo),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children:
                icon != null
                    ? [
                      Icon(icon),
                      const SizedBox(width: 10),
                      Text(texto, style: textStyle ?? TextStyles.buttonText),
                    ]
                    : [Text(texto, style: textStyle ?? TextStyles.buttonText)],
          ),
        ),
      ),
    );
  }
}
