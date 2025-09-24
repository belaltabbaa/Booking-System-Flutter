import 'package:booking_system/features/auth/bloc/bloc/auth_bloc.dart';
import 'package:booking_system/features/auth/model/user_model.dart';
import 'package:booking_system/features/auth/service/login_service.dart';
import 'package:booking_system/features/auth/service/register_service.dart';
import 'package:booking_system/features/auth/view/signup_page.dart';
import 'package:booking_system/features/auth/widget/txtfiled.dart';
import 'package:booking_system/features/home/view/home_page.dart';
import 'package:booking_system/features/settings/view/setting_page.dart';
import 'package:booking_system/resources/color_app.dart';
import 'package:booking_system/resources/image_app.dart';
import 'package:booking_system/resources/string_app.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late TextEditingController email;
  late TextEditingController password;

  @override
  void initState() {
    email = TextEditingController();
    password = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
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
            return SafeArea(
              child: Column(
                children: [
                  SizedBox(height: 60.h),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Center(
                        child: Column(
                          children: [
                            Container(
                              width: 180.w,
                              height: 180.h,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: ColorApp.greenDarker,
                                border: Border.all(
                                  color: ColorApp.yellowText,
                                  width: 4.w,
                                ),
                              ),
                              child: Padding(
                                padding: EdgeInsets.all(4.w),
                                child: ClipOval(
                                  child: Image.asset(
                                    ImageApp.logo,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 15.h),
                            Text(
                              StringApp.login,
                              style: TextStyle(
                                fontSize: 20.sp,
                                color: ColorApp.yellowLight,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 40.h),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20.h),
                              child: Column(
                                children: [
                                  TxtfiledWidget(
                                    controller: email,
                                    labelText: StringApp.emailLabel,
                                    hintText: StringApp.emailExample,
                                  ),
                                  SizedBox(height: 30.h),
                                  TxtfiledWidget(
                                    controller: password,
                                    labelText: StringApp.password,
                                    obscureText: true,
                                  ),
                                  SizedBox(height: 15.h),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Checkbox(
                                        value: false,
                                        onChanged: (val) {},
                                      ),
                                      Text(
                                        StringApp.remeberMe,
                                        style: TextStyle(
                                          color: ColorApp.yellowLight,
                                          fontSize: 15.sp,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 30.h),
                                  BlocConsumer<AuthBloc, AuthState>(
                                    listener: (context, state) {
                                      if (state is SuccessLoginState) {
                                        if (state.user.role!.toLowerCase() ==
                                            "admin") {
                                          Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                              builder:
                                                  (_) => const SettingPage(),
                                            ),
                                          );
                                        } else {
                                          Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                              builder: (_) => const HomePage(),
                                            ),
                                          );
                                        }
                                      }
                                      if (state is ErrorState) {
                                        ScaffoldMessenger.of(
                                          context,
                                        ).showSnackBar(
                                          SnackBar(
                                            content: Text("Failed"),
                                            backgroundColor: Colors.red,
                                          ),
                                        );
                                      }
                                    },
                                    builder: (context, state) {
                                      return SizedBox(
                                        width: double.infinity,
                                        height: 50.h,
                                        child:
                                            state is LoadingState
                                                ? Center(
                                                  child:
                                                      CircularProgressIndicator(),
                                                )
                                                : ElevatedButton(
                                                  style: ElevatedButton.styleFrom(
                                                    backgroundColor:
                                                        ColorApp.yellowLight,
                                                    shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                            8,
                                                          ),
                                                    ),
                                                  ),
                                                  onPressed: () {
                                                    return context
                                                        .read<AuthBloc>()
                                                        .add(
                                                          LoginEvent(
                                                            user: UserModel(
                                                              email: email.text,
                                                              password:
                                                                  password.text,
                                                            ),
                                                          ),
                                                        );
                                                  },
                                                  child: Text(
                                                    StringApp.login2,
                                                    style: TextStyle(
                                                      color:
                                                          ColorApp
                                                              .greenInputText,
                                                      fontSize: 20.sp,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                ),
                                      );
                                    },
                                  ),
                                  SizedBox(height: 10.h,),
                                  InkWell(
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Text(
                                          'إنشاء حساب',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: ColorApp.yellowText,
                                          ),
                                        ),
                                      ],
                                    ),
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => SignupPage(),
                                        ),
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Text(
                      StringApp.bottomText,
                      style: TextStyle(
                        color: ColorApp.yellowText,
                        fontSize: 14.sp,
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
