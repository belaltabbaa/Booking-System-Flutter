part of 'setting_bloc.dart';

@immutable
sealed class SettingEvent {}

final class GetSettingEvent extends SettingEvent {}

final class UpdateSettingEvent extends SettingEvent {
  final SettingModel setting;
  UpdateSettingEvent({required this.setting});
}