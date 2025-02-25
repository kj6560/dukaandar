import 'package:flutter_bloc/flutter_bloc.dart';
import 'register_event.dart';
import 'register_state.dart';
import '../../../data/repositories/auth_repository.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final AuthRepositoryImpl authRepository;

  RegisterBloc({required this.authRepository}) : super(RegisterInitial());

  @override
  Stream<RegisterState> mapEventToState(RegisterEvent event) async* {
    if (event is RegisterSubmitted) {
      yield RegisterLoading();
      try {
        await authRepository.register(event.username, event.password, event.email);
        yield RegisterSuccess();
      } catch (e) {
        yield RegisterFailure(message: e.toString());
      }
    }
  }
}