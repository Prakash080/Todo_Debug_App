import 'package:TODO_LOGIN_APPLICATION/Controllers/TodoController.dart';
import 'package:TODO_LOGIN_APPLICATION/GetX_Helper/FirebaseController.dart';
import 'package:TODO_LOGIN_APPLICATION/Screens/Home_drawer.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:TODO_LOGIN_APPLICATION/todocard.dart';

class HomePage extends GetWidget<FirebaseController> {
  FirebaseAuth _auth = FirebaseAuth.instance;
  final String uid;
  var taskcollections = FirebaseFirestore.instance.collection('Todos');
  final TextEditingController _todoController = TextEditingController();
  HomePage({Key key, @required this.uid}) : super(key: key);

  DateTime now = new DateTime.now();
  final TodoController todoController = Get.put(TodoController());
  var mainColor = Color(0xff2470c7);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          backgroundColor: Colors.white,
          drawer: Home_drawer(),
          appBar: AppBar(
            backgroundColor: mainColor,
            title: AutoSizeText(
              'Welcome',
              style: TextStyle(
                  fontFamily: 'Montserrat',
                  fontSize: MediaQuery.of(context).size.height / 30.0),
            ),
            centerTitle: true,
          ),
          body: Column(
            children: <Widget>[
              SizedBox(
                height: 20,
              ),
              Text(
                "Add Todo Here:",
                style: TextStyle(
                  fontSize: MediaQuery.of(context).size.height / 35,
                  color: mainColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Card(
                margin: EdgeInsets.all(20),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: _todoController,
                        ),
                      ),
                      IconButton(
                        color: mainColor,
                        splashColor: mainColor,
                        icon: Icon(Icons.add),
                        onPressed: () {
                          if (_todoController.text != "") {
                            FirebaseController()
                                .addTodo(_todoController.text, controller.uid);
                            _todoController.clear();
                          }
                        },
                      )
                    ],
                  ),
                ),
              ),
              Text(
                "Your Todos List",
                style: TextStyle(
                  fontSize: MediaQuery.of(context).size.height / 40.0,
                  color: mainColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              GetX<TodoController>(
                init: Get.put<TodoController>(TodoController()),
                builder: (TodoController todoController) {
                  if (todoController != null && todoController.todos != null) {
                    return Expanded(
                      child: ListView.builder(
                        itemCount: todoController.todos.length,
                        itemBuilder: (_, index) {
                          return TodoCard(
                              uid: controller.uid,
                              todo: todoController.todos[index]);
                        },
                      ),
                    );
                  } else {
                    return Text("loading...");
                  }
                },
              )
            ],
          ),
        ));
  }
}
