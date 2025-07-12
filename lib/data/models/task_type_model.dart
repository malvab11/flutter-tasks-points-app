import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mission_up/domain/entity/task_type_entity.dart';

class TaskTypeModel {
  final String type;
  final String title;
  final String? description;
  final bool isDeleted;
  final String createdBy;
  final Timestamp createdAt;

  TaskTypeModel({
    required this.type,
    required this.title,
    this.description,
    required this.isDeleted,
    required this.createdBy,
    required this.createdAt,
  });

  factory TaskTypeModel.fromJson(Map<String, dynamic> json) {
    return TaskTypeModel(
      type: json['type'] ?? '',
      title: json['title'] ?? '',
      description: json['description'],
      isDeleted: json['isDeleted'] ?? false,
      createdBy: json['createdBy'],
      createdAt: json['createdAt'] ?? Timestamp.now(),
    );
  }

  factory TaskTypeModel.fromEntity(TaskTypeEntity entity) {
    return TaskTypeModel(
      type: entity.type,
      title: entity.title,
      description: entity.description,
      isDeleted: entity.isDeleted,
      createdBy: entity.createdBy,
      createdAt: Timestamp.fromDate(entity.createdAt),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'type': type,
      'title': title,
      'description': description,
      'isDeleted': isDeleted,
      'createdBy': createdBy,
      'createdAt': FieldValue.serverTimestamp(),
    };
  }

  TaskTypeEntity toEntity() {
    return TaskTypeEntity(
      type: type,
      title: title,
      description: description,
      isDeleted: isDeleted,
      createdBy: createdBy,
      createdAt: createdAt.toDate(),
    );
  }
}
