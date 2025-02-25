import 'package:flutter_bloc/flutter_bloc.dart';
import 'forgot_pass_event.dart';
import 'forgot_pass_state.dart';
import '../../../data/repositories/auth_repository.dart';

class ForgotPasswordBloc extends Bloc<ForgotPasswordEvent, ForgotPasswordState> {
  final AuthRepositoryImpl authRepository;

  ForgotPasswordBloc({required this.authRepository}) : super(ForgotPasswordInitial());

  @override
  Stream<ForgotPasswordState> mapEventToState(ForgotPasswordEvent event) async* {
    if (event is ForgotPasswordSubmitted) {
      yield ForgotPasswordLoading();
      try {
        await authRepository.forgotPassword(event.email);
        yield ForgotPasswordSuccess();
      } catch (e) {
        yield ForgotPasswordFailure(message: e.toString());
      }
    }
  }
}