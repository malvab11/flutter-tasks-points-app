import 'package:flutter/material.dart';
import 'package:mission_up/ui/styles/app_colors.dart';
import 'package:mission_up/ui/styles/text_styles.dart';

class CommonInputs extends StatelessWidget {
  final TextEditingController controller;
  final TextInputType keyboardType;
  final String label;
  final String? errorText;
  final VoidCallback? onPressed;
  final bool isPassword;
  final bool? isObscure;
  final IconData? icon;
  final ValueChanged<String>? onChanged;

  const CommonInputs({
    super.key,
    required this.controller,
    required this.keyboardType,
    required this.label,
    this.errorText,
    this.onPressed,
    required this.isPassword,
    this.isObscure,
    this.icon,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      obscureText: isPassword && (isObscure ?? true),
      onChanged: onChanged,
      decoration: InputDecoration(
        label: Text(label, style: TextStyles.normalText),
        errorText: errorText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        filled: true,
        fillColor: AppColors.blackColor,
        suffixIcon:
            isPassword
                ? IconButton(
                  onPressed: onPressed,
                  icon:
                      (isObscure ?? true)
                          ? const Icon(Icons.visibility)
                          : const Icon(Icons.visibility_off),
                )
                : icon != null
                ? Icon(icon)
                : null,
      ),
    );
  }
}
