import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mission_up/core/errors/AuthExceptions.dart';
import 'package:mission_up/domain/entity/task_type_entity.dart';
import 'package:mission_up/domain/entity/user_entity.dart';
import 'package:mission_up/domain/usecases/auth/get_current_user_usecase.dart';
import 'package:mission_up/domain/usecases/task_types/create_tasks_types_usecase.dart';
import 'package:mission_up/domain/usecases/task_types/update_task_types_usecase.dart';

class CreateActivitiesViewmodel extends ChangeNotifier {
  //Controllers
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _scoreController = TextEditingController();

  //Use Case
  final CreateTasksTypesUsecase _createTasksTypesUsecase;
  final UpdateTaskTypesUsecase _updateTaskTypesUsecase;
  final GetCurrentUserUseCase _getCurrentUserUseCase;

  CreateActivitiesViewmodel(
    this._createTasksTypesUsecase,
    this._updateTaskTypesUsecase,
    this._getCurrentUserUseCase,
  );

  //Variables
  bool _isLoading = false;
  bool _isEnabled = false;
  String? _message = '';
  TaskTypeEntity? _activity;
  UserEntity? _user;
  List<String> _typeActivities = ['Tareas', 'Premios', 'Castigos'];
  String? _selectedType;

  //Getters
  TextEditingController get titleController => _titleController;
  TextEditingController get scoreController => _scoreController;
  bool get isLoading => _isLoading;
  bool get isEnabled => _isEnabled;
  String? get message => _message;
  TaskTypeEntity? get activity => _activity;
  List<String> get typeActivities => _typeActivities;
  String? get selectedType => _selectedType;

  //Local Functions
  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  void _setMessage(String? message) {
    _message = message;
    notifyListeners();
  }

  void init(TaskTypeEntity? activity) {
    _activity = activity;

    if (_activity != null) {
      _titleController.text = _activity!.title;
      _scoreController.text = _activity!.score.toString();
      _selectedType = _activity!.type;
      _isEnabled = true;
    }

    notifyListeners();
  }

  void setEnabled() {
    _isEnabled =
        _titleController.text.isNotEmpty && _scoreController.text.isNotEmpty;
    notifyListeners();
  }

  void setSelectedType(String value) {
    _selectedType = value;
    notifyListeners();
  }

  //Create Function
  Future<void> createTaskType() async {
    _setLoading(true);
    _setMessage(null);
    _user = null;
    try {
      _user = await _getCurrentUserUseCase();
      await _createTasksTypesUsecase(
        taskType: TaskTypeEntity(
          type: _selectedType!,
          title: _titleController.text.trim(),
          score: int.tryParse(_scoreController.text) ?? 0,
          isDeleted: false,
          createdBy: _user!.id,
          createdAt: Timestamp.fromDate(DateTime.now()),
        ),
      );
      _setMessage('Se creo la tarea: ${titleController.text}, con exito!!');
    } on AuthException catch (e) {
      _setMessage(e.message);
    } catch (e) {
      _setMessage(e.toString());
    } finally {
      _setLoading(false);
    }
  }

  //Update Function
  Future<void> updateTaskType(String taskTypeId) async {
    _setLoading(true);
    _setMessage(null);
    try {
      await _updateTaskTypesUsecase(
        taskTypeId: _activity!.id!,
        data: {
          'type': _selectedType,
          'title': _titleController.text.trim(),
          'score': int.parse(_scoreController.text),
        },
      );
      _setMessage('Felicidades, se actualizo la tarea!!!');
    } on AuthException catch (e) {
      _setMessage(e.message);
    } catch (e) {
      _setMessage(e.toString());
    } finally {
      _setLoading(false);
    }
  }

  //Clear Controllers
  void clearControllers() {
    _titleController.clear();
    _scoreController.clear();
    _setLoading(false);
    _setMessage(null);
    _activity = null;
    notifyListeners();
  }
}
