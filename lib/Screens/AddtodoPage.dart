import 'package:TODO_LOGIN_APPLICATION/Controllers/TodoController.dart';
import 'package:TODO_LOGIN_APPLICATION/GetX_Helper/FirebaseController.dart';
import 'package:TODO_LOGIN_APPLICATION/Models/Todo.dart';
import 'package:TODO_LOGIN_APPLICATION/Screens/Home_drawer.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddtodoPage extends GetWidget<FirebaseController> {
  final TodoController todoController = Get.find();
  final int index;

  AddtodoPage({this.index});
  var mainColor = Color(0xff2470c7);

  @override
  Widget build(BuildContext context) {
    String text = '';
    if (!this.index.isNull) {
      text = todoController.todos[index].text;
    }
    TextEditingController textEditingController =
        TextEditingController(text: text);
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        drawer: Home_drawer(),
        appBar: AppBar(
          backgroundColor: mainColor,
          title: AutoSizeText(
            todoController.todos != null ? 'New Todo' : 'Edit Todo',
            style: TextStyle(
                fontFamily: 'Montserrat',
                fontSize: MediaQuery.of(context).size.height / 30),
          ),
          centerTitle: true,
        ),
        body: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                  maxLines: 5,
                  controller: textEditingController,
                  autofocus: true,
                  decoration: InputDecoration(
                    labelText: 'Enter todo here',
                    labelStyle: TextStyle(
                        fontFamily: 'Montserrat',
                        fontSize: MediaQuery.of(context).size.height / 45),
                    contentPadding: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 20.0),
                    focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                            color: const Color(0xFF074480), width: 2.0),
                        borderRadius: BorderRadius.circular(10.0)),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  )),
              new Padding(padding: EdgeInsets.only(top: 10)),
              RaisedButton(
                child: AutoSizeText((this.index.isNull) ? 'ADD' : 'UPDATE',
                    style: TextStyle(
                        fontFamily: 'Montserrat',
                        fontSize: MediaQuery.of(context).size.height / 40)),
                color: mainColor,
                onPressed: () {
                  if (this.index.isNull && textEditingController.text != "") {
                    todoController.todos
                        .add(Todo(text: textEditingController.text));
                  } else {
                    var editing = todoController.todos[index];
                    editing.text = textEditingController.text;
                    todoController.todos[index] = editing;
                  }
                  controller.add_todo(textEditingController.text);
                  textEditingController.clear();
                  Get.back();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
