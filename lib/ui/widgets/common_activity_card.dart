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

class CommonRewardsCard extends StatelessWidget {
  final ActivityEntity rewards;

  const CommonRewardsCard({super.key, required this.rewards});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text(rewards.activity, style: TextStyles.normalText),
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 10,
          children: [
            Text(rewards.score.toString(), style: TextStyles.coins),
            Icon(Icons.monetization_on_sharp, color: AppColors.coinColor),
          ],
        ),
      ],
    );
  }
}

class CommonUserCard extends StatelessWidget {
  final UserEntity2 users;
  const CommonUserCard({super.key, required this.users});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: AppColors.blackColor,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.greenColor,
                ),
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(users.user, style: TextStyles.normalText),
                  Text(
                    "${users.tasks} tareas realizadas",
                    style: TextStyles.normalText,
                  ),
                ],
              ),
            ],
          ),
          Row(
            children: [
              Text(users.score.toString(), style: TextStyles.coins),
              const SizedBox(width: 12),
              const Icon(
                Icons.monetization_on_sharp,
                color: AppColors.coinColor,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class CommonTutorActivityCard extends StatelessWidget {
  final String text;
  final int score;
  final IconData icon;
  final VoidCallback onTap;
  final VoidCallback? onLongPress;

  const CommonTutorActivityCard({
    super.key,
    required this.text,
    required this.score,
    required this.icon,
    required this.onTap,
    this.onLongPress,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      onLongPress: onLongPress,
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.blackColor,
          borderRadius: BorderRadius.circular(16),
        ),
        padding: const EdgeInsets.all(20.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(text, style: TextStyles.normalText),
            Row(
              children: [
                Text(score.toString(), style: TextStyles.coins),
                const SizedBox(width: 12),
                const Icon(
                  Icons.monetization_on_sharp,
                  color: AppColors.coinColor,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class CommonCard extends StatelessWidget {
  final String text;
  final IconData icon;
  final VoidCallback onTap;

  const CommonCard({
    super.key,
    required this.text,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.blackColor,
          borderRadius: BorderRadius.circular(16),
        ),
        padding: const EdgeInsets.all(20.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [Text(text, style: TextStyles.normalText), Icon(icon)],
        ),
      ),
    );
  }
}
