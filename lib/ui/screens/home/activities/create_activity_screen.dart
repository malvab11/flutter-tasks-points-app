import 'package:flutter/material.dart';
import 'package:mission_up/ui/styles/app_colors.dart';
import 'package:mission_up/ui/styles/text_styles.dart';
import 'package:mission_up/ui/widgets/common_activity_card.dart';
import 'package:mission_up/ui/widgets/common_button.dart';
import 'package:mission_up/ui/widgets/common_inputs.dart';

class CreateActivityScreen extends StatelessWidget {
  const CreateActivityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icon(Icons.arrow_back, color: AppColors.coinColor),
          ),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 20, // <-- usando spacing nativo
            children: [_HeaderCreateActivity(), _BodyCreateActivity()],
          ),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(12.0),
          child: CommonButton(
            texto: 'Guardar Actividad',
            fondo: AppColors.greenColor,
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
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 20,
      children: [
        CommonCard(
          text: 'Tipo Actividad',
          icon: Icons.keyboard_arrow_down_sharp,
          onTap: () {},
        ),
        CommonInputs(
          controller: TextEditingController(),
          keyboardType: TextInputType.text,
          label: 'Titulo de Actividad',
          isPassword: false,
        ),
        CommonInputs(
          controller: TextEditingController(),
          keyboardType: TextInputType.number,
          label: 'Puntaje',
          isPassword: false,
          icon: Icons.monetization_on,
        ),
      ],
    );
  }
}
