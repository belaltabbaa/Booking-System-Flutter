part of 'home_bloc.dart';

@immutable
sealed class HomeState {}

final class HomeInitial extends HomeState {}

class SuccessRegisterorder extends HomeState {
  final bool success;
  final String message;
  final int userRemaining;
  final int systemRemaining;

  SuccessRegisterorder({
    required this.success,
    required this.message,
    required this.userRemaining,
    required this.systemRemaining,
  });
}

class ErrorState extends HomeState {
  final String message;

  ErrorState({required this.message});
}

class LoadingState extends HomeState {}
