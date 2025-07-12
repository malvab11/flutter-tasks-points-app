import 'package:flutter/material.dart';
import 'package:mission_up/di/service_locator.dart';
import 'package:mission_up/ui/styles/text_styles.dart';
import 'package:mission_up/ui/viewmodels/home/task_type_viewmodel.dart';
import 'package:mission_up/ui/widgets/common_activity_card.dart';
import 'package:mission_up/ui/widgets/common_inputs.dart';
import 'package:provider/provider.dart';

class ActivitiesScreen extends StatelessWidget {
  final String? uid;
  const ActivitiesScreen({super.key, this.uid});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) {
        final viewModel = di<TaskTypeViewmodel>();
        viewModel.init(uid!); // carga inicial
        return viewModel;
      },
      child: const _ActivitiesScreenBody(),
    );
  }
}

class _ActivitiesScreenBody extends StatelessWidget {
  const _ActivitiesScreenBody();

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<TaskTypeViewmodel>();

    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _ActivitiesHeader(controller: viewModel.search),

          const SizedBox(height: 20),

          if (viewModel.isLoading)
            const Expanded(child: Center(child: CircularProgressIndicator()))
          else if (viewModel.errorService?.isNotEmpty == true)
            Expanded(child: Center(child: Text(viewModel.errorService!)))
          else
            const Expanded(child: _ActivitiesBody()),
        ],
      ),
    );
  }
}

class _ActivitiesHeader extends StatelessWidget {
  final TextEditingController controller;

  const _ActivitiesHeader({required this.controller});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.read<TaskTypeViewmodel>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Actividades', style: TextStyles.title),
        const SizedBox(height: 12),
        CommonInputs(
          controller: controller,
          keyboardType: TextInputType.text,
          label: 'Buscar',
          isPassword: false,
          icon: Icons.search,
          onChanged: (_) => viewModel.applyFilter(),
        ),
      ],
    );
  }
}

class _ActivitiesBody extends StatelessWidget {
  const _ActivitiesBody();

  @override
  Widget build(BuildContext context) {
    return Consumer<TaskTypeViewmodel>(
      builder: (_, viewModel, __) {
        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _ActivitySection(
                title: 'Tareas',
                activities: viewModel.tasksByType('Tareas'),
              ),
              const SizedBox(height: 20),
              _ActivitySection(
                title: 'Premios',
                activities: viewModel.tasksByType('Premios'),
              ),
              const SizedBox(height: 20),
              _ActivitySection(
                title: 'Castigos',
                activities: viewModel.tasksByType('Castigos'),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _ActivitySection extends StatelessWidget {
  final String title;
  final List activities;

  const _ActivitySection({required this.title, required this.activities});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: TextStyles.title),
        const SizedBox(height: 12),
        activities.isEmpty
            ? Text('No hay actividades', style: TextStyles.normalText)
            : ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: activities.length,
              separatorBuilder: (_, __) => const SizedBox(height: 12),
              itemBuilder: (_, index) {
                final activity = activities[index];
                return CommonTutorActivityCard(
                  text: activity.title,
                  icon:
                      Icons
                          .monetization_on, // puedes personalizar esto por tipo
                  onTap: () {},
                );
              },
            ),
      ],
    );
  }
}
