import 'package:aminer_2/controller/TodoRepository.dart';
import 'package:aminer_2/models/todoModel.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'todo_event.dart';
part 'todo_state.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  TodoBloc() : super(TodoInitial()) {
    TodoRepository todoRepository = TodoRepository();
    on<TodoEvent>((event, emit) async {
      emit(ProcessingState());
      List<TodoDetails> todoList = await todoRepository.getTodoList();
      List<TodoDetails> completedList = await todoRepository.getCompletedList();
      if (todoList.length > 0 || completedList.length > 0) {
        emit(GetTodoListCompletedStates(todoList: todoList, completedList: completedList));
      } else {
        emit(GetTodoListFailedState());
      }
    });

    on<AddNewTodoEvent>((event, emit) async {
      emit(ProcessingState());

      bool isSuccessed = await todoRepository.addTodo(todoDetails: event.todoDetails);

      if (isSuccessed) {
        emit(AddNewTodoCompleteState());
      } else {
        emit(AddNewTodoFailedState());
      }
    });

    on<EditTodoEvent>((event, emit) async {
      emit(ProcessingState());
      bool isSuccessed = await todoRepository.editTodo(todoDetails: event.todoDetails);
      if (isSuccessed) {
        emit(EditTodoCompleteState());
      } else {
        emit(EditTodoFailedState());
      }
    });

    on<TaskCompletedEvent>((event, emit) async {
      emit(ProcessingState());
      await todoRepository.taskCompleted(todoDetails: event.todoDetails);
      emit(TaskCompletedSuccessfulState());
    });
  }
}
