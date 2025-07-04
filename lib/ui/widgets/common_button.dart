import 'package:flutter/material.dart';
import 'package:mission_up/ui/styles/button_styles.dart';

class CommonButton extends StatelessWidget {
  final String texto;
  final Color fondo;
  const CommonButton({super.key, required this.texto, required this.fondo});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: FilledButton(
        onPressed: () {},
        style: ButtonStyles.buttonStyle(background: fondo),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 15),
          child: Text(texto),
        ),
      ),
    );
  }
}
