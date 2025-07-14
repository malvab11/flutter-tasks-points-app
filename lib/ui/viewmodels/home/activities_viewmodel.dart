import 'package:flutter/material.dart';
import 'package:mission_up/core/errors/AuthExceptions.dart';
import 'package:mission_up/domain/entity/task_type_entity.dart';
import 'package:mission_up/domain/usecases/task_types/get_tasks_types_usecase.dart';
import 'package:mission_up/domain/usecases/task_types/update_task_types_usecase.dart';

class ActivitiesViewModel extends ChangeNotifier {
  final TextEditingController _searchController = TextEditingController();

  final GetTasksTypesUsecase _getTasksTypesUsecase;
  final UpdateTaskTypesUsecase _updateTaskTypesUsecase;

  ActivitiesViewModel(this._getTasksTypesUsecase, this._updateTaskTypesUsecase);

  // =============================
  // Estado interno
  // =============================
  bool _isLoading = false;
  String _uid = '';
  String? _message;
  String _errorService = '';
  List<TaskTypeEntity> _allTasks = [];
  List<TaskTypeEntity> _filteredTasks = [];

  // =============================
  // Getters públicos
  // =============================
  TextEditingController get search => _searchController;
  bool get isLoading => _isLoading;
  String? get message => _message;
  String get uid => _uid;
  String get errorService => _errorService;
  List<TaskTypeEntity> get tasksFiltered => _filteredTasks;

  // =============================
  // Métodos privados de estado
  // =============================
  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  void _setError(String? value) {
    _errorService = value ?? '';
    notifyListeners();
  }

  void _setMessage(String? value) {
    _message = value;
    notifyListeners();
  }

  void _setUid(String value) {
    _uid = value;
  }

  // =============================
  // Inicialización del ViewModel
  // =============================
  Future<void> init(String uid) async {
    _setUid(uid);
    _searchController.addListener(applyFilter);
    await getTasksList();
  }

  // =============================
  // Obtener lista de tareas del backend
  // =============================
  Future<void> getTasksList() async {
    _setLoading(true);
    _setError(null);
    try {
      _allTasks = await _getTasksTypesUsecase(uid: uid);
      _filteredTasks = List.from(_allTasks);
    } on AuthException catch (e) {
      _setError(e.message);
    } catch (e) {
      _setError('Error inesperado: ${e.toString()}');
    } finally {
      _setLoading(false);
    }
  }

  // =============================
  // Actualizar una tarea en Firestore
  // =============================
  Future<void> updateTaskType(String taskTypeId) async {
    _setLoading(true);
    _setMessage(null);
    try {
      await _updateTaskTypesUsecase(
        taskTypeId: taskTypeId,
        data: {'isDeleted': true},
      );
      _setMessage('¡Se eliminó la tarea!');
      await getTasksList(); // Refresca la lista luego de eliminar
    } on AuthException catch (e) {
      _setMessage(e.message);
    } catch (e) {
      _setMessage('Error inesperado: ${e.toString()}');
    } finally {
      _setLoading(false);
    }
  }

  // =============================
  // Filtro en base a búsqueda
  // =============================
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

  // =============================
  // Obtener tareas por tipo
  // =============================
  List<TaskTypeEntity> tasksByType(String type) {
    return _filteredTasks
        .where((task) => task.type == type && task.isDeleted == false)
        .toList();
  }

  // =============================
  // Limpieza de estado
  // =============================
  void clearControllers() {
    _searchController.clear();
    notifyListeners();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}
