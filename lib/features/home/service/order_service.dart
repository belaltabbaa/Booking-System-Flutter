import 'package:booking_system/config/header_config.dart';
import 'package:booking_system/features/home/model/order_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class OrderService {
  Dio dio;
  Response? response;
  final String baseUrl = dotenv.env['BASE_URL']!;

  OrderService({required this.dio});

  String get baseUrlcreateorder => '$baseUrl/booking/create';

  Future<Map<String, dynamic>> registerOrder(OrderModel order) async {
    try {
      final response = await dio.post(
        baseUrlcreateorder,
        data: order.toMap(),
        options: HeaderConfig.getHeader(),
      );
      return {
        'success': response.data['success'] ?? false,
        'message': (response.data['message'] ?? '').toString(),
        'userRemaining': response.data['user_remaining'] ?? 0,
        'systemRemaining': response.data['system_remaining'] ?? 0,
      };
    } on DioException catch (e) {
      return {
        'success': false,
        'message': (e.response?.data['message'] ?? e.message).toString(),
        'userRemaining': 0,
        'systemRemaining': 0,
      };
    }
  }
}
