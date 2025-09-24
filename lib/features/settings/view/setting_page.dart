import 'package:booking_system/features/settings/bloc/bloc/setting_bloc.dart';
import 'package:booking_system/features/settings/service/setting_service.dart';
import 'package:booking_system/features/settings/view/settings_form.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SettingBloc(settingService: SettingService(dio: Dio()))..add(GetSettingEvent()),
      child: Scaffold(
        appBar: AppBar(title: const Text("لوحة التحكم"),centerTitle: true,),
        body: Builder(builder: (context) {
          return BlocBuilder<SettingBloc, SettingState>(
            builder: (context, state) {
              if (state is LoadingState) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is ErrorState) {
              return Center(child: Text("حدث خطأ: ${state.message}"));
            } else if (state is SuccessState) {
              final setting = state.settingModel;
              return SettingsForm(setting: setting);
            }
            return const SizedBox.shrink();
            },
          );
        },),
      ),
    );
  }
}