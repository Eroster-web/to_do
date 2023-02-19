import 'package:hive_flutter/hive_flutter.dart';

class ToDoDataBase {
  final List<ListElement> toDoList = [];
  //reference the box
  final _myBox = Hive.box('mybox');
//1st time opening the app run this method
  void createInitialData() => toDoList.add(
        ListElement(false, "Make something"),
      );
  //load data from the database
  void loadData() {
    toDoList.clear();
    final List lista = _myBox.get("TODOLIST");
    for (final element in lista) {
      final listItem = ListElement(element[1], element[0]);
      toDoList.add(listItem);
    }
  }

  //update the database
  void updateData() {
    _myBox.put("TODOLIST", toDoList);
  }
}

class ListElement {
  bool isChecked;
  final String name;

  ListElement(this.isChecked, this.name);
}
