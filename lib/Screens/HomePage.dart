import 'package:TODO_LOGIN_APPLICATION/Controllers/TodoController.dart';
import 'package:TODO_LOGIN_APPLICATION/GetX_Helper/FirebaseController.dart';
import 'package:TODO_LOGIN_APPLICATION/Screens/AddtodoPage.dart';
import 'package:TODO_LOGIN_APPLICATION/Screens/Home_drawer.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends GetWidget<FirebaseController> {
  final String uid;
  var taskcollections = FirebaseFirestore.instance.collection('Todos');
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
          floatingActionButton: FloatingActionButton(
            child: Icon(Icons.add),
            backgroundColor: mainColor,
            onPressed: () => Get.to(AddtodoPage()),
          ),
          body: Container(
            padding: EdgeInsets.only(left: 5, right: 5, top: 10),
            child: Obx(() => ListView.separated(
                itemBuilder: (context, index) => Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 0.0, horizontal: 5.0),
                      child: Card(
                        child: ListTile(
                          tileColor: mainColor,
                          title: AutoSizeText(todoController.todos[index].text,
                              style: (todoController.todos[index].done)
                                  ? TextStyle(
                                      color: Colors.red,
                                      decoration: TextDecoration.lineThrough,
                                      fontFamily: 'Montserrat',
                                      fontSize:
                                          MediaQuery.of(context).size.height /
                                              45,
                                    )
                                  : TextStyle(
                                      color: Theme.of(context)
                                          .textTheme
                                          .bodyText1
                                          .color,
                                      fontFamily: 'Montserrat',
                                      fontSize:
                                          MediaQuery.of(context).size.height /
                                              45,
                                    )),
                          leading: Checkbox(
                            activeColor: Colors.green,
                            value: todoController.todos[index].done,
                            onChanged: (v) {
                              var changed = todoController.todos[index];
                              changed.done = v;
                              todoController.todos[index] = changed;
                            },
                          ),
                          subtitle: AutoSizeText(
                              'Created on:${now.day}/${now.month}/${now.year}',
                              style: TextStyle(
                                  fontSize:
                                      MediaQuery.of(context).size.height / 60)),
                          trailing: IconButton(
                              icon: Icon(todoController.todos[index].done
                                  ? Icons.delete_forever
                                  : Icons.edit),
                              onPressed: () {
                                if (todoController.todos[index].done) {
                                  var removed = todoController.todos[index];
                                  todoController.todos.removeAt(index);
                                  Get.snackbar('Todo removed',
                                      'The todo "${removed.text}" was successfully removed.',
                                      mainButton: FlatButton(
                                        child: AutoSizeText('Undo'),
                                        onPressed: () {
                                          if (removed.isNull) {
                                            return;
                                          }
                                          todoController.todos
                                              .insert(index, removed);
                                          removed = null;
                                          if (Get.isSnackbarOpen) {
                                            Get.back();
                                          }
                                        },
                                      ));
                                } else {
                                  Get.to(AddtodoPage(
                                    index: index,
                                  ));
                                }
                              }),
                        ),
                      ),
                    ),
                separatorBuilder: (_, __) => Divider(),
                itemCount: todoController.todos.length)),
          ),
        ));
  }
}
