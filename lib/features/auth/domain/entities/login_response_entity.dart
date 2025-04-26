import 'package:equatable/equatable.dart';

class LoginResponseEntity extends Equatable {
  final String? token;
  final String? id;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? name;
  final String? username;
  final String? email;
  final bool? isEmailVerified;

  const LoginResponseEntity({
    this.token,
    this.id,
    this.createdAt,
    this.updatedAt,
    this.name,
    this.username,
    this.email,
    this.isEmailVerified,
  });

  @override
  List<Object?> get props => [
        token,
        id,
        createdAt,
        updatedAt,
        name,
        username,
        email,
        isEmailVerified,
      ];
}
