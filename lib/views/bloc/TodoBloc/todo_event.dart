part of 'todo_bloc.dart';

@immutable
abstract class TodoEvent extends Equatable {
  const TodoEvent();

  @override
  List<Object?> get props => [];
}

class GetTodoListEvent extends TodoEvent {}

class AddNewTodoEvent extends TodoEvent {
  final TodoDetails? todoDetails;

  AddNewTodoEvent({@required this.todoDetails});
  @override
  List<Object?> get props => [todoDetails!];
}

class EditTodoEvent extends TodoEvent {
  final TodoDetails? todoDetails;

  EditTodoEvent({@required this.todoDetails});

  @override
  List<Object?> get props => [todoDetails!];
}

class TaskCompletedEvent extends TodoEvent {
  final TodoDetails? todoDetails;
  TaskCompletedEvent({@required this.todoDetails});

  @override
  List<Object?> get props => [todoDetails!];
}
