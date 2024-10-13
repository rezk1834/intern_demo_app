import 'package:flutter_bloc/flutter_bloc.dart';

// Login Events
abstract class LoginEvent {}
class LoginSubmitted extends LoginEvent {
  final String phone;
  LoginSubmitted(this.phone);
}

// Login States
abstract class LoginState {}
class LoginInitial extends LoginState {}
class LoginLoading extends LoginState {}
class LoginSuccess extends LoginState {}
class LoginFailure extends LoginState {
  final String error;
  LoginFailure(this.error);
}

// BLoC Implementation
class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial());

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (event is LoginSubmitted) {
      yield LoginLoading();
      try {
        // Simulate a login delay
        await Future.delayed(Duration(seconds: 2));

        // Simple condition to mock login success/failure
        if (event.phone == "1234567890") {
          yield LoginSuccess();
        } else {
          yield LoginFailure("Invalid phone number. Please try again.");
        }
      } catch (e) {
        yield LoginFailure("An error occurred during login.");
      }
    }
  }
}
