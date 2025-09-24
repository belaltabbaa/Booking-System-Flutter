// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

class SettingModel {
  final bool isBookingOpen;
  final String startTime;
  final String endTime;
  final List<String> allowedDays;
  final int totalOrdersPerDay;
  SettingModel({
    required this.isBookingOpen,
    required this.startTime,
    required this.endTime,
    required this.allowedDays,
    required this.totalOrdersPerDay,
  });

  SettingModel copyWith({
    bool? isBookingOpen,
    String? startTime,
    String? endTime,
    List<String>? allowedDays,
    int? totalOrdersPerDay,
  }) {
    return SettingModel(
      isBookingOpen: isBookingOpen ?? this.isBookingOpen,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      allowedDays: allowedDays ?? this.allowedDays,
      totalOrdersPerDay: totalOrdersPerDay ?? this.totalOrdersPerDay,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'is_booking_open': isBookingOpen,
      'start_time': startTime,
      'end_time': endTime,
      'allowed_days': allowedDays,
      'total_orders_per_day': totalOrdersPerDay,
    };
  }

  factory SettingModel.fromMap(Map<String, dynamic> map) {
    return SettingModel(
      isBookingOpen: map['is_booking_open'] as bool,
      startTime: map['start_time'] as String,
      endTime: map['end_time'] as String,
      allowedDays:
          map['allowed_days'] != null
              ? List.generate(
                (map['allowed_days'] as List).length,
                (index) => (map['allowed_days'] as List)[index].toString(),
              )
              : [],
      totalOrdersPerDay: map['total_orders_per_day'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory SettingModel.fromJson(String source) =>
      SettingModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'SettingModel(isBookingOpen: $isBookingOpen, startTime: $startTime, endTime: $endTime, allowedDays: $allowedDays, totalOrdersPerDay: $totalOrdersPerDay)';
  }

  @override
  bool operator ==(covariant SettingModel other) {
    if (identical(this, other)) return true;

    return other.isBookingOpen == isBookingOpen &&
        other.startTime == startTime &&
        other.endTime == endTime &&
        listEquals(other.allowedDays, allowedDays) &&
        other.totalOrdersPerDay == totalOrdersPerDay;
  }

  @override
  int get hashCode {
    return isBookingOpen.hashCode ^
        startTime.hashCode ^
        endTime.hashCode ^
        allowedDays.hashCode ^
        totalOrdersPerDay.hashCode;
  }
}
