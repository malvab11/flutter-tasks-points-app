import 'package:flutter/material.dart';
import 'package:mission_up/ui/styles/text_styles.dart';
import 'package:mission_up/ui/widgets/common_activity_card.dart';
import 'package:mission_up/ui/widgets/common_inputs.dart';

/// Pantalla que muestra las actividades divididas por secciones:
/// - Header: título e input de búsqueda.
/// - Body: secciones de Tareas, Premios y Castigos con scroll.
class ActivitiesScreen extends StatelessWidget {
  const ActivitiesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final searchController = TextEditingController();

    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Sección fija (no se desplaza al hacer scroll)
          _ActivitiesHeader(controller: searchController),

          const SizedBox(height: 20),

          /// Sección desplazable con scroll: tareas, premios y castigos
          const Expanded(child: _ActivitiesBody()),
        ],
      ),
    );
  }
}

/// Header con título y campo de búsqueda.
/// Esta parte se mantiene fija al hacer scroll.
class _ActivitiesHeader extends StatelessWidget {
  final TextEditingController controller;

  const _ActivitiesHeader({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Actividades', style: TextStyles.title),
        const SizedBox(height: 12),
        CommonInputs(
          controller: controller,
          keyboardType: TextInputType.text,
          label: 'Buscar',
          isPassword: false,
          icon: Icons.search,
        ),
      ],
    );
  }
}

/// Cuerpo de la pantalla con scroll vertical.
/// Incluye secciones: Tareas, Premios, Castigos.
class _ActivitiesBody extends StatelessWidget {
  const _ActivitiesBody();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          _ActivitySection(title: 'Tareas'),
          SizedBox(height: 20),
          _ActivitySection(title: 'Premios'),
          SizedBox(height: 20),
          _ActivitySection(title: 'Castigos'),
        ],
      ),
    );
  }
}

/// Componente reutilizable para renderizar una sección de actividades.
/// Puede adaptarse a tareas, premios o castigos.
class _ActivitySection extends StatelessWidget {
  final String title;

  const _ActivitySection({required this.title});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: TextStyles.title),
        const SizedBox(height: 12),
        ListView.separated(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          separatorBuilder: (context, index) => const SizedBox(height: 20),
          itemCount: 3, // ← aquí conectarás con Firestore
          itemBuilder: (context, index) {
            return CommonTutorActivityCard(
              text: 'Participar en clase',
              icon: Icons.monetization_on,
              onTap: () {
                // acción específica
              },
            );
          },
        ),
      ],
    );
  }
}
