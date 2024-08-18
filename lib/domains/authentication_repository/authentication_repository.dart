import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:todo_list_app/domains/authentication_repository/data_sources/firebase_auth_service.dart';
import 'package:todo_list_app/domains/authentication_repository/entities/user_entity.dart';
import 'package:todo_list_app/utils/enum/authentication_status.dart';

abstract class AuthenticationRepository {
  Stream<AuthenticationStatus> get status;
  Stream<UserEntity> get user;
  Future<void> signInWithEmailAndPassword(
      {required email, required String password});
  Future<void> createUserWithEmailAndPassword(
      {required email, required String password});
}

class AuthenticationRepositoryImp extends AuthenticationRepository {
  final FirebaseAuthService firebaseAuthService;

  final _statuscontroller = StreamController<AuthenticationStatus>();
  final _userController = StreamController<UserEntity>();

  AuthenticationRepositoryImp(
      {required FirebaseAuthService firebaseAuthService})
      : firebaseAuthService = firebaseAuthService {
    firebaseAuthService.user.listen((firebaseUser) {
      final isLoggedIn = firebaseUser != null;
      // biển đổi từ firebaseuser thành userentity
      final user = isLoggedIn ? firebaseUser.toUserEntity : UserEntity.empty;
      _userController.sink.add(user);
      if (isLoggedIn) {
        _statuscontroller.sink.add(AuthenticationStatus.authenticated);
      } else {
        _statuscontroller.sink.add(AuthenticationStatus.unauthenticated);
      }
    });
  }
  @override
  Future<void> signInWithEmailAndPassword(
      {required email, required String password}) async {
    try {
      await firebaseAuthService.signInWithEmailAndPassword(
          email: email, password: password);
    } catch (e) {
      print(e);
    }
  }

  @override
  Future<void> createUserWithEmailAndPassword(
      {required email, required String password}) async {
    try {
      return firebaseAuthService.createUserWithEmailAndPassword(
          email: email, password: password);
    } catch (e) {
      print(e);
    }
  }

  @override
  // TODO: implement status
  Stream<AuthenticationStatus> get status async* {
    yield AuthenticationStatus.authenticated;
    yield* _statuscontroller.stream;
  }

  @override
  // TODO: implement user
  Stream<UserEntity> get user async* {
    yield UserEntity.empty;
    yield* _userController.stream;
  }
}

extension UserFirebaseAuthExtension on User {
  UserEntity get toUserEntity {
    return UserEntity(
      email: email,
      id: uid,
      name: displayName,
      photo: photoURL,
    );
  }
}
