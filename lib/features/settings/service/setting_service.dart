// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:booking_system/config/header_config.dart';
import 'package:booking_system/features/settings/model/setting_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class SettingService {
  Dio dio;
  Response? response;

  SettingService({required this.dio});

  final String baseUrl = dotenv.env['BASE_URL']!;

  String get baseUrlGetSettings => '$baseUrl/get/setting';

  String get baseUrlUpdateSettings => '$baseUrl/update/setting/5';

  Future<SettingModel> getSetting() async {
    try {
      response = await dio.get(baseUrlGetSettings,options: HeaderConfig.getHeader());
      return SettingModel.fromMap(response!.data['data']);
    } catch (e) {
      // print(e);
      rethrow;
    }
  }

  Future<SettingModel> updateSetting(SettingModel setting) async {
    try {
      response = await dio.put(baseUrlUpdateSettings, data: setting.toMap(),options: HeaderConfig.getHeader());
      return SettingModel.fromMap(response!.data['data']);
    } catch (e) {
      // print(e);
      rethrow;
    }
  }
}
