import 'package:mission_up/data/models/task_type_model.dart';

abstract class TaskTypeDatasource {
  Future<void> createTaskType({required TaskTypeModel taskType});
  Future<List<TaskTypeModel>> getTaskTypes({required String uid});
  Future<void> updateTaskType({
    required String taskTypeId,
    required Map<String, dynamic> data,
  });
}
