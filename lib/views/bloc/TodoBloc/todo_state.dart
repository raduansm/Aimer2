part of 'todo_bloc.dart';

@immutable
abstract class TodoState extends Equatable {
  const TodoState();

  @override
  List<Object?> get props => [];
}

class TodoInitial extends TodoState {}

class ProcessingState extends TodoState {}

class GetTodoListCompletedStates extends TodoState {
  final List<TodoDetails>? todoList;
  final List<TodoDetails>? completedList;
  GetTodoListCompletedStates({@required this.todoList, @required this.completedList});
}

class GetTodoListFailedState extends TodoState {}

class AddNewTodoCompleteState extends TodoState {}

class AddNewTodoFailedState extends TodoState {}

class EditTodoCompleteState extends TodoState {}

class EditTodoFailedState extends TodoState {}

class TaskCompletedSuccessfulState extends TodoState {}
