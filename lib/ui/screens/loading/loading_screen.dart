import 'package:flutter/material.dart';
import 'package:mission_up/ui/styles/app_colors.dart';

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 50,
          children: [
            Image.asset("assets/images/logo_app.png"),
            CircularProgressIndicator(color: AppColors.whiteColor),
          ],
        ),
      ),
    );
  }
}
