import 'package:aspectumai/features/auth/domain/entities/login_response_entity.dart';

class LoginResponseModel extends LoginResponseEntity {
  const LoginResponseModel({
    super.id,
    super.name,
    super.email,
    super.createdAt,
    super.updatedAt,
    super.isEmailVerified,
    super.token,
    super.username,
  });

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) {
    return LoginResponseModel(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      createdAt:
          json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
      updatedAt:
          json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
      isEmailVerified: json['isEmailVerified'],
      token: json['token'],
      username: json['username'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
      'isEmailVerified': isEmailVerified,
      'token': token,
      'username': username,
    };
  }

  LoginResponseEntity toEntity() {
    return LoginResponseEntity(
      id: id,
      name: name,
      email: email,
      createdAt: createdAt,
      updatedAt: updatedAt,
      isEmailVerified: isEmailVerified,
      token: token,
      username: username,
    );
  }
}
