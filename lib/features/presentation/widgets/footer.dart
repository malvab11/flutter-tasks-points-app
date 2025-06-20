import 'package:flutter/material.dart';
import 'package:mission_up/shared/widgets/common_outlined_buttons.dart';

class PresentationFooter extends StatelessWidget {
  final VoidCallback onTutorTap;
  final VoidCallback onUserTap;

  const PresentationFooter({
    super.key,
    required this.onTutorTap,
    required this.onUserTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Color(0xFF1A1A1A),
        borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      child: Row(
        children: [
          Expanded(
            child: CommonOutlinedButton(
              text: "Soy Tutor",
              onPressed: onTutorTap,
              fontSize: 16,
              containerColor: Colors.green,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: CommonOutlinedButton(
              text: "Soy Alumno",
              onPressed: onUserTap,
              fontSize: 16,
              containerColor: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}
