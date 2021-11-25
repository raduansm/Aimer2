import 'package:aminer_2/models/todoModel.dart';
import 'package:aminer_2/views/bloc/TodoBloc/todo_bloc.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// ignore: must_be_immutable
class AddTodo extends StatelessWidget {
  AddTodo();

  TextEditingController titleController = TextEditingController();

  int importance = 0;

  bool isAnyError = false;
  bool isVisible = true;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
          return BlocListener<TodoBloc, TodoState>(
            listener: (context, state) async {
              if (state is AddNewTodoCompleteState) {
                await Future.delayed(Duration(seconds: 1));
                BlocProvider.of<TodoBloc>(context).add(GetTodoListEvent());
                Navigator.pop(context);
              } else if (state is AddNewTodoFailedState) {
                await Future.delayed(Duration(seconds: 1));
                isVisible = true;
              }
            },
            child: Container(
              height: 300,
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Enter your AIM",
                    style: TextStyle(fontSize: 20),
                  ),
                  TextField(
                    controller: titleController,
                    decoration: InputDecoration(
                      labelText: 'Enter Title',
                      hintText: 'Enter Your Aim\'s title',
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Row(
                    children: [
                      Text("Select importance!"),
                      Spacer(),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            importance = 0;
                          });
                        },
                        child: Icon(
                          importance == 0 ? Icons.album_outlined : Icons.circle,
                          color: Colors.greenAccent,
                        ),
                      ),
                      SizedBox(
                        width: 25,
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            importance = 1;
                          });
                        },
                        child: Icon(
                          importance == 1 ? Icons.album_outlined : Icons.circle,
                          color: Colors.yellow,
                        ),
                      ),
                      SizedBox(
                        width: 25,
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            importance = 2;
                          });
                        },
                        child: Icon(
                          importance == 2 ? Icons.album_outlined : Icons.circle,
                          color: Colors.redAccent,
                        ),
                      ),
                    ],
                  ),
                  Spacer(),
                  Visibility(
                    visible: isAnyError,
                    child: Text(
                      'Enter a title and its importance',
                      style: TextStyle(
                        color: Colors.red,
                        height: 3,
                      ),
                    ),
                  ),
                  Visibility(
                    visible: isVisible,
                    child: ElevatedButton(
                      child: Text("Add to list"),
                      onPressed: () {
                        if (titleController.text.isNotEmpty) {
                          print(titleController.text);
                          print(importance);

                          TodoDetails todoDetails = TodoDetails(
                            title: titleController.text,
                            importance: importance,
                            isCompleted: false,
                          );

                          BlocProvider.of<TodoBloc>(context).add(AddNewTodoEvent(todoDetails: todoDetails));
                          setState(() {
                            isVisible = false;
                          });
                        } else {
                          setState(() {
                            isAnyError = true;
                          });
                        }
                      },
                    ),
                    replacement: BlocBuilder<TodoBloc, TodoState>(
                      builder: (context, state) {
                        return state is ProcessingState
                            ? Center(
                                child: CircularProgressIndicator(),
                              )
                            : state is AddNewTodoCompleteState
                                ? Icon(
                                    Icons.check_circle,
                                    color: Colors.green,
                                  )
                                : state is AddNewTodoFailedState
                                    ? Icon(
                                        Icons.error,
                                        color: Colors.red,
                                      )
                                    : Container();
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
