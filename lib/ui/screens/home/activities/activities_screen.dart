import 'package:flutter/material.dart';
import 'package:mission_up/ui/routes/app_routes.dart';
import 'package:mission_up/ui/styles/text_styles.dart';
import 'package:mission_up/ui/viewmodels/home/activities_viewmodel.dart';
import 'package:mission_up/ui/widgets/common_activity_card.dart';
import 'package:mission_up/ui/widgets/common_inputs.dart';
import 'package:provider/provider.dart';

class ActivitiesScreen extends StatelessWidget {
  final String? uid;
  const ActivitiesScreen({super.key, this.uid});

  @override
  Widget build(BuildContext context) {
    // Inicializa el ViewModel una vez tras el primer frame
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final viewModel = context.read<ActivitiesViewModel>();
      if (viewModel.uid.isEmpty && uid != null) {
        viewModel.init(uid!);
      }
    });

    return const _ActivitiesScreenBody();
  }
}

class _ActivitiesScreenBody extends StatelessWidget {
  const _ActivitiesScreenBody();

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<ActivitiesViewModel>();

    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _ActivitiesHeader(controller: viewModel.search),
          const SizedBox(height: 20),

          // Muestra el estado correspondiente
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
    final viewModel = context.read<ActivitiesViewModel>();
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
    return Consumer<ActivitiesViewModel>(
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
    final viewModel = context.read<ActivitiesViewModel>();

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
                  icon: Icons.monetization_on,
                  score: activity.score,
                  onTap: () async {
                    final result = await Navigator.pushNamed(
                      context,
                      AppRoutes.createActivity,
                      arguments: activity,
                    );
                    // Refresca la lista solo si se ha modificado algo
                    if (result == true && context.mounted) {
                      await viewModel.getTasksList();
                    }
                  },
                  onLongPress: () async {
                    final confirm = await showDialog<bool>(
                      context: context,
                      builder:
                          (context) => AlertDialog(
                            title: const Text('¿Eliminar actividad?'),
                            content: Text(
                              '¿Estás seguro de eliminar: "${activity.title}"?',
                            ),
                            actions: [
                              TextButton(
                                onPressed:
                                    () => Navigator.of(context).pop(false),
                                child: const Text('Cancelar'),
                              ),
                              TextButton(
                                onPressed:
                                    () => Navigator.of(context).pop(true),
                                child: const Text(
                                  'Eliminar',
                                  style: TextStyle(color: Colors.red),
                                ),
                              ),
                            ],
                          ),
                    );

                    if (confirm != true) return; // Si el usuario cancela

                    // Aquí eliminas
                    await viewModel.updateTaskType(activity.id);

                    if (!context.mounted) return;

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          viewModel.message ?? viewModel.errorService,
                        ),
                      ),
                    );
                  },
                );
              },
            ),
      ],
    );
  }
}
