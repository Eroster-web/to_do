import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:to_do/data/database.dart';
import 'package:to_do/utilities/todo_tile.dart';

import '../utilities/constants.dart';
import '../utilities/dialog_box.dart';

class HomePage extends StatefulWidget {
  final Box box;
  const HomePage({super.key, required this.box});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //text controller
  final _controller = TextEditingController();
  //TODO: HOmeWork move Database to main.dart
  final ToDoDataBase db = ToDoDataBase();

  @override
  void initState() {
    super.initState();
    //TODO :
    if (widget.box.get("TODOLIST") == null) {
      db.createInitialData();
      return;
    }
    db.loadData();
  }

//check box was tapped
  void checkBoxChanged(bool value, int index) {
    setState(() {
      db.toDoList[index].isChecked = value;
    });
    db.updateData();
  }

//save task
  void saveNewTask() {
    setState(() {
      db.toDoList.add(
        ListElement(
          false,
          _controller.text,
        ),
      );
      _controller.clear();
      Navigator.of(context).pop();
    });
    db.updateData();
  }

// create a new task
  void createNewTask() {
    showDialog(
      context: context,
      builder: (context) {
        return DialogBox(
          controller: _controller,
          onSave: saveNewTask,
          onCancel: () => Navigator.of(context).pop(),
        );
      },
    );
  }

// delete task
  void deleteTask(int index) {
    setState(() {
      db.toDoList.removeAt(index);
    });
    db.updateData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[400],
      appBar: AppBar(
        centerTitle: true,
        title: const Text(Constants.todo),
        elevation: 0,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: createNewTask,
        child: const Icon(Constants.add),
      ),
      body: ListView.builder(
        itemCount: db.toDoList.length,
        itemBuilder: (context, index) {
          return ToDoTile(
            taskName: db.toDoList[index].name,
            taskCompleted: db.toDoList[index].isChecked,
            onChanged: (value) => checkBoxChanged(value!, index),
            deleteFunction: () => deleteTask(index),
          );
        },
      ),
    );
  }
}
