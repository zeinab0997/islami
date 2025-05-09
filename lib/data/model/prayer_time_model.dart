import 'date_model.dart';
import 'meta_model.dart';

class PrayerTimeModel {
  final int code;
  final String status;
  final PrayerData data;

  PrayerTimeModel({required this.code, required this.status, required this.data});

  factory PrayerTimeModel.fromJson(Map<String, dynamic> json) {
    return PrayerTimeModel(
      code: json['code'],
      status: json['status'],
      data: PrayerData.fromJson(json['data']),
    );
  }
}

class PrayerData {
  final Map<String, String> timings;
  final DateInfo date;
  final Meta meta;

  PrayerData({required this.timings, required this.date, required this.meta});

  factory PrayerData.fromJson(Map<String, dynamic> json) {
    return PrayerData(
      timings: Map<String, String>.from(json['timings']),
      date: DateInfo.fromJson(json['date']),
      meta: Meta.fromJson(json['meta']),
    );
  }
}
