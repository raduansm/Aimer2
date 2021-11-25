import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'login_event.dart';
part 'login_state.dart';

class LogInBloc extends Bloc<LogInEvent, LogInState> {
  LogInBloc() : super(LoginInitial()) {
    on<LogInEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
