import 'package:flutter/material.dart';
import 'package:mission_up/shared/widgets/common_task_card.dart';
import 'package:mission_up/shared/widgets/common_text.dart';

class FirstSlide extends StatelessWidget {
  const FirstSlide();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const CommonText(
            text: 'Pequeñas tareas',
            fontSize: 35,
            fontWeight: FontWeight.bold,
          ),
          const CommonText(
            text: 'Grandes hábitos',
            fontSize: 35,
            fontWeight: FontWeight.bold,
          ),
          const SizedBox(height: 15),
          ...[
            ('Hacer la cama', false, 2),
            ('Participar en clase', false, 3),
            ('Limpiar el cuarto', true, 1),
          ].map((e) => CommonTaskCard(tarea: e.$1, done: e.$2, puntaje: e.$3)),
        ],
      ),
    );
  }
}
