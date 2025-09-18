import 'package:booking_system/features/auth/model/register_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class RegisterService {
  Dio dio;
  late Response response;
  final String baseUrl = dotenv.env['BASE_URL']!;

  RegisterService({required this.dio});

  String get baseUrlregister => '$baseUrl/register';

  Future<bool> register(RegisterModel register) async {
    try {
      response = await dio.post(baseUrlregister,data: register.toMap());
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }
}
