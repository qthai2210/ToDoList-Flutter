import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_list_app/domains/authentication_repository/authentication_repository.dart';
part 'login_cubit_state.dart';

class LoginCubitCubit extends Cubit<LoginCubitState> {
  final AuthenticationRepository authenticationRepository;

  LoginCubitCubit({required this.authenticationRepository})
      : super(const LoginCubitState(""));

  Future<void> login(String email, String password) async {
    await authenticationRepository.signInWithEmailAndPassword(
        email: email, password: password);
  }
}
