import 'package:flutter/material.dart';
import 'package:mission_up/domain/entity/activity_entity.dart';
import 'package:mission_up/ui/styles/app_colors.dart';
import 'package:mission_up/ui/styles/text_styles.dart';

class CommonActivityCard extends StatelessWidget {
  final ActivityEntity activities;
  const CommonActivityCard({super.key, required this.activities});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color:
                activities.done == true
                    ? AppColors.greenColor
                    : AppColors.blackColor,
          ),
          child: activities.done == true ? Icon(Icons.check) : null,
        ),
        SizedBox(width: 12),
        Expanded(
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 20, horizontal: 15),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color:
                  activities.done == true
                      ? AppColors.grayColor
                      : AppColors.blackColor,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(activities.activity, style: TextStyles.normalText),
                Row(
                  children: [
                    Text(activities.score.toString(), style: TextStyles.coins),
                    SizedBox(width: 12),
                    Icon(
                      Icons.monetization_on_sharp,
                      color: AppColors.coinColor,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
