import 'package:booking_system/config/constant.dart';
import 'package:booking_system/config/service_locator.dart';
import 'package:booking_system/features/auth/model/user_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginService {
  Dio dio;
  final String baseUrl = dotenv.env['BASE_URL']!;
  late Response response;

  LoginService({required this.dio});

  String get baseUrlLogin => '$baseUrl/login';

  Future<UserModel> login(UserModel user) async {
    try {
      response = await dio.post(baseUrlLogin, data: user.toMap());
      sl.get<SharedPreferences>().setString(tOKEN, response.data['token']);
      return UserModel.fromMap(response.data['user']);
    } catch (e) {
      // print(e);
      rethrow;
    }
  }
}
