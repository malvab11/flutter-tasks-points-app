import 'package:flutter/material.dart';
import 'package:mission_up/features/register_user/screens/register_user_view_model.dart';
import 'package:mission_up/shared/widgets/common_icon.dart';
import 'package:mission_up/shared/widgets/common_outlined_buttons.dart';
import 'package:mission_up/shared/widgets/common_text.dart';
import 'package:mission_up/shared/widgets/common_text_field.dart';
import 'package:provider/provider.dart';

class RegisterUserScreen extends StatelessWidget {
  const RegisterUserScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) {
        return RegisterUserViewModel();
      },
      child: _RegisterUserContent(),
    );
  }
}

class _RegisterUserContent extends StatelessWidget {
  const _RegisterUserContent();

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<RegisterUserViewModel>();
    return RegisterUserView(viewModel: viewModel);
  }
}

class RegisterUserView extends StatelessWidget {
  const RegisterUserView({super.key, required this.viewModel});

  final RegisterUserViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: CommonIcon(
          size: 18,
          icon: Icons.arrow_back_ios_new,
          tint: Colors.orange,
          onPressed: () => viewModel.back(context),
        ),
        title: CommonText(
          text: "Registro con código de invitación",
          fontSize: 24,
          fontWeight: FontWeight.bold,
          maxLines: 2,
        ),
        centerTitle: true,
        backgroundColor: Colors.black,
      ),
      backgroundColor: Colors.black,
      body: RegisterUserContent(viewModel: viewModel),
    );
  }
}

class RegisterUserContent extends StatelessWidget {
  const RegisterUserContent({super.key, required this.viewModel});

  final RegisterUserViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              //Texto de Ingreso
              CommonText(
                text:
                    "Solicita al tutor el codigo de invitación para unirte a la familia",
                fontSize: 24,
                fontWeight: FontWeight.bold,
                textAlign: TextAlign.start,
                maxLines: 3,
              ),
              const SizedBox(height: 24),

              // Email
              CommonTextField(
                controller: viewModel.userDataController,
                placeholder: "Nombres y Apellidos",
                onIconTap: () {},
              ),
              const SizedBox(height: 12),

              // Contraseña
              CommonTextField(
                controller: viewModel.codeController,
                placeholder: "Codigo de Invitación",
                onIconTap: () {},
              ),
              const SizedBox(height: 12),

              // Botones
              CommonOutlinedButton(
                onPressed: () => viewModel.onRegisterPressed(context),
                text: "Iniciar Sesión",
                fontSize: 16,
                containerColor: Colors.green,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
