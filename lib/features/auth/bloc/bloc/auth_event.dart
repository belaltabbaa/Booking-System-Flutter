part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {}

class LoginEvent extends AuthEvent {
  final UserModel user;

  LoginEvent({required this.user});
}

class RegisterEvent extends AuthEvent {
  final RegisterModel register;

  RegisterEvent({required this.register});
}
