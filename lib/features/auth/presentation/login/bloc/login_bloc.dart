import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:dukaandaar/features/auth/data/models/user_model.dart';

import '../../../data/models/login_response_model.dart';
import '../../../data/repositories/auth_repository.dart';
import 'login_event.dart';
import 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthRepositoryImpl authRepositoryImpl;

  LoginBloc(this.authRepositoryImpl) : super(LoginInitial()) {
    on<LoginButtonPressed>(_handleLoginButtonPress);
  }

  void _handleLoginButtonPress(
      LoginButtonPressed event, Emitter<LoginState> emit) async {
    try {
      final response =
          await authRepositoryImpl.login(event.emailPhone, event.password);
      if (response == null || response.data == null) {
        emit(LoginFailure("No response from server"));
        return;
      }
      final data =
          response.data is String ? jsonDecode(response.data) : response.data;
      final loginResponse = Response.fromJson(data);
      if (loginResponse.statusCode == 400) {
        emit(LoginFailure("Login failed."));
        return;
      }
      if (loginResponse.data != null) {
        User user = User.fromJson(loginResponse.data['user']);
        emit(LoginSuccess(user, loginResponse.data['token']));
      } else {
        emit(LoginFailure("No user found for the given credentials."));
      }
    } catch (e, stacktrace) {
      print('Exception in bloc: $e');
      print('Stacktrace: $stacktrace');
      emit(LoginFailure("An error occurred."));
    }
  }
}
