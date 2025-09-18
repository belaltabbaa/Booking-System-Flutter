// home_page.dart
import 'package:booking_system/features/home/bloc/bloc/home_bloc.dart';
import 'package:booking_system/features/home/model/order_model.dart';
import 'package:booking_system/features/home/service/order_service.dart';
import 'package:booking_system/features/home/view/done.dart';
import 'package:booking_system/features/home/widget/input_box.dart';
import 'package:booking_system/resources/color_app.dart';
import 'package:booking_system/resources/image_app.dart';
import 'package:booking_system/resources/string_app.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late TextEditingController sellerName;
  late TextEditingController buyerName;
  late TextEditingController plateNumber;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    sellerName = TextEditingController();
    buyerName = TextEditingController();
    plateNumber = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    sellerName.dispose();
    buyerName.dispose();
    plateNumber.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeBloc(orderService: OrderService(dio: Dio())),
      child: Form(
        key: _formKey,
        child: Scaffold(
          backgroundColor: ColorApp.greenDark,
          body: Builder(
            builder: (context) {
              return SafeArea(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: Directionality(
                      textDirection: TextDirection.rtl,
                      child: Column(
                        children: [
                          SizedBox(height: 40.h),
                          Container(
                            width: 75.w,
                            height: 75.h,
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
                          SizedBox(height: 10.h),
                          Text(
                            StringApp.transform,
                            style: TextStyle(
                              fontSize: 20.sp,
                              color: ColorApp.yellowLight,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 30.h),
                          InputBox(
                            controller: sellerName,
                            title: StringApp.moshtary,
                            hint: StringApp.layazeed,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'الرجاء إدخال الاسم';
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 20.h),
                          InputBox(
                            controller: buyerName,
                            title: StringApp.baaee,
                            hint: StringApp.layazeed,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'الرجاء إدخال الاسم';
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 20.h),
                          InputBox(
                            controller: plateNumber,
                            title: StringApp.lawha,
                            hint: StringApp.tawel,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'الرجاء إدخال رقم اللوحة';
                              }
                              if (value.length < 5) {
                                return 'رقم اللوحة قصير جداً';
                              }

                              if (value.length > 10) {
                                return 'رقم اللوحة طويل جداً';
                              }

                              final regex = RegExp(r'^[A-Za-z0-9]+$');
                              if (!regex.hasMatch(value)) {
                                return 'رقم اللوحة يجب أن يحتوي حروف وأرقام فقط';
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 50.h),
                          BlocConsumer<HomeBloc, HomeState>(
                            listener: (context, state) {
                              if (state is SuccessRegisterorder) {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder:
                                        (context) => Done(
                                          message: state.message,
                                          userRemaining: state.userRemaining,
                                          systemRemaining:
                                              state.systemRemaining,
                                          success: state.success,
                                        ),
                                  ),
                                );
                              }
                              if (state is ErrorState) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text('Failed'),
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
                                          child: CircularProgressIndicator(),
                                        )
                                        : ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor:
                                                ColorApp.yellowLight,
                                            padding: const EdgeInsets.symmetric(
                                              vertical: 16,
                                            ),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                            ),
                                          ),
                                          onPressed: () {
                                            if (_formKey.currentState!
                                                .validate()) {
                                              return context
                                                  .read<HomeBloc>()
                                                  .add(
                                                    RegisterOrderEvent(
                                                      OrderModel(
                                                        sellerName:
                                                            sellerName.text,
                                                        buyerName:
                                                            buyerName.text,
                                                        plateNumber:
                                                            plateNumber.text,
                                                      ),
                                                    ),
                                                  );
                                            }
                                          },
                                          child: Text(
                                            StringApp.registerorder,
                                            style: TextStyle(
                                              fontSize: 18.sp,
                                              color: ColorApp.greenInputText,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                              );
                            },
                          ),
                          SizedBox(height: 65.h),
                          Text(
                            StringApp.hokok,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: ColorApp.yellowText,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
