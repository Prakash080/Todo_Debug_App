import 'package:TODO_LOGIN_APPLICATION/GetX_Helper/FirebaseController.dart';
import 'package:flutter/material.dart';

import 'Models/Todo.dart';

class TodoCard extends StatelessWidget {
  final String uid;
  final Todo todo;

  const TodoCard({Key key, this.uid, this.todo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          children: [
            Expanded(
              child: Text(
                todo.task,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Checkbox(
              value: todo.done,
              onChanged: (newValue) {
                FirebaseController().updateTodo(newValue, uid, todo.id);
              },
            ),
          ],
        ),
      ),
    );
  }
}
