import 'package:flutter/widgets.dart';

class InitViewmodel extends ChangeNotifier {
  InitViewmodel() {
    final now = DateTime.now();
    _selectedMonth = _monthsList[now.month - 1];
  }

  //Variables
  String _selectedMonth = '';
  final List<String> _monthsList = [
    'Enero',
    'Febrero',
    'Marzo',
    'Abril',
    'Mayo',
    'Junio',
    'Julio',
    'Agosto',
    'Septiembre',
    'Octubre',
    'Noviembre',
    'Diciembre',
  ];

  //Getters
  String get selectedMonth => _selectedMonth;
  List<String> get monthsList => _monthsList;

  //Funciones
  void setSelectedMonth(String month) {
    _selectedMonth = month;
    notifyListeners();
  }
}
