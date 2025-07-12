import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mission_up/core/errors/AuthExceptions.dart';
import 'package:mission_up/data/datasources/task_type/task_type_datasource.dart';
import 'package:mission_up/data/models/task_type_model.dart';

class TaskTypeDatasourceImpl extends TaskTypeDatasource {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  @override
  Future<void> createTaskType({required TaskTypeModel taskType}) async {
    try {
      await _firestore.collection('task_types').add(taskType.toJson());
    } catch (e) {
      throw AuthException(message: 'Error al intentar crear la tarea: $e');
    }
  }

  @override
  Future<List<TaskTypeModel>?> getTaskTypes({required String uid}) async {
    try {
      final tasksDoc =
          await _firestore
              .collection('task_types')
              .where('createdBy', isEqualTo: uid)
              .orderBy('createdAt', descending: true)
              .get();
      return tasksDoc.docs
          .map((it) => TaskTypeModel.fromJson(it.data()))
          .toList();
    } catch (e) {
      throw AuthException(message: 'Error al conseguir la lista de actividad');
    }
  }

  @override
  Future<void> updateTaskType({
    required String taskTypeId,
    required Map<String, dynamic> data,
  }) async {
    try {
      await _firestore.collection('task_types').doc(taskTypeId).update(data);
    } catch (e) {
      throw AuthException(message: 'Error al actualizar la tarea');
    }
  }
}
