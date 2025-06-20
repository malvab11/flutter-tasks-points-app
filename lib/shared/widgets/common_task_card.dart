import 'package:flutter/material.dart';

class CommonTaskCard extends StatelessWidget {
  final bool done;
  final String tarea;
  final int puntaje;

  const CommonTaskCard({
    super.key,
    required this.done,
    required this.tarea,
    required this.puntaje,
  });

  @override
  Widget build(BuildContext context) {
    final Color backgroundColor =
        done ? const Color(0xFF2C2C2C) : const Color(0xFF1A1A1A);
    final Color coinColor = const Color(0xFFFF9800);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: done ? Colors.green : const Color(0xFF1A1A1A),
              borderRadius: BorderRadius.circular(50),
            ),
            child: done ? const Icon(Icons.check, color: Colors.white) : null,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              decoration: BoxDecoration(
                color: backgroundColor,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Text(
                      tarea,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 4,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Row(
                    children: [
                      Text(
                        '$puntaje',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: coinColor,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Icon(Icons.monetization_on, color: Colors.orange),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
