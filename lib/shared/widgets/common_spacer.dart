import 'package:flutter/material.dart';

class CommonSpacer extends StatelessWidget {
  final double size;

  const CommonSpacer({super.key, required this.size});

  @override
  Widget build(BuildContext context) {
    return SizedBox(width: size, height: size);
  }
}
