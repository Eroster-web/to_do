// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import 'constants.dart';

typedef OnChanged = Function(bool?)?;

class ToDoTile extends StatelessWidget {
  final String taskName;
  final bool taskCompleted;
  final OnChanged onChanged;
  final VoidCallback deleteFunction;
  const ToDoTile({
    super.key,
    required this.taskName,
    required this.taskCompleted,
    required this.onChanged,
    required this.deleteFunction,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
          top: Constants.distancemedium,
          left: Constants.distancemedium,
          right: Constants.distancemedium),
      child: Slidable(
        endActionPane: ActionPane(
          motion: const StretchMotion(),
          children: [
            SlidableAction(
              onPressed: (context) => deleteFunction(),
              icon: Constants.delete,
              backgroundColor: Colors.grey.shade600,
              borderRadius: BorderRadius.circular(Constants.radius),
            ),
          ],
        ),
        child: Container(
          padding: const EdgeInsets.all(Constants.distancemedium),
          decoration: BoxDecoration(
            color: Constants.primary,
            borderRadius: BorderRadius.circular(Constants.radius),
          ),
          child: Row(
            children: [
              //check box
              Checkbox(
                value: taskCompleted,
                onChanged: onChanged,
              ),

              //task name

              Text(
                taskName,
                style: TextStyle(
                  decoration: taskCompleted
                      ? TextDecoration.lineThrough
                      : TextDecoration.none,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
