import 'package:booking_system/features/settings/bloc/bloc/setting_bloc.dart';
import 'package:booking_system/features/settings/model/setting_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SettingsForm extends StatefulWidget {
  final SettingModel setting;
  const SettingsForm({required this.setting, super.key});

  @override
  State<SettingsForm> createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {
  late bool isBookingOpen;
  late TextEditingController startController;
  late TextEditingController endController;
  late TextEditingController totalOrdersController;
  late List<String> allowedDays;

  @override
  void initState() {
    super.initState();
    isBookingOpen = widget.setting.isBookingOpen;
    startController = TextEditingController(text: widget.setting.startTime);
    endController = TextEditingController(text: widget.setting.endTime);
    totalOrdersController =
        TextEditingController(text: widget.setting.totalOrdersPerDay.toString());
    allowedDays = List.from(widget.setting.allowedDays);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.all(16.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SwitchListTile(
                        title: Text("فتح الحجوزات:", style: TextStyle(fontSize: 16.sp)),
                        value: isBookingOpen,
                        onChanged: (val) => setState(() => isBookingOpen = val),
                      ),
                      SizedBox(height: 12.h),
                      TextField(
                        controller: startController,
                        decoration: const InputDecoration(
                          labelText: "وقت البداية (HH:MM:SS)",
                          border: OutlineInputBorder(),
                        ),
                      ),
                      SizedBox(height: 12.h),
                      TextField(
                        controller: endController,
                        decoration: const InputDecoration(
                          labelText: "وقت النهاية (HH:MM:SS)",
                          border: OutlineInputBorder(),
                        ),
                      ),
                      SizedBox(height: 12.h),
                      TextField(
                        controller: totalOrdersController,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          labelText: "عدد الحجوزات اليومي",
                          border: OutlineInputBorder(),
                        ),
                      ),
                      SizedBox(height: 20.h),
                      Text("الأيام المسموح بها:", style: TextStyle(fontSize: 15.sp)),
                      SizedBox(height: 8.h),
                      Wrap(
                        spacing: 8.w,
                        runSpacing: 8.h,
                        children: [
                          for (var day in [
                            "Sunday",
                            "Monday",
                            "Tuesday",
                            "Wednesday",
                            "Thursday",
                            "Friday",
                            "Saturday",
                          ])
                            FilterChip(
                              label: Text(day),
                              selected: allowedDays.contains(day),
                              onSelected: (selected) {
                                setState(() {
                                  if (selected) {
                                    allowedDays.add(day);
                                  } else {
                                    allowedDays.remove(day);
                                  }
                                });
                              },
                            ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(16.w, 8.h, 16.w, 24.h),
                child: Column(
                  children: [
                    Text(
                      "💡 ملاحظة: تأكد من إدخال الأوقات بصيغة HH:MM:SS",
                      style: TextStyle(fontSize: 13.sp, color: Colors.grey[600]),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 12.h),
                    SizedBox(
                      width: double.infinity,
                      height: 50.h,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                        ),
                        onPressed: () {
                          final updated = widget.setting.copyWith(
                            isBookingOpen: isBookingOpen,
                            startTime: startController.text,
                            endTime: endController.text,
                            totalOrdersPerDay:
                                int.tryParse(totalOrdersController.text) ??
                                    widget.setting.totalOrdersPerDay,
                            allowedDays: allowedDays,
                          );
                          context
                              .read<SettingBloc>()
                              .add(UpdateSettingEvent(setting: updated));
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: const Text("نجاح"),
                                content: const Text("تم حفظ التعديلات بنجاح"),
                                actions: [
                                  TextButton(
                                    onPressed: () => Navigator.pop(context),
                                    child: const Text("حسناً"),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                        child: Text("حفظ التعديلات", style: TextStyle(fontSize: 16.sp)),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
