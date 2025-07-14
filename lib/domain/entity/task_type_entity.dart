import 'package:cloud_firestore/cloud_firestore.dart';

class TaskTypeEntity {
  final String? id;
  final String type; // "tarea", "premio", "castigo"
  final String title; // "participar en clase", "hacer la cama", etc.
  final String? description; // Descripción opcional
  final int score;
  final bool isDeleted; // Para desactivarlas sin borrarlas
  final String createdBy; // ID del tutor
  final Timestamp createdAt; // Tiempo de creación

  TaskTypeEntity({
    this.id,
    required this.type,
    required this.title,
    this.description,
    required this.score,
    required this.isDeleted,
    required this.createdBy,
    required this.createdAt,
  });
}
