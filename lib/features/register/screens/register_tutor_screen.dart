import 'package:flutter/material.dart';
import 'package:mission_up/features/register/screens/register_tutor_view_model.dart';
import 'package:mission_up/shared/widgets/common_icon.dart';
import 'package:mission_up/shared/widgets/common_outlined_buttons.dart';
import 'package:mission_up/shared/widgets/common_spacer.dart';
import 'package:mission_up/shared/widgets/common_text.dart';
import 'package:mission_up/shared/widgets/common_text_field.dart';
import 'package:provider/provider.dart';

class RegisterTutorScreen extends StatelessWidget {
  const RegisterTutorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) {
        return RegisterTutorViewModel();
      },
      child: _RegisterTutorContent(),
    );
  }
}

class _RegisterTutorContent extends StatelessWidget {
  const _RegisterTutorContent();

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<RegisterTutorViewModel>();
    return RegisterTutorView(viewModel: viewModel);
  }
}

class RegisterTutorView extends StatelessWidget {
  const RegisterTutorView({super.key, required this.viewModel});

  final RegisterTutorViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: CommonIcon(
          size: 18,
          icon: Icons.arrow_back_ios_new,
          tint: Colors.orange,
          onPressed: () {
            viewModel.disposeControllers();
            viewModel.back;
          },
        ),
        title: CommonText(
          text: "Registrarme",
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
        centerTitle: true,
        backgroundColor: Colors.black,
      ),
      backgroundColor: Colors.black,
      body: RegisterTutorBody(viewModel: viewModel),
    );
  }
}

class RegisterTutorBody extends StatelessWidget {
  const RegisterTutorBody({super.key, required this.viewModel});

  final RegisterTutorViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              //Imagen de Aplicativo
              Image.asset('assets/images/logo_app.png'),
              const SizedBox(height: 24),

              // Nombres y Apellidos
              CommonTextField(
                controller: viewModel.userDataController,
                placeholder: "Nombres y Apellidos",
                onIconTap: () {},
              ),
              const SizedBox(height: 12),

              // Email
              CommonTextField(
                controller: viewModel.emailController,
                placeholder: "Email o Celular",
                onIconTap: () {},
              ),
              const SizedBox(height: 12),

              // Contraseña
              CommonTextField(
                controller: viewModel.passwordController,
                placeholder: "Contraseña",
                isPassword: true,
                isShown: viewModel.isShown,
                onIconTap: viewModel.onIconTap,
              ),
              const SizedBox(height: 12),

              // Repetir Contraseña
              CommonTextField(
                controller: viewModel.rpasswordController,
                placeholder: "Repetir Contraseña",
                isPassword: true,
                isShown: viewModel.isShown,
                onIconTap: viewModel.onIconTap,
              ),
              const SizedBox(height: 24),

              // Botones
              CommonOutlinedButton(
                onPressed: () => viewModel.onRegisterPressed(context),
                text: "Registrarme",
                fontSize: 16,
                containerColor: Colors.orange,
              ),

              const CommonSpacer(size: 12),
              const CommonText(text: "O", fontSize: 12),
              const CommonSpacer(size: 12),

              // Social buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CommonOutlinedButton(
                    onPressed: () {},
                    text: "Google",
                    textColor: Colors.black,
                    fontSize: 16,
                    containerColor: Colors.white,
                    icon: CommonIcon(
                      size: 15,
                      icon: Icons.g_mobiledata_rounded,
                      tint: Colors.black,
                    ),
                  ),
                  const CommonSpacer(size: 12),
                  CommonOutlinedButton(
                    onPressed: () {},
                    text: "Facebook",
                    fontSize: 16,
                    containerColor: Colors.blueAccent,
                    icon: CommonIcon(
                      size: 15,
                      icon: Icons.facebook,
                      tint: Colors.white,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
