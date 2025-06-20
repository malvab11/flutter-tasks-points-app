import 'package:flutter/material.dart';
import 'package:mission_up/shared/widgets/common_task_card.dart';
import 'package:mission_up/shared/widgets/common_text.dart';

class SecondSlide extends StatelessWidget {
  const SecondSlide();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const CommonText(
            text: 'Motiva con recompensas',
            fontSize: 35,
            fontWeight: FontWeight.bold,
            maxLines: 2,
          ),
          const SizedBox(height: 50),
          ...[
            ('Noche de Cine', false, 2),
            ('Comprar Lego', true, 3),
            ('Noche de Pizza', false, 1),
            ('Salida a Jugar', true, 1),
          ].map((e) => CommonTaskCard(tarea: e.$1, done: e.$2, puntaje: e.$3)),
        ],
      ),
    );
  }
}
