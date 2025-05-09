import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hijri/hijri_calendar.dart';
import 'package:intl/intl.dart';
import 'package:islamy/core/utils/app_colors.dart';
import 'package:islamy/core/utils/text_styles.dart';

class DateItem extends StatelessWidget {
  MapEntry<int, DateTime> item;
  int selectedIndex;

  DateItem({super.key, required this.item, required this.selectedIndex});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Align(
        alignment: Alignment.topCenter,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
          decoration: BoxDecoration(
            color: item.key == selectedIndex ? AppColors.main_color : null,
            borderRadius: BorderRadius.circular(40.r),
            border: Border.all(color: AppColors.main_color, width: 1.r),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                getWeekdayName(item.value.weekday),
                style: TextStyles.boarding_title_style.copyWith(
                  color:
                      item.key == selectedIndex
                          ? AppColors.bg_color
                          : AppColors.main_color,
                ),
              ),
              SizedBox(height: 16.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Text(
                        item.value.day.toString(),
                        style: TextStyles.boarding_body_style.copyWith(
                          color:
                              item.key == selectedIndex
                                  ? AppColors.bg_color
                                  : AppColors.main_color,
                        ),
                      ),

                      Text(
                        DateFormat('MMMM', 'ar').format(item.value),
                        style: TextStyles.navigators_styles.copyWith(
                          color:
                              item.key == selectedIndex
                                  ? AppColors.bg_color
                                  : AppColors.main_color,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Text(
                        HijriCalendar.fromDate(item.value).hDay.toString(),
                        style: TextStyles.boarding_body_style.copyWith(
                          color:
                              item.key == selectedIndex
                                  ? AppColors.bg_color
                                  : AppColors.main_color,
                        ),
                      ),
                      Text(
                        HijriCalendar.fromDate(item.value).longMonthName,
                        style: TextStyles.boarding_body_style.copyWith(
                          color:
                              item.key == selectedIndex
                                  ? AppColors.bg_color
                                  : AppColors.main_color,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  String getWeekdayName(int weekday) {
    const names = [
      'ٱلِٱثْنَيْن',
      'ٱلثُّلَاثَاء',
      'ٱلْأَرْبِعَاء',
      'ٱلْخَمِيس',
      'ٱلْجُمُعَة',
      'ٱلسَّبْت',
      'ٱلْأَحَد',
    ];
    return names[weekday - 1];
  }
}
