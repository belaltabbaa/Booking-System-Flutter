import 'package:booking_system/config/constant.dart';
import 'package:booking_system/config/exeptions_service.dart';
import 'package:booking_system/config/service_locator.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HeaderConfig {
  static Options getHeader({bool useToken = true}) {
    if (sl.get<SharedPreferences>().getString(tOKEN) == null) {
      throw NoTokenFound();
    } else if (useToken) {
      return Options(
        headers: {
          'Content-Type': 'application/json',
          'Authorization':
              'Bearer ${sl.get<SharedPreferences>().getString(tOKEN)}',
        },
      );
    } else {
      return Options(headers: {'Content-Type': 'application/json'});
    }
  }
}
