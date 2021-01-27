import 'package:cloud_firestore/cloud_firestore.dart';

class Todo {
  String task;
  String id;
  bool done;
  Timestamp datecreated;

  Todo({this.task, this.id, this.done});

  Todo.fromDocumentSnapshot(
    DocumentSnapshot documentSnapshot,
  ) {
    id = documentSnapshot.id;
    task = documentSnapshot.get("content");
    datecreated = documentSnapshot.get("dateCreated");
    done = documentSnapshot.get("done");
  }
}
