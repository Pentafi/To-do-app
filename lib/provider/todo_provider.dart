import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:todoapp/model/todo_models.dart';

class ToDoListProvider extends ChangeNotifier {
  final List<ToDo> _list = [];
  final List<ToDo> _completed = [];

  UnmodifiableListView<ToDo> get list => UnmodifiableListView(_list);
  UnmodifiableListView<ToDo> get completed => UnmodifiableListView(_completed);

  void add(ToDo item) {
    _list.add(item);
    notifyListeners();
  }

  void edit(String id, String edit, String descEdit) {
    int index = _list.indexWhere((e) => e.getID == id);
    _list[index].setToDo = edit;
    _list[index].setDesc = descEdit;
    notifyListeners();
  }

  void removeAllToDo() {
    _list.clear();
    notifyListeners();
  }

  void removeAllCompleted() {
    _completed.clear();
    notifyListeners();
  }

  void remove(String id) {
    int index = _list.indexWhere((e) => e.getID == id);
    _list.removeAt(index);
    notifyListeners();
  }

  void removeFromCompletedList(String id) {
    int index = _completed.indexWhere((e) => e.getID == id);
    _completed.removeAt(index);
    notifyListeners();
  }

  void setTaskComplete(String id) {
    int index = _list.indexWhere((e) => e.getID == id);
    _list[index].setIsDone();
    notifyListeners();
  }

  void setTaskUnfinish(String id) {
    int index = _completed.indexWhere((e) => e.getID == id);
    _completed[index].setIsDone();
    notifyListeners();
  }

  void transferCompleted(String id) {
    int index = _list.indexWhere((e) => e.getID == id);
    ToDo finished = _list[index];
    _completed.add(finished);
    _list.removeAt(index);
    notifyListeners();
  }

  void transferUnfinished(String id) {
    int index = _completed.indexWhere((e) => e.getID == id);
    ToDo unfinished = _completed[index];
    _list.add(unfinished);
    _completed.removeAt(index);
    notifyListeners();
  }
}
