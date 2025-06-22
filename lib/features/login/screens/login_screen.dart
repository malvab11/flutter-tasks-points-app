import 'package:flutter/material.dart';
import 'package:mission_up/features/login/screens/login_view_model.dart';
import 'package:mission_up/shared/widgets/common_icon.dart';
import 'package:mission_up/shared/widgets/common_outlined_buttons.dart';
import 'package:mission_up/shared/widgets/common_spacer.dart';
import 'package:mission_up/shared/widgets/common_text.dart';
import 'package:mission_up/shared/widgets/common_text_field.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) {
        return LoginViewModel();
      },
      child: _LoginContent(),
    );
  }
}

class _LoginContent extends StatelessWidget {
  const _LoginContent();

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<LoginViewModel>();
    return LoginView(viewModel: viewModel);
  }
}

class LoginView extends StatelessWidget {
  const LoginView({super.key, required this.viewModel});

  final LoginViewModel viewModel;

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
          text: "Iniciar Sesión",
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
        centerTitle: true,
        backgroundColor: Colors.black,
      ),
      backgroundColor: Colors.black,
      body: LoginContent(viewModel: viewModel),
    );
  }
}

class LoginContent extends StatelessWidget {
  const LoginContent({super.key, required this.viewModel});

  final LoginViewModel viewModel;

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

              //Boton de olvide contraseña
              Align(
                alignment: Alignment.centerRight,
                child: CommonText(
                  text: "¿Olvidaste tu contraseña?",
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.orange,
                ),
              ),

              const SizedBox(height: 24),

              // Botones
              CommonOutlinedButton(
                onPressed: () => viewModel.onLoginPressed(context),
                text: "Iniciar Sesión",
                fontSize: 16,
                containerColor: Colors.green,
              ),

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
