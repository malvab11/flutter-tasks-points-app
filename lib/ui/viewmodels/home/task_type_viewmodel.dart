import 'package:flutter/material.dart';
import 'package:mission_up/core/errors/AuthExceptions.dart';
import 'package:mission_up/domain/entity/task_type_entity.dart';
import 'package:mission_up/domain/usecases/task_types/create_tasks_types_usecase.dart';
import 'package:mission_up/domain/usecases/task_types/get_tasks_types_usecase.dart';
import 'package:mission_up/domain/usecases/task_types/update_task_types_usecase.dart';

class TaskTypeViewmodel extends ChangeNotifier {
  final TextEditingController _searchController = TextEditingController();

  final GetTasksTypesUsecase _getTasksTypesUsecase;
  final CreateTasksTypesUsecase _createTasksTypesUsecase;
  final UpdateTaskTypesUsecase _updateTaskTypesUsecase;

  TaskTypeViewmodel(
    this._getTasksTypesUsecase,
    this._createTasksTypesUsecase,
    this._updateTaskTypesUsecase,
  );

  bool _isLoading = false;
  String _uid = '';
  String _errorService = '';
  List<TaskTypeEntity> _allTasks = [];
  List<TaskTypeEntity> _filteredTasks = [];

  bool get isLoading => _isLoading;
  String get uid => _uid;
  String? get errorService => _errorService.isNotEmpty ? _errorService : null;
  TextEditingController get search => _searchController;
  List<TaskTypeEntity>? get tasksFiltered => _filteredTasks;

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  void _setError(String? value) {
    _errorService = value ?? '';
    notifyListeners();
  }

  void _setUid(String uid) {
    _uid = uid;
    notifyListeners();
  }

  Future<void> init(String uid) async {
    _setUid(uid);
    await getTasksList();
    _searchController.addListener(applyFilter);
  }

  Future<void> getTasksList() async {
    _setLoading(true);
    _setError(null);
    try {
      _allTasks = await _getTasksTypesUsecase(uid: uid);
      _filteredTasks = List.from(_allTasks);
    } on AuthException catch (e) {
      _setError(e.message);
    } catch (e) {
      _setError(e.toString());
    } finally {
      _setLoading(false);
    }
  }

  void applyFilter() {
    final query = _searchController.text.trim().toLowerCase();
    if (query.isEmpty) {
      _filteredTasks = List.from(_allTasks);
    } else {
      _filteredTasks =
          _allTasks
              .where((task) => task.title.toLowerCase().contains(query))
              .toList();
    }
    notifyListeners();
  }

  List<TaskTypeEntity> tasksByType(String type) {
    return _filteredTasks.where((task) => task.type == type).toList();
  }

  Future<void> createTaskType(TaskTypeEntity task) async {
    _setLoading(true);
    _setError(null);
    try {
      await _createTasksTypesUsecase(taskType: task);
      await getTasksList();
    } catch (e) {
      _setError(e.toString());
    } finally {
      _setLoading(false);
    }
  }

  Future<void> updateTaskType(
    String taskTypeId,
    Map<String, dynamic> data,
    String uid,
  ) async {
    _setLoading(true);
    _setError(null);
    try {
      await _updateTaskTypesUsecase(taskTypeId: taskTypeId, data: data);
      await getTasksList();
    } catch (e) {
      _setError(e.toString());
    } finally {
      _setLoading(false);
    }
  }

  void clearControllers() {
    _searchController.clear();
    notifyListeners();
  }
}
