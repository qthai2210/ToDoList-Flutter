import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String? email;
  final String id;
  final String? name;
  final String? photo;

  UserEntity({
    this.email,
    required this.id,
    this.name,
    this.photo,
  });

  static var empty = UserEntity(id: '');

  bool get isEmpty => this == UserEntity.empty;
  bool get isNotEmpty => this != UserEntity.empty;
  @override
  // TODO: implement props
  List<Object?> get props => [email, id, name, photo];
}
