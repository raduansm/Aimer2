import 'package:aminer_2/constants/EditTodoList.dart';
import 'package:aminer_2/models/todoModel.dart';
import 'package:aminer_2/views/bloc/TodoBloc/todo_bloc.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

class TodoList extends StatelessWidget {
  final TodoDetails? todoDetails;

  TodoList({@required this.todoDetails});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: MediaQuery.of(context).size.width,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () {
              BlocProvider.of<TodoBloc>(context).add(TaskCompletedEvent(todoDetails: todoDetails));
            },
            child: Container(
              width: 50,
              height: double.maxFinite,
              child: Icon(Icons.circle_outlined),
            ),
          ),
          SizedBox(
            width: 5,
          ),
          GestureDetector(
              onTap: () {
                showCupertinoDialog(
                    barrierDismissible: true,
                    context: context,
                    builder: (_) => EditTodo(
                          todoDetails: todoDetails,
                        ));
              },
              child: Container(
                alignment: Alignment.centerLeft,
                height: double.maxFinite,
                width: MediaQuery.of(context).size.width - 100,
                child: Text(todoDetails!.title.toString()),
              )),
          Spacer(),
          Icon(
            Icons.circle,
            color: todoDetails!.importance == 0
                ? Colors.green
                : todoDetails!.importance == 1
                    ? Colors.amber
                    : Colors.redAccent,
            size: 15,
          ),
        ],
      ),
    );
  }
}
