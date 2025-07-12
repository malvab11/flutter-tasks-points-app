import 'package:mission_up/domain/repositories/task_type_repository.dart';

class UpdateTaskTypesUsecase {
  TaskTypeRepository repository;

  UpdateTaskTypesUsecase(this.repository);

  Future<void> call({
    required String taskTypeId,
    required Map<String, dynamic> data,
  }) {
    return repository.updateTaskType(taskTypeId: taskTypeId, data: data);
  }
}
