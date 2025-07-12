import 'package:flutter/material.dart';
import 'package:mission_up/core/constants/activities_constants.dart';
import 'package:mission_up/ui/styles/text_styles.dart';
import 'package:mission_up/ui/widgets/common_activity_card.dart';

class FirstPresentationScreen extends StatelessWidget {
  const FirstPresentationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Pequeñas tareas, grandes hábitos",
          style: TextStyles.title,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 24),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: activitiesConstants.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: CommonActivityCard(activities: activitiesConstants[index]),
            );
          },
        ),
        const SizedBox(height: 24),
      ],
    );
  }
}
