import 'package:flutter/material.dart';

class Done extends StatelessWidget {
  final String message;
  final int? userRemaining;
  final int? systemRemaining;
  final bool success;

  const Done({
    super.key,
    required this.message,
    this.userRemaining,
    this.systemRemaining,
    required this.success,
  });

  @override
  Widget build(BuildContext context) {
    final bool isSuccess = message.contains("تم");

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("حالة الطلب",style: TextStyle(fontWeight: FontWeight.bold),),
        backgroundColor: isSuccess ? Colors.green : Colors.red,
      ),
      body: Center(
        child: Card(
          elevation: 4,
          margin: const EdgeInsets.all(16),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  isSuccess ? Icons.check_circle : Icons.cancel,
                  color: isSuccess ? Colors.green : Colors.red,
                  size: 80,
                ),
                const SizedBox(height: 16),

                Text(
                  message,
                  style: TextStyle(
                    fontSize: 18,
                    color: isSuccess ? Colors.green : Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),

                if (userRemaining != null)
                  Text("أدوارك المتبقية: $userRemaining"),
                if (systemRemaining != 0)
                  Text("الأدوار المتبقية بالنظام: $systemRemaining"),

                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: isSuccess ? Colors.green : Colors.red,
                  ),
                  child: const Text("رجوع"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
