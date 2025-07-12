import 'package:mission_up/domain/entity/task_type_entity.dart';
import 'package:mission_up/domain/repositories/task_type_repository.dart';

class GetTasksTypesUsecase {
  final TaskTypeRepository repository;

  GetTasksTypesUsecase({required this.repository});

  Future<List<TaskTypeEntity>?> call({required String uid}) {
    return repository.getTaskTypes(uid: uid);
  }
}
