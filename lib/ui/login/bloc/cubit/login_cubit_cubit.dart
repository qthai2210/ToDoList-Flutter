import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'login_cubit_state.dart';

class LoginCubitCubit extends Cubit<LoginCubitState> {
  LoginCubitCubit() : super(const LoginCubitState(""));

  void login(String email, String password) {
    print("Login with email: $email, password: $password");
  }
}
