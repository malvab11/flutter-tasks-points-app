import 'package:flutter/material.dart';
import 'package:mission_up/ui/styles/app_colors.dart';

class TextStyles {
  static TextStyle title = TextStyle(fontSize: 25, fontWeight: FontWeight.bold);
  static TextStyle buttonText = TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.bold,
  );
  static TextStyle normalText = TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.normal,
  );
  static TextStyle coins = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.normal,
    color: AppColors.coinColor,
  );
}
