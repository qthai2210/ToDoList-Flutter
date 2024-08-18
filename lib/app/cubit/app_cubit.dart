import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_list_app/domains/authentication_repository/authentication_repository.dart';
import 'package:todo_list_app/main.dart';
import 'package:todo_list_app/utils/enum/authentication_status.dart';

part 'app_state.dart';

class AppCubit extends Cubit<AppState> {
  final AuthenticationRepository authenticationRepository;

  AppCubit({required this.authenticationRepository}) : super(const AppState()) {
    authenticationRepository.status.listen((status) {
      emit(state.copyWith(status: status));
    });
  }
}
