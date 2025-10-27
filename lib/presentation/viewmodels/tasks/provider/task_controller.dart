import 'package:flutter/material.dart';

class TaskFormProvider with ChangeNotifier {
  DateTime? _startDate;
  DateTime? _dueDate;

  DateTime? get startDate => _startDate;
  DateTime? get dueDate => _dueDate;

  void setStartDate(DateTime date) {
    _startDate = date;
    notifyListeners();
  }

  void setDueDate(DateTime date) {
    _dueDate = date;
    notifyListeners();
  }

  void reset() {
    _startDate = null;
    _dueDate = null;
    notifyListeners();
  }
}
