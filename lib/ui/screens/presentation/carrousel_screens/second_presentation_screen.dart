import 'package:flutter/material.dart';
import 'package:mission_up/core/constants/activities_constants.dart';
import 'package:mission_up/ui/styles/app_colors.dart';
import 'package:mission_up/ui/styles/text_styles.dart';
import 'package:mission_up/ui/widgets/common_activity_card.dart';

class SecondPresentationScreen extends StatelessWidget {
  const SecondPresentationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Motiva con Recompensas",
          style: TextStyles.title,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 24),
        GridView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 20,
            mainAxisSpacing: 20,
          ),
          itemCount: rewardsConstants.length,
          itemBuilder: (context, index) {
            return Container(
              decoration: BoxDecoration(
                color: AppColors.blackColor,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.only(bottom: 20.0),
                child: CommonRewardsCard(rewards: rewardsConstants[index]),
              ),
            );
          },
        ),
      ],
    );
  }
}
