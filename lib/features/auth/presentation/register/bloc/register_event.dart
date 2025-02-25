import 'package:equatable/equatable.dart';

abstract class RegisterEvent extends Equatable {
  const RegisterEvent();
}

class RegisterSubmitted extends RegisterEvent {
  final String username;
  final String password;
  final String email;

  RegisterSubmitted({required this.username, required this.password, required this.email});

  @override
  List<Object> get props => [username, password, email];
}