import 'package:flutter/material.dart';
import 'package:mission_up/di/service_locator.dart';
import 'package:mission_up/ui/routes/app_routes.dart';
import 'package:mission_up/ui/styles/app_colors.dart';
import 'package:mission_up/ui/styles/text_styles.dart';
import 'package:mission_up/ui/widgets/common_button.dart';
import 'package:mission_up/ui/widgets/common_inputs.dart';
import 'package:provider/provider.dart';
import 'package:mission_up/ui/viewmodels/presentation/login_tutor_viewmodel.dart';

class LoginTutorScreen extends StatelessWidget {
  const LoginTutorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => di<LoginTutorViewmodel>(),
      child: const _LoginTutorScreenBody(),
    );
  }
}

class _LoginTutorScreenBody extends StatelessWidget {
  const _LoginTutorScreenBody();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          leading: IconButton(
            onPressed: () => {Navigator.pop(context)},
            icon: Icon(Icons.arrow_back, color: AppColors.coinColor),
          ),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              _HeaderLogin(),
              const SizedBox(height: 20),
              _InputsLogin(),
              const SizedBox(height: 10),
              _LoginButtons(),
              Text("o", style: TextStyles.normalText),
              _SocialMediaButtons(),
            ],
          ),
        ),
      ),
    );
  }
}

class _HeaderLogin extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 20,
      children: [
        Text("Iniciar Sesión", style: TextStyles.title),
        Image.asset("assets/images/logo_app.png"),
      ],
    );
  }
}

class _InputsLogin extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<LoginTutorViewmodel>(
      builder: (context, viewModel, child) {
        return Column(
          spacing: 20,
          children: [
            CommonInputs(
              controller: viewModel.email,
              keyboardType: TextInputType.emailAddress,
              label: "Email",
              isPassword: false,
              onChanged: (_) => viewModel.loginButtonValidation(),
            ),
            CommonInputs(
              controller: viewModel.password,
              keyboardType: TextInputType.visiblePassword,
              label: "Contraseña",
              isPassword: true,
              isObscure: viewModel.isObscure,
              onPressed: () => viewModel.passwordVisibility(),
              onChanged: (_) => viewModel.loginButtonValidation(),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: Text("Olvide Contraseña", style: TextStyles.normalText),
            ),
          ],
        );
      },
    );
  }
}

class _LoginButtons extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<LoginTutorViewmodel>(context);
    return Column(
      spacing: 20,
      children: [
        viewModel.isLoading
            ? const CircularProgressIndicator()
            : CommonButton(
              texto: "Iniciar Sesión",
              fondo: AppColors.greenColor,
              onPressed:
                  viewModel.isEnabled
                      ? () async {
                        await viewModel.loginWithEmail();
                        if (viewModel.user != null) {
                          Navigator.pushNamed(context, AppRoutes.loading);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                'Bienvenido ${viewModel.user!.user}',
                              ),
                            ),
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(viewModel.errorService ?? 'Error'),
                            ),
                          );
                        }
                      }
                      : null,
            ),
        CommonButton(
          texto: "Registrarme",
          fondo: AppColors.coinColor,
          onPressed: () {
            Navigator.pushNamed(context, AppRoutes.registerTutor);
            viewModel.clearControllers();
          },
        ),
      ],
    );
  }
}

class _SocialMediaButtons extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 20,
      children: [
        Expanded(
          child: CommonButton(
            texto: "Google",
            fondo: AppColors.whiteColor,
            textStyle: TextStyles.buttonTextWhite,
            onPressed: () async {
              final viewModel = Provider.of<LoginTutorViewmodel>(
                context,
                listen: false,
              );
              await viewModel.loginWithSocial();
              if (viewModel.user != null) {
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(SnackBar(content: Text(viewModel.message!)));
                Navigator.pushNamed(context, '/loading');
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(viewModel.errorService ?? 'Error')),
                );
              }
            },
          ),
        ),
        Expanded(
          child: CommonButton(
            texto: "Facebook",
            fondo: AppColors.blueColor,
            icon: Icons.facebook,
            onPressed: () {
              //Navigator.pushNamed(context, '/register');
            },
          ),
        ),
      ],
    );
  }
}
