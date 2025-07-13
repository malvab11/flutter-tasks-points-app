import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mission_up/domain/entity/task_type_entity.dart';

class TaskTypeModel {
  final String? id;
  final String type;
  final String title;
  final String? description;
  final int score;
  final bool isDeleted;
  final String createdBy;
  final Timestamp createdAt;

  TaskTypeModel({
    this.id,
    required this.type,
    required this.title,
    this.description,
    required this.score,
    required this.isDeleted,
    required this.createdBy,
    required this.createdAt,
  });

  factory TaskTypeModel.fromJson(Map<String, dynamic> json, String id) {
    return TaskTypeModel(
      id: id,
      type: json['type'] ?? '',
      title: json['title'] ?? '',
      description: json['description'],
      score: json['score'],
      isDeleted: json['isDeleted'] ?? false,
      createdBy: json['createdBy'],
      createdAt: json['createdAt'] ?? Timestamp.now(),
    );
  }

  factory TaskTypeModel.fromEntity(TaskTypeEntity entity) {
    return TaskTypeModel(
      id: entity.id,
      type: entity.type,
      title: entity.title,
      description: entity.description,
      score: entity.score,
      isDeleted: entity.isDeleted,
      createdBy: entity.createdBy,
      createdAt: entity.createdAt,
    );
  }

  Map<String, dynamic> toJson({bool isCreated = false}) {
    return {
      'type': type,
      'title': title,
      'description': description,
      'score': score,
      'isDeleted': isDeleted,
      'createdBy': createdBy,
      'createdAt': isCreated ? FieldValue.serverTimestamp() : createdAt,
    };
  }

  TaskTypeEntity toEntity() {
    return TaskTypeEntity(
      id: id,
      type: type,
      title: title,
      description: description,
      score: score,
      isDeleted: isDeleted,
      createdBy: createdBy,
      createdAt: createdAt,
    );
  }
}
