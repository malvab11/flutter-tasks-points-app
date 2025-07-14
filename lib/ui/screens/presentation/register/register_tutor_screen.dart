import 'package:flutter/material.dart';
import 'package:mission_up/di/service_locator.dart';
import 'package:mission_up/ui/styles/app_colors.dart';
import 'package:mission_up/ui/styles/text_styles.dart';
import 'package:mission_up/ui/viewmodels/presentation/register_tutor_viewmodel.dart';
import 'package:mission_up/ui/widgets/common_button.dart';
import 'package:mission_up/ui/widgets/common_inputs.dart';
import 'package:provider/provider.dart';

class RegisterTutorScreen extends StatelessWidget {
  const RegisterTutorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => di<RegisterTutorViewModel>(),
      child: const _RegisterTutorScreenBody(),
    );
  }
}

class _RegisterTutorScreenBody extends StatelessWidget {
  const _RegisterTutorScreenBody();

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
            children: [
              _HeaderRegister(),
              const SizedBox(height: 20),
              _InputsRegister(),
              const SizedBox(height: 20),
              _RegisterButtons(),
            ],
          ),
        ),
      ),
    );
  }
}

class _HeaderRegister extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 20,
      children: [
        Text("Registrarme", style: TextStyles.title),
        Image.asset("assets/images/logo_app.png"),
      ],
    );
  }
}

class _InputsRegister extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<RegisterTutorViewModel>(
      builder: (context, viewModel, child) {
        return Column(
          spacing: 20,
          children: [
            CommonInputs(
              controller: viewModel.user,
              keyboardType: TextInputType.text,
              label: "Nombres y Apellidos",
              isPassword: false,
              onChanged: (_) => viewModel.registerButtonValidation(),
            ),
            CommonInputs(
              controller: viewModel.email,
              keyboardType: TextInputType.emailAddress,
              label: "Email",
              isPassword: false,
              onChanged: (_) => viewModel.registerButtonValidation(),
            ),
            CommonInputs(
              controller: viewModel.password,
              keyboardType: TextInputType.visiblePassword,
              label: "Contraseña",
              errorText:
                  viewModel.errorMessage.isNotEmpty
                      ? viewModel.errorMessage
                      : null,
              isPassword: true,
              isObscure: viewModel.isObscure,
              onPressed: () => viewModel.passwordVisibility(),
              onChanged: (_) => viewModel.registerButtonValidation(),
            ),
            CommonInputs(
              controller: viewModel.rpassword,
              keyboardType: TextInputType.visiblePassword,
              label: "Repetir Contraseña",
              isPassword: true,
              errorText:
                  viewModel.errorMessage.isNotEmpty
                      ? viewModel.errorMessage
                      : null,
              isObscure: viewModel.isObscure,
              onPressed: () => viewModel.passwordVisibility(),
              onChanged: (_) => viewModel.registerButtonValidation(),
            ),
          ],
        );
      },
    );
  }
}

class _RegisterButtons extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<RegisterTutorViewModel>(context);
    return Column(
      spacing: 20,
      children: [
        viewModel.isLoading
            ? const CircularProgressIndicator()
            : CommonButton(
              texto: "Registrarme",
              fondo: AppColors.coinColor,
              onPressed:
                  viewModel.isEnabled
                      ? () async {
                        await viewModel.registerTutor();
                        if (viewModel.registeredUser != null) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(viewModel.message)),
                          );
                          Navigator.pop(context);
                          viewModel.clearControllers();
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(viewModel.errorService)),
                          );
                        }
                      }
                      : null,
            ),
      ],
    );
  }
}
