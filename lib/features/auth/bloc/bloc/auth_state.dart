part of 'auth_bloc.dart';

@immutable
sealed class AuthState {}

final class AuthInitial extends AuthState {}

class SuccessRegisterState extends AuthState {}

class ErrorState extends AuthState {}

class LoadingState extends AuthState {}

class SuccessLoginState extends AuthState {
  final UserModel user;
  SuccessLoginState({required this.user});
}

class AuthAuthenticated extends AuthState {
  final UserModel user;
  AuthAuthenticated(this.user);

}