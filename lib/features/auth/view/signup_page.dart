import 'package:booking_system/features/auth/bloc/bloc/auth_bloc.dart';
import 'package:booking_system/features/auth/service/login_service.dart';
import 'package:booking_system/features/auth/service/register_service.dart';
import 'package:booking_system/resources/color_app.dart';
import 'package:booking_system/resources/image_app.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  late TextEditingController name;
  late TextEditingController email;
  late TextEditingController password;

  @override
  void initState() {
    name = TextEditingController();
    email = TextEditingController();
    password = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    name.dispose();
    email.dispose();
    password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:
          (context) => AuthBloc(
            loginService: LoginService(dio: Dio()),
            registerService: RegisterService(dio: Dio()),
          ),
      child: Scaffold(
        backgroundColor: ColorApp.greenDark,
        body: Builder(
          builder: (context) {
            return SafeArea(child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(ImageApp.logo)
                ],
              ),
            ));
          },
        ),
      ),
    );
  }
}
