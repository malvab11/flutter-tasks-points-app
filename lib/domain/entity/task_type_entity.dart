class TaskTypeEntity {
  final String type; // "tarea", "premio", "castigo"
  final String title; // "participar en clase", "hacer la cama", etc.
  final String? description; // Descripción opcional
  final bool isDeleted; // Para desactivarlas sin borrarlas
  final String createdBy; // ID del tutor
  final DateTime createdAt; // Tiempo de creación

  TaskTypeEntity({
    required this.type,
    required this.title,
    this.description,
    required this.isDeleted,
    required this.createdBy,
    required this.createdAt,
  });
}
