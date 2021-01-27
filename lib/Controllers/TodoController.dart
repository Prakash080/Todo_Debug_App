import 'package:TODO_LOGIN_APPLICATION/GetX_Helper/FirebaseController.dart';
import 'package:TODO_LOGIN_APPLICATION/Models/Todo.dart';
import 'package:get/get.dart';

class TodoController extends GetxController {
  Rx<List<Todo>> todoList = Rx<List<Todo>>();

  List<Todo> get todos => todoList.value;

  @override
  void onInit() {
    String uid = FirebaseController().uid;
    todoList
        .bindStream(FirebaseController().todoStream(uid)); //stream coming from firebase
  }
}
