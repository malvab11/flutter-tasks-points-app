import 'package:mission_up/domain/entity/task_type_entity.dart';

abstract class TaskTypeRepository {
  Future<void> createTaskType({required TaskTypeEntity taskType});
  Future<List<TaskTypeEntity>?> getTaskTypes({required String uid});
  Future<void> updateTaskType({
    required String taskTypeId,
    required Map<String, dynamic> data,
  });
}
