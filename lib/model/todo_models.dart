import 'package:uuid/uuid.dart';

class ToDo {
  String toDo;
  String description;
  bool isDone;
  final String id;

  ToDo({required this.toDo, required this.description})
      : id = const Uuid().v4(),
        isDone = false;

  String get item => toDo;
  String get desc => description;
  String get getID => id;
  bool get getIsDone => isDone;

  set setToDo(String item) {
    toDo = item;
  }

  set setDesc(String desc) {
    description = desc;
  }

  void setIsDone() {
    isDone = !isDone;
  }
}