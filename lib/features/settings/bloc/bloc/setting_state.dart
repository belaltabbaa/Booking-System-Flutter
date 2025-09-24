part of 'setting_bloc.dart';

@immutable
sealed class SettingState {}

final class SettingInitial extends SettingState {}

final class LoadingState extends SettingState {}

final class ErrorState extends SettingState {
  final String message;

  ErrorState({required this.message});
}

final class SuccessState extends SettingState {
  final SettingModel settingModel;
  SuccessState(this.settingModel);
}