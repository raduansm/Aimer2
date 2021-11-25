import 'package:aminer_2/models/todoModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class TodoRepository {
  FirebaseFirestore db = FirebaseFirestore.instance;

  Future<List<TodoDetails>> getTodoList() async {
    List<TodoDetails> todoList = [];
    var qs = await db.collection('todos').where('isCompleted', isEqualTo: false).get();

    if (qs.docs.length > 0) {
      qs.docs.forEach((element) {
        todoList.add(TodoDetails.fromJson(element.data()));
      });

      return todoList;
    } else {
      return todoList;
    }
  }

  Future<List<TodoDetails>> getCompletedList() async {
    List<TodoDetails> completedList = [];
    var qs = await db.collection('todos').where('isCompleted', isEqualTo: true).get();

    if (qs.docs.length > 0) {
      qs.docs.forEach((element) {
        completedList.add(TodoDetails.fromJson(element.data()));
      });

      return completedList;
    } else {
      return completedList;
    }
  }

  Future<bool> addTodo({@required TodoDetails? todoDetails}) async {
    String docId = db.collection('todos').doc().id;

    todoDetails!.tid = docId;

    bool isCompleted = false;

    await db.collection('todos').doc(docId).set(todoDetails.toJson()).then((value) {
      isCompleted = true;
    });

    return isCompleted;
  }

  Future<bool> editTodo({@required TodoDetails? todoDetails}) async {
    bool isCompleted = false;

    await db.collection('todos').doc(todoDetails!.tid).update(todoDetails.toJson()).then((value) {
      isCompleted = true;
    });

    return isCompleted;
  }

  Future<void> taskCompleted({@required TodoDetails? todoDetails}) async {
    todoDetails!.isCompleted = true;
    print(todoDetails.tid);
    await db.collection('todos').doc(todoDetails.tid).update(todoDetails.toJson());
  }
}
