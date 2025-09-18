import 'package:booking_system/resources/color_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class InputBox extends StatelessWidget {
  final String title;
  final String hint;
  final int? maxLines;
  final TextEditingController controller;
  final String? Function(String?)? validator; // دالة الفاليديشن
  final TextInputType keyboardType;

  const InputBox({
    super.key,
    required this.controller,
    required this.title,
    required this.hint,
    this.maxLines,
    this.validator,
    this.keyboardType = TextInputType.text,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: ColorApp.yellowBorder,
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
          SizedBox(height: 8.h),
          TextFormField(
            controller: controller,
            maxLines: maxLines ?? 1,
            keyboardType: keyboardType,
            validator: validator, // هنا يتم استخدام الفاليديشن
            decoration: InputDecoration(
              hintText: hint,
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(6.r),
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
