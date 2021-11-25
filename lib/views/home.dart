import 'package:aminer_2/constants/addTodo.dart';
import 'package:aminer_2/constants/completeList.dart';
import 'package:aminer_2/constants/todoList.dart';
import 'package:aminer_2/views/bloc/TodoBloc/todo_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return BlocListener<TodoBloc, TodoState>(
      listener: (context, state) {
        if (state is TaskCompletedSuccessfulState) {
          BlocProvider.of<TodoBloc>(context).add(GetTodoListEvent());
        }
      },
      child: Scaffold(
        backgroundColor: Color(0xFF7E909A),
        body: SafeArea(
          child: Container(
            padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
            child: Column(
              children: [
                Row(
                  children: [
                    Spacer(),
                    Row(
                      children: [
                        Icon(
                          Icons.verified_user,
                          color: Color(0xFFF8F8F8),
                        ),
                        SizedBox(width: 15),
                        Icon(
                          Icons.logout,
                          color: Color(0xFFF8F8F8),
                        ),
                      ],
                    )
                  ],
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    'My Aims',
                    style: GoogleFonts.dancingScript(
                      fontSize: 50,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFFF8F8F8),
                    ),
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
                BlocBuilder<TodoBloc, TodoState>(
                  builder: (context, state) {
                    return state is ProcessingState
                        ? Expanded(child: Center(child: CircularProgressIndicator()))
                        : state is GetTodoListCompletedStates
                            ? Expanded(
                                child: ListView.builder(
                                  physics: BouncingScrollPhysics(),
                                  itemCount: _currentIndex == 0 && state is GetTodoListCompletedStates
                                      ? state.todoList!.length
                                      : _currentIndex == 1 && state is GetTodoListCompletedStates
                                          ? state.completedList!.length
                                          : 0,
                                  itemBuilder: (context, index) {
                                    return _currentIndex == 0
                                        ? TodoList(
                                            todoDetails: state.todoList![index],
                                          )
                                        : CompletedList(index: index);
                                  },
                                ),
                              )
                            : state is GetTodoListFailedState
                                ? Expanded(
                                    child: Center(
                                      child: Icon(
                                        Icons.error_outline_rounded,
                                        color: Colors.red,
                                        size: 100,
                                      ),
                                    ),
                                  )
                                : Container();
                  },
                )
              ],
            ),
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.shifting,
          backgroundColor: Color(0xFFF1F1F1),
          currentIndex: _currentIndex,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.toc),
              label: "Aims",
              backgroundColor: Colors.greenAccent,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.done),
              label: "Completed",
              backgroundColor: Colors.lightBlueAccent,
            )
          ],
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
        ),
        floatingActionButton: Visibility(
          visible: _currentIndex == 0 ? true : false,
          child: FloatingActionButton(
            backgroundColor: Color(0xFF5BA3A8),
            onPressed: () {
              showCupertinoDialog(
                barrierDismissible: true,
                context: context,
                builder: (_) => AddTodo(),
              );
            },
            child: Icon(Icons.add),
          ),
        ),
      ),
    );
  }
}
