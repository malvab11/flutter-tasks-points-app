import 'package:flutter/material.dart';
import 'common_text.dart';

class CommonUserCard extends StatelessWidget {
  final String name;
  final bool selected;
  final int points;
  final String description;
  final String? descriptionAlt;
  final int tipo; // 1: puntaje, 2: acciones

  const CommonUserCard({
    Key? key,
    required this.name,
    required this.selected,
    required this.points,
    this.description = "2/10 tareas realizadas",
    this.descriptionAlt,
    this.tipo = 1,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      margin: const EdgeInsets.symmetric(vertical: 5),
      decoration: BoxDecoration(
        color: Colors.grey[900],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: selected ? Colors.orange : Colors.transparent,
          width: 2,
        ),
      ),
      child: Row(
        children: [
          CircleAvatar(radius: 20, backgroundColor: Colors.grey[700]),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CommonText(
                  text: name,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
                CommonText(
                  text: tipo == 1 ? description : (descriptionAlt ?? ''),
                  fontSize: 14,
                ),
              ],
            ),
          ),
          tipo == 1
              ? Row(
                children: [
                  CommonText(
                    text: points.toString(),
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.orange,
                  ),
                  const SizedBox(width: 5),
                  Icon(Icons.monetization_on, color: Colors.orange),
                ],
              )
              : Row(
                children: const [
                  Icon(Icons.check, color: Colors.orange),
                  SizedBox(width: 5),
                  Icon(Icons.close, color: Colors.orange),
                ],
              ),
        ],
      ),
    );
  }
}
