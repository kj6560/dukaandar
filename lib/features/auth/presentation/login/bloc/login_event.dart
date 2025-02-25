import 'package:equatable/equatable.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

class LoginButtonPressed extends LoginEvent {
  final String emailPhone;
  final String password;

  const LoginButtonPressed({
    required this.emailPhone,
    required this.password,
  });

  @override
  List<Object> get props => [emailPhone, password];
}

class LoginWithUserId extends LoginEvent {
  final String emailPhone;
  final String password;
  final String fcmToken;
  final int userId;

  const LoginWithUserId(
      {required this.emailPhone,
      required this.password,
      required this.fcmToken,
      required this.userId});

  @override
  List<Object> get props => [emailPhone, password, fcmToken, userId];
}

class TogglePasswordVisibility extends LoginEvent {}

class EmailPhoneChanged extends LoginEvent {
  final String emailPhone;

  const EmailPhoneChanged({required this.emailPhone});

  @override
  List<Object> get props => [emailPhone];
}

class PasswordChanged extends LoginEvent {
  final String password;

  const PasswordChanged({required this.password});

  @override
  List<Object> get props => [password];
}
