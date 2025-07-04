import 'package:flutter/material.dart';
import 'package:mission_up/ui/styles/text_styles.dart';
import 'package:mission_up/ui/styles/app_colors.dart';

class ButtonStyles {
  static ButtonStyle buttonStyle({
    required Color background,
    Color? foreground = AppColors.whiteColor,
  }) {
    return FilledButton.styleFrom(
      backgroundColor: background,
      foregroundColor: foreground,
      textStyle: TextStyles.buttonText,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    );
  }
}
