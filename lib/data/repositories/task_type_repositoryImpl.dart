import 'package:mission_up/data/datasources/task_type/task_type_datasource.dart';
import 'package:mission_up/data/models/task_type_model.dart';
import 'package:mission_up/domain/entity/task_type_entity.dart';
import 'package:mission_up/domain/repositories/task_type_repository.dart';

class TaskTypeRepositoryImpl extends TaskTypeRepository {
  final TaskTypeDatasource datasource;

  TaskTypeRepositoryImpl({required this.datasource});
  @override
  Future<void> createTaskType({required TaskTypeEntity taskType}) async {
    final task = TaskTypeModel.fromEntity(taskType);
    await datasource.createTaskType(taskType: task);
  }

  @override
  Future<List<TaskTypeEntity>?> getTaskTypes({required String uid}) async {
    final tasks = await datasource.getTaskTypes(uid: uid);
    return tasks.map((it) => it.toEntity()).toList();
  }

  @override
  Future<void> updateTaskType({
    required String taskTypeId,
    required Map<String, dynamic> data,
  }) async {
    await datasource.updateTaskType(taskTypeId: taskTypeId, data: data);
  }
}
