import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mission_up/di/service_locator.dart';
import 'package:mission_up/ui/viewmodels/home/init_viewmodel.dart';
import 'package:mission_up/ui/widgets/common_activity_card.dart';
import 'package:provider/provider.dart';

import '../../../../core/constants/activities_constants.dart';
import '../../../styles/text_styles.dart';

class InitScreen extends StatelessWidget {
  final String user;
  final String code;
  const InitScreen({super.key, required this.user, required this.code});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => di<InitViewmodel>(),
      child: _InitScreenBody(user: user, code: code),
    );
  }
}

class _InitScreenBody extends StatelessWidget {
  final String user;
  final String code;
  const _InitScreenBody({required this.user, required this.code});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _InitHeader(user: user, code: code),
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
  final String user;
  final String code;

  const _InitHeader({required this.user, required this.code});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<InitViewmodel>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Bienvenido, $user', style: TextStyles.title),
        const SizedBox(height: 12),
        CommonCard(
          text: 'Codigo de Familia : $code',
          icon: Icons.copy,
          onTap: () {
            Clipboard.setData(ClipboardData(text: code));
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: const Text('Código copiado al portapapeles'),
                duration: const Duration(seconds: 2),
              ),
            );
          },
        ),
        const SizedBox(height: 12),
        CommonCard(
          text: 'Mes : ${viewModel.selectedMonth}',
          icon: Icons.keyboard_arrow_down_sharp,
          onTap: () async {
            final selected = await showDialog<String>(
              context: context,
              builder: (_) {
                return AlertDialog(
                  title: const Text('Mes'),
                  content: SizedBox(
                    height: 180,
                    width: double.maxFinite,
                    child: Scrollbar(
                      thumbVisibility: true,
                      radius: const Radius.circular(6),
                      thickness: 4,
                      child: ListView(
                        children:
                            viewModel.monthsList.map((type) {
                              return ListTile(
                                title: Text(type),
                                onTap: () {
                                  Navigator.of(context).pop(type);
                                },
                              );
                            }).toList(),
                      ),
                    ),
                  ),
                );
              },
            );

            if (selected != null) {
              viewModel.setSelectedMonth(selected);
            }
          },
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
