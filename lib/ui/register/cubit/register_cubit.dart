import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_list_app/domains/authentication_repository/authentication_repository.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit({required this.authenticationRepository})
      : super(RegisterState());

  final AuthenticationRepository authenticationRepository;

  Future<void> register(String email, String password) async {
    await authenticationRepository.createUserWithEmailAndPassword(
        email: email, password: password);
  }
}
