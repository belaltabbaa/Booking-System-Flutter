// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class UserModel {
  final String email;
  final String password;
  final String? role;
  UserModel({
    required this.email,
    required this.password,
    this.role,
  });

  UserModel copyWith({
    String? email,
    String? password,
    String? role,
  }) {
    return UserModel(
      email: email ?? this.email,
      password: password ?? this.password,
      role: role ?? this.role,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'email': email,
      'password': password,
      'role': role,
    };
  }

 factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      email: map['email'] != null ? map['email'].toString() : '',
      password: map['password'] != null ? map['password'].toString() : '',
      role: map['role']?.toString(),
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) => UserModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'UserModel(email: $email, password: $password, role: $role)';

  @override
  bool operator ==(covariant UserModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.email == email &&
      other.password == password &&
      other.role == role;
  }

  @override
  int get hashCode => email.hashCode ^ password.hashCode ^ role.hashCode;
}
