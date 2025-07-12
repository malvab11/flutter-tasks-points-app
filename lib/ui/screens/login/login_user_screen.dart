import 'package:flutter/material.dart';
import 'package:mission_up/ui/styles/app_colors.dart';
import 'package:mission_up/ui/styles/text_styles.dart';
import 'package:mission_up/ui/viewmodels/presentation/login_user_viewmodel.dart';
import 'package:mission_up/ui/widgets/common_button.dart';
import 'package:mission_up/ui/widgets/common_inputs.dart';
import 'package:provider/provider.dart';

class LoginUserScreen extends StatelessWidget {
  const LoginUserScreen({super.key});

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
              _HeaderLoginUser(),
              const SizedBox(height: 20),
              _InputsRegister(),
              const SizedBox(height: 10),
              _LoginUserButtons(),
            ],
          ),
        ),
      ),
    );
  }
}

class _HeaderLoginUser extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 20,
      children: [
        Text("Registro con código de Invitación", style: TextStyles.title),
        Text(
          "Solicita al tutor el código de invitación para unirte a la familia",
          style: TextStyles.normalText,
        ),
      ],
    );
  }
}

class _InputsRegister extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<LoginUserViewmodel>(
      builder: (context, viewModel, child) {
        return Column(
          spacing: 20,
          children: [
            CommonInputs(
              controller: viewModel.userData,
              keyboardType: TextInputType.text,
              label: "Nombres y Apellidos",
              isPassword: false,
              onChanged: (_) => viewModel.loginButtonValidation(),
            ),
            CommonInputs(
              controller: viewModel.familyCode,
              keyboardType: TextInputType.number,
              label: "Código de Invitación",
              isPassword: false,
              onChanged: (_) => viewModel.loginButtonValidation(),
            ),
          ],
        );
      },
    );
  }
}

class _LoginUserButtons extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<LoginUserViewmodel>(context);
    return Column(
      spacing: 20,
      children: [
        CommonButton(
          texto: "Unirme a la familia",
          fondo: AppColors.greenColor,
          onPressed:
              viewModel.isEnabled
                  ? () async {
                    await viewModel.loginWithCode();
                    if (viewModel.user != null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(viewModel.message!)),
                      );
                      Navigator.pushNamed(context, '/loading');
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
      ],
    );
  }
}
