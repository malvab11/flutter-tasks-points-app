import 'package:flutter/material.dart';
import 'package:mission_up/di/service_locator.dart';
import 'package:mission_up/ui/styles/app_colors.dart';
import 'package:mission_up/ui/styles/text_styles.dart';
import 'package:mission_up/ui/viewmodels/home/profile_viewmodel.dart';
import 'package:mission_up/ui/widgets/common_activity_card.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatelessWidget {
  final String user;
  final String? email;
  const ProfileScreen({super.key, required this.user, this.email});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => di<ProfileViewModel>(),
      child: _ProfileScreenBody(user: user, email: email),
    );
  }
}

class _ProfileScreenBody extends StatelessWidget {
  final String user;
  final String? email;
  const _ProfileScreenBody({required this.user, this.email});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          spacing: 20,
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: Text('Perfil', style: TextStyles.title),
            ),
            _HeaderProfile(user: user, email: email),
            _ProfileBody(),
          ],
        ),
      ),
    );
  }
}

class _HeaderProfile extends StatelessWidget {
  final String user;
  final String? email;
  const _HeaderProfile({required this.user, required this.email});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: const BoxDecoration(
            color: AppColors.greenColor,
            shape: BoxShape.circle,
          ),
          height: 150,
          width: 150,
        ),
        Column(
          children: [
            Text(user, style: TextStyles.title),
            if (email != null && email!.isNotEmpty)
              Text(email!, style: TextStyles.normalText),
          ],
        ),
      ],
    );
  }
}

class _ProfileBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<ProfileViewModel>();
    return Column(
      spacing: 20,
      children: [
        // CommonCard(
        //   text: 'Información',
        //   icon: Icons.account_circle,
        //   onTap: () {},
        // ),
        // CommonCard(text: 'Contraseña', icon: Icons.visibility, onTap: () {}),
        // CommonCard(
        //   text: 'Notificaciones',
        //   icon: Icons.notifications,
        //   onTap: () {},
        // ),
        CommonCard(
          text: 'Cerrar Sesión',
          icon: Icons.logout_outlined,
          onTap: () async {
            await viewModel.logOut();
            if (!viewModel.isLoading) {
              Navigator.pushNamedAndRemoveUntil(
                context,
                '/presentation',
                (route) => false,
              );
            }
          },
        ),
      ],
    );
  }
}
