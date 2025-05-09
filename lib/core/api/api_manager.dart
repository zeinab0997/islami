import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:islamy/data/model/azkar_model.dart';
import 'package:islamy/data/model/prayer_time_model.dart';
import 'package:islamy/data/model/zekr_model.dart';

class ApiManager{

  static final Dio dio = Dio();

  static Future<AzkarModel> getZekrList({required String zekrNum}) async {
    final response = await await dio.get('https://www.hisnmuslim.com/api/ar/$zekrNum.json');
    final data = response.data;

    final String zekrTitle = data.keys.first;
    final List<dynamic> zekrListJson = data[zekrTitle];

    List<ZekrModel> zekrList = zekrListJson.map((json) => ZekrModel.fromJson(json)).toList();

    return AzkarModel(title: zekrTitle, zekrList: zekrList);
  }

  static Future<PrayerTimeModel> getPrayerTimes({required String city, required String date}) async {
    final response = await await dio.get("https://api.aladhan.com/v1/timingsByCity/$date?city=$city&country=egypt&method=8");
    final data = response.data;

    PrayerTimeModel prayerTimeModel = PrayerTimeModel.fromJson(data);

    return prayerTimeModel;
  }

}