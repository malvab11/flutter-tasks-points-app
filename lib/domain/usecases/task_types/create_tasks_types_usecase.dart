import 'package:mission_up/domain/entity/task_type_entity.dart';
import 'package:mission_up/domain/repositories/task_type_repository.dart';

class CreateTasksTypesUsecase {
  TaskTypeRepository repository;

  CreateTasksTypesUsecase({required this.repository});

  Future<void> call({required TaskTypeEntity taskType}) {
    return repository.createTaskType(taskType: taskType);
  }
}
