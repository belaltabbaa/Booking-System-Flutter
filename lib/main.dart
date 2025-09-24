import 'package:booking_system/config/observer.dart';
import 'package:booking_system/config/service_locator.dart';
import 'package:booking_system/features/auth/view/signup_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() async {
  await dotenv.load(fileName: ".env");
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  await setup();
  runApp(
    ScreenUtilInit(
      designSize: Size(375, 812), 
      minTextAdapt: true,
      builder: (context, child) => MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: SignupPage());
  }
}

