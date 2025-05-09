import 'package:carousel_slider/carousel_slider.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:islamy/core/api/api_manager.dart';
import 'package:islamy/core/utils/app_colors.dart';
import 'package:islamy/core/utils/app_lists.dart';
import 'package:islamy/core/utils/reusable_fun.dart';
import 'package:islamy/core/utils/text_styles.dart';
import 'package:islamy/data/cache_helper/cache_helper.dart';
import 'package:islamy/data/model/prayer_time_model.dart';
import 'package:islamy/view/items/prayer_time_item.dart';
import 'package:islamy/view/screens/home/tabs/time_tab/date_item.dart';

class TimeTab extends StatefulWidget {
  const TimeTab({super.key});

  @override
  State<TimeTab> createState() => TimeTabState();
}

class TimeTabState extends State<TimeTab> {
  int selectedIndex = 0;
  bool isSelected = false;
  bool isLoading = false;

  int selectedGovIndex =
  CacheHelper.getGovIndex() == null ? 0 : CacheHelper.getGovIndex()!;
  String selectedGov =
  CacheHelper.getGov() == null
      ? AppLists.egyptGovernorates[0]
      : CacheHelper.getGov()!;

  Map<String, String> timings = {};
  List<String> times = ["Fajr", "Sunrise", "Dhuhr", "Asr", "Maghrib", "Isha"];
  List<String> timesAr = [
    "الفَجْر",
    "الشُّرُوق",
    "الظُّهْر",
    "العَصْر",
    "المَغْرِب",
    "العِشَاء",
  ];

  final List<DateTime> days = List.generate(
    30,
    (i) => DateTime.now().add(Duration(days: i)),
  );

  @override
  void initState() {
    getTimes(
      CacheHelper.getGov() == null? AppLists.egyptGovernorates[0] : CacheHelper.getGov()!,
      DateFormat('dd-MM-yyyy').format(DateTime.now()).toString(),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.symmetric(horizontal: 20.r, vertical: 24.h),
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 4.h),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(40.r),
            border: Border.all(
              color: AppColors.main_color,
              width: 1.r,
            ),
          ),
          child: DropdownButton(
            items:
            AppLists.egyptGovernorates.map((item) {
              return DropdownMenuItem<String>(
                value: item,
                child: Text(
                    item,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyles.boarding_title_style
                ),
              );
            }).toList(),
            value: selectedGov,
            underline: SizedBox(),
            icon: Icon(
              Icons.location_on,
              color: AppColors.main_color,
              size: 32.r,
            ),
            onChanged: (value) {
              setState(() {
                selectedGov = value! as String;
                selectedGovIndex = AppLists.egyptGovernorates.indexWhere(
                      (item) => item == selectedGov,
                );
                CacheHelper.saveGov(selectedGov);
                CacheHelper.saveGovIndex(selectedGovIndex);

                getTimes(
                  selectedGov, // Assuming API uses lowercase city names
                  DateFormat('dd-MM-yyyy').format(DateTime.now()),
                );

              });
            },
          ),
        ),
        SizedBox(height: 12.h,),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.2,
          child: CarouselSlider(
            options: CarouselOptions(
              viewportFraction: 0.5,
              height: MediaQuery.of(context).size.height,
              enlargeCenterPage: true,
              onPageChanged: (index, reason) {
                setState(() {
                  selectedIndex = index;
                });
                setState(() async {
                  getTimes(
                    CacheHelper.getGov() == null? AppLists.egyptGovernorates[0] : CacheHelper.getGov()!,
                    DateFormat('dd-MM-yyyy').format(days[index]).toString(),
                  );
                });
              },
            ),
            items: daysList(days),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(20.r),
            child: Container(
              alignment: Alignment.center,
              padding: EdgeInsets.all(12.r),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(40.r),
                gradient: LinearGradient(
                  colors: [
                    AppColors.bg_color,
                    Color(0XFF594F3D),
                    Color(0XFFB19768),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Center(
                child:
                    timings.isEmpty || isLoading
                        ? CircularProgressIndicator(color: Colors.white)
                        : Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List.generate(
                            times.length,
                            (index) => PrayerTimeItem(
                              pray: timesAr[index],
                              time: timings[times[index]].toString(),
                            ),
                          ),
                        ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  List<Widget> daysList(List<DateTime> days) {
    final List<Widget> dayItems =
        days
            .asMap()
            .entries
            .map((item) => DateItem(item: item, selectedIndex: selectedIndex))
            .toList();

    return dayItems;
  }

  getTimes(String city, String date) async {
    if (!await ReusableFun.hasInternet()) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("No Internet connection! 🛜")));
      return;
    }
    try {
      setState(() {
        isLoading = true;
      });
      PrayerTimeModel prayerTimeModel = await ApiManager.getPrayerTimes(
        city: city,
        date: date,
      );
      timings = prayerTimeModel.data.timings.map(
        (key, value) => MapEntry(key, value.toString()),
      );
      print(timings);
      print(date);
    } catch (e) {
      if (e is DioException) {
        print('❌ Dio Error: ${e.response?.statusCode}');
        print('👉 Response data: ${e.response?.data}');
        print('🔍 Request URL: ${e.requestOptions.uri}');
      } else {
        print('⚠️ Other Error: $e');
      }
    } finally{
      setState(() {
        isLoading = false;
      });
    }
    setState(() {});
  }
}
