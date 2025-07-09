import 'package:flutter/material.dart';
import 'package:mission_up/ui/styles/app_colors.dart';
import 'package:mission_up/ui/styles/text_styles.dart';
import 'package:mission_up/ui/widgets/common_activity_card.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

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
            _HeaderProfile(),
            _ProfileBody(),
          ],
        ),
      ),
    );
  }
}

class _HeaderProfile extends StatelessWidget {
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
            Text('Marlon Alva', style: TextStyles.title),
            Text('marlonalvab@hotmail.com', style: TextStyles.normalText),
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
