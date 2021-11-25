part of 'login_bloc.dart';

abstract class LogInState extends Equatable {
  const LogInState();

  @override
  List<Object> get props => [];
}

class LoginInitial extends LogInState {}
