part of 'login_cubit_cubit.dart';

class LoginCubitState extends Equatable {
  final String title;

  const LoginCubitState(this.title);
  @override
  List<Object> get props => [
        title,
      ];
}
