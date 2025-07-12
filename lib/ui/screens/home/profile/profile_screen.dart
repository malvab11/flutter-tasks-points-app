import 'package:flutter/material.dart';
import 'package:mission_up/ui/styles/app_colors.dart';
import 'package:mission_up/ui/styles/text_styles.dart';
import 'package:mission_up/ui/widgets/common_activity_card.dart';

class ProfileScreen extends StatelessWidget {
  final String user;
  final String? email;
  const ProfileScreen({super.key, required this.user, this.email});

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
    return Column(
      spacing: 20,
      children: [
        CommonCard(
          text: 'Información',
          icon: Icons.account_circle,
          onTap: () {},
        ),
        CommonCard(text: 'Contraseña', icon: Icons.visibility, onTap: () {}),
        CommonCard(
          text: 'Notificaciones',
          icon: Icons.notifications,
          onTap: () {},
        ),
        CommonCard(
          text: 'Cerrar Sesión',
          icon: Icons.logout_outlined,
          onTap: () {},
        ),
      ],
    );
  }
}
