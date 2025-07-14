import 'package:flutter/material.dart';
import 'package:mission_up/di/service_locator.dart';
import 'package:mission_up/domain/entity/task_type_entity.dart';
import 'package:mission_up/ui/styles/app_colors.dart';
import 'package:mission_up/ui/styles/text_styles.dart';
import 'package:mission_up/ui/viewmodels/home/create_activities_viewmodel.dart';
import 'package:mission_up/ui/widgets/common_activity_card.dart';
import 'package:mission_up/ui/widgets/common_button.dart';
import 'package:mission_up/ui/widgets/common_inputs.dart';
import 'package:provider/provider.dart';

class CreateActivityScreen extends StatelessWidget {
  final TaskTypeEntity? activity;
  const CreateActivityScreen({super.key, this.activity});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) {
        final vm = di<CreateActivitiesViewmodel>();
        vm.init(activity);
        return vm;
      },
      child: _CreateActivityBody(activity: activity),
    );
  }
}

class _CreateActivityBody extends StatelessWidget {
  final TaskTypeEntity? activity;
  const _CreateActivityBody({required this.activity});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<CreateActivitiesViewmodel>();
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              viewModel.clearControllers();
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back, color: AppColors.coinColor),
          ),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 20,
            children: [_HeaderCreateActivity(), _BodyCreateActivity(activity)],
          ),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(12.0),
          child: CommonButton(
            texto: 'Guardar Actividad',
            fondo: AppColors.greenColor,
            onPressed:
                viewModel.isEnabled
                    ? () async {
                      if (viewModel.activity != null) {
                        await viewModel.updateTaskType(viewModel.activity!.id!);
                        if (viewModel.message != null) {
                          Navigator.pop(context, true);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(viewModel.message!)),
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(viewModel.message ?? 'Error'),
                            ),
                          );
                        }
                      } else {
                        await viewModel.createTaskType();
                        if (viewModel.message != null) {
                          Navigator.pop(context, true);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(viewModel.message!)),
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(viewModel.message ?? 'Error'),
                            ),
                          );
                        }
                      }
                    }
                    : null,
          ),
        ),
      ),
    );
  }
}

class _HeaderCreateActivity extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 20,
      children: [Text("Crear Actividad", style: TextStyles.title)],
    );
  }
}

class _BodyCreateActivity extends StatelessWidget {
  final TaskTypeEntity? activity;
  const _BodyCreateActivity(this.activity);
  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<CreateActivitiesViewmodel>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 20,
      children: [
        CommonCard(
          text: viewModel.selectedType ?? 'Tipo de Actividad',
          icon: Icons.keyboard_arrow_down_sharp,
          onTap: () async {
            final selected = await showDialog<String>(
              context: context,
              builder: (_) {
                return AlertDialog(
                  title: const Text('Tipo Actividad'),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children:
                        viewModel.typeActivities.map((type) {
                          return ListTile(
                            title: Text(type),
                            onTap: () {
                              Navigator.of(context).pop(type);
                            },
                          );
                        }).toList(),
                  ),
                );
              },
            );

            if (selected != null) {
              viewModel.setSelectedType(selected);
            }
          },
        ),
        CommonInputs(
          controller: viewModel.titleController,
          keyboardType: TextInputType.text,
          label: 'Titulo de Actividad',
          isPassword: false,
          onChanged: (_) => viewModel.setEnabled(),
        ),
        CommonInputs(
          controller: viewModel.scoreController,
          keyboardType: TextInputType.number,
          label: 'Puntaje',
          isPassword: false,
          icon: Icons.monetization_on,
          onChanged: (_) => viewModel.setEnabled(),
        ),
      ],
    );
  }
}
