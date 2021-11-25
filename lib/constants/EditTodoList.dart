import 'package:aminer_2/models/todoModel.dart';
import 'package:aminer_2/views/bloc/TodoBloc/todo_bloc.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditTodo extends StatelessWidget {
  final TodoDetails? todoDetails;

  EditTodo({@required this.todoDetails});

  final TextEditingController? titleEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    bool isAnyError = false;
    bool isVisible = true;
    int importanceTemp = 0;
    importanceTemp = todoDetails!.importance!.toInt();
    titleEditingController!.text = todoDetails!.title.toString();
    return Dialog(
      child: StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
          return BlocListener<TodoBloc, TodoState>(
            listener: (context, state) async {
              if (state is EditTodoCompleteState) {
                await Future.delayed(Duration(seconds: 1));
                BlocProvider.of<TodoBloc>(context).add(GetTodoListEvent());
                Navigator.pop(context);
              } else if (state is EditTodoFailedState) {
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
                    controller: titleEditingController,
                    decoration: InputDecoration(
                      labelText: "Title",
                      hintText: 'Enter title here',
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
                            importanceTemp = 0;
                          });
                        },
                        child: Icon(
                          importanceTemp == 0 ? Icons.album_outlined : Icons.circle,
                          color: Colors.greenAccent,
                        ),
                      ),
                      SizedBox(
                        width: 25,
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            importanceTemp = 1;
                          });
                        },
                        child: Icon(
                          importanceTemp == 1 ? Icons.album_outlined : Icons.circle,
                          color: Colors.yellow,
                        ),
                      ),
                      SizedBox(
                        width: 25,
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            importanceTemp = 2;
                          });
                        },
                        child: Icon(
                          importanceTemp == 2 ? Icons.album_outlined : Icons.circle,
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
                      child: Text("Confirm Edit"),
                      onPressed: () {
                        if (titleEditingController!.text.isNotEmpty) {
                          todoDetails!.title = titleEditingController!.text;
                          todoDetails!.importance = importanceTemp;

                          BlocProvider.of<TodoBloc>(context).add(EditTodoEvent(todoDetails: todoDetails));

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
                            : state is EditTodoCompleteState
                                ? Icon(
                                    Icons.check_circle,
                                    color: Colors.green,
                                  )
                                : state is EditTodoFailedState
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
