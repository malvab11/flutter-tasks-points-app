import 'package:flutter/material.dart';
import 'package:mission_up/ui/widgets/common_activity_card.dart';

import '../../../../core/constants/activities_constants.dart';
import '../../../styles/text_styles.dart';

class InitScreen extends StatelessWidget {
  const InitScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final searchController = TextEditingController();

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _InitHeader(controller: searchController),
            const SizedBox(height: 20),
            _UsersSection(),
            const SizedBox(height: 20),
            _PointsSection(),
            const SizedBox(height: 20),
            _DatesSection(),
            const SizedBox(height: 20),
            _ActivitiesSection(),
          ],
        ),
      ),
    );
  }
}

class _InitHeader extends StatelessWidget {
  final TextEditingController controller;

  const _InitHeader({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Bienvenido, David', style: TextStyles.title),
        const SizedBox(height: 12),
        CommonCard(
          text: 'Codigo de Familia : 021932',
          icon: Icons.copy,
          onTap: () {},
        ),
        const SizedBox(height: 12),
        CommonCard(
          text: 'Mes : Junio',
          icon: Icons.keyboard_arrow_down_sharp,
          onTap: () {},
        ),
      ],
    );
  }
}

class _UsersSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(children: [CommonUserCard(users: userConstants[1])]);
  }
}

class _PointsSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Total de Puntos', style: TextStyles.title),
        Row(
          spacing: 12,
          children: [
            CommonRewardsCard(rewards: rewardsConstants[1]),
            CommonRewardsCard(rewards: rewardsConstants[2]),
          ],
        ),
      ],
    );
  }
}

class _DatesSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CommonRewardsCard(rewards: rewardsConstants[1]),
        CommonRewardsCard(rewards: rewardsConstants[2]),
      ],
    );
  }
}

class _ActivitiesSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CommonActivityCard(activities: activitiesConstants[0]),
        CommonActivityCard(activities: activitiesConstants[1]),
        CommonActivityCard(activities: activitiesConstants[2]),
      ],
    );
  }
}
