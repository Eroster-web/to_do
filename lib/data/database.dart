import 'package:hive_flutter/hive_flutter.dart';

class ToDoDataBase {
  List toDoList = [];
  //reference the box
  final _myBox = Hive.box('mybox');
//1st time opening the app run this method
  void createInitialData() {
    toDoList = [
      ["Make something",false]
    ];
  }

  //load data from the database
  void loadData() {
    toDoList = _myBox.get("TODOLIST");
  }

  //update the database
  void updateData() {
    _myBox.put("TODOLIST", toDoList);
  }
}
