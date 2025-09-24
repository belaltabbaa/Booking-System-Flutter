// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class RegisterModel {
  final String username;
  final String email;
  final String password;
  final String passwordConfirmation;
  String? role = "user";
  RegisterModel({
    required this.username,
    required this.email,
    required this.password,
    required this.passwordConfirmation,
    this.role,
  });

  RegisterModel copyWith({
    String? username,
    String? email,
    String? password,
    String? passwordConfirmation,
    String? role = "user",
  }) {
    return RegisterModel(
      username: username ?? this.username,
      email: email ?? this.email,
      password: password ?? this.password,
      passwordConfirmation: passwordConfirmation ?? this.passwordConfirmation,
      role: role ?? this.role,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': username,
      'email': email,
      'password': password,
      'password_confirmation': passwordConfirmation,
      'role': "user",
    };
  }

  factory RegisterModel.fromMap(Map<String, dynamic> map) {
    final user = map['User'] ?? {};
    return RegisterModel(
      username: user['name'] ?? '',
      email: user['email'] ?? '',
      password: '',
      passwordConfirmation: '',
      role: user['role'] ?? 'user',
    );
  }

  String toJson() => json.encode(toMap());

  factory RegisterModel.fromJson(String source) =>
      RegisterModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'RegisterModel(username: $username, email: $email, password: $password, passwordConfirmation: $passwordConfirmation, role: $role)';
  }

  @override
  bool operator ==(covariant RegisterModel other) {
    if (identical(this, other)) return true;

    return other.username == username &&
        other.email == email &&
        other.password == password &&
        other.passwordConfirmation == passwordConfirmation &&
        other.role == role;
  }

  @override
  int get hashCode {
    return username.hashCode ^
        email.hashCode ^
        password.hashCode ^
        passwordConfirmation.hashCode ^
        role.hashCode;
  }
}
