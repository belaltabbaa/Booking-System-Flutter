import 'package:booking_system/features/auth/bloc/bloc/auth_bloc.dart';
import 'package:booking_system/features/auth/model/register_model.dart';
import 'package:booking_system/features/auth/service/login_service.dart';
import 'package:booking_system/features/auth/service/register_service.dart';
import 'package:booking_system/features/auth/view/login_page.dart';
import 'package:booking_system/features/auth/widget/txtfiled.dart';
import 'package:booking_system/resources/color_app.dart';
import 'package:booking_system/resources/image_app.dart';
import 'package:booking_system/resources/string_app.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  late TextEditingController name;
  late TextEditingController email;
  late TextEditingController password;
  late TextEditingController passwordConfirmation;

  @override
  void initState() {
    name = TextEditingController();
    email = TextEditingController();
    password = TextEditingController();
    passwordConfirmation = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    name.dispose();
    email.dispose();
    password.dispose();
    passwordConfirmation.dispose();
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
                  SizedBox(height: 40.h),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Center(
                        child: Column(
                          children: [
                            Container(
                              width: 140.w,
                              height: 140.h,
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
                                    controller: name,
                                    labelText: StringApp.name,
                                    hintText: 'belal',
                                  ),
                                  SizedBox(height: 20.h),
                                  TxtfiledWidget(
                                    controller: email,
                                    labelText: StringApp.emailLabel,
                                    hintText: StringApp.emailExample,
                                  ),
                                  SizedBox(height: 20.h),
                                  TxtfiledWidget(
                                    controller: password,
                                    labelText: StringApp.password,
                                    obscureText: true,
                                  ),
                                  SizedBox(height: 20.h),
                                  TxtfiledWidget(
                                    controller: passwordConfirmation,
                                    labelText: StringApp.confirmpassword,
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
                                      if (state is SuccessRegisterState) {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => LoginPage(),
                                          ),
                                        );
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
                                                    return context.read<AuthBloc>().add(
                                                      RegisterEvent(
                                                        register: RegisterModel(
                                                          username: name.text,
                                                          email: email.text,
                                                          password:
                                                              password.text,
                                                          passwordConfirmation:
                                                              passwordConfirmation
                                                                  .text,
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                  child: Text(
                                                    StringApp.signUP,
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
                                  SizedBox(height: 10.h),
                                  InkWell(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.end,
                                      children: [
                                        Text(
                                          'تسجيل الدخول',
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
                                          builder: (context) => LoginPage(),
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
