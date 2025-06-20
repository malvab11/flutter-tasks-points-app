import 'package:flutter/material.dart';

class CommonTextField extends StatelessWidget {
  final TextEditingController controller;
  final String placeholder;
  final bool isPassword;
  final bool isShown;
  final int maxLines;
  final bool isError;
  final String? errorMessage;
  final TextInputType keyboardType;
  final VoidCallback onIconTap;

  const CommonTextField({
    super.key,
    required this.controller,
    required this.placeholder,
    this.isPassword = false,
    this.isShown = false,
    this.maxLines = 1,
    this.isError = false,
    this.errorMessage,
    this.keyboardType = TextInputType.text,
    required this.onIconTap,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      obscureText: isPassword && !isShown,
      maxLines: maxLines,
      decoration: InputDecoration(
        labelText: placeholder,
        labelStyle: const TextStyle(color: Colors.white),
        errorText: isError ? errorMessage : null,
        filled: true,
        fillColor: const Color(0xFF2C2C2C),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        suffixIcon:
            isPassword
                ? IconButton(
                  onPressed: onIconTap,
                  icon: Icon(
                    isShown ? Icons.visibility_off : Icons.visibility,
                    color: Colors.white,
                  ),
                )
                : null,
      ),
      style: const TextStyle(color: Colors.white),
    );
  }
}
