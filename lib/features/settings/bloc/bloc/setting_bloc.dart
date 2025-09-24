// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import 'package:booking_system/features/settings/model/setting_model.dart';
import 'package:booking_system/features/settings/service/setting_service.dart';

part 'setting_event.dart';
part 'setting_state.dart';

class SettingBloc extends Bloc<SettingEvent, SettingState> {
  SettingService settingService;
  SettingBloc({required this.settingService}) : super(SettingInitial()) {
    on<GetSettingEvent>((event, emit) async {
      emit(LoadingState());
      try {
        SettingModel result = await settingService.getSetting();
        emit(SuccessState(result));
      } catch (e) {
        emit(ErrorState(message: e.toString()));
      }
    });
    on<UpdateSettingEvent>((event, emit) async {
      emit(LoadingState());
      try {
        SettingModel result = await settingService.updateSetting(event.setting);
        emit(SuccessState(result));
      } catch (e) {
        emit(ErrorState(message: e.toString()));
      }
    });
  }
}
