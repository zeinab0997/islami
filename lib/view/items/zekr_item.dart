import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islamy/core/utils/app_colors.dart';
import 'package:islamy/core/utils/text_styles.dart';
import 'package:islamy/data/model/azkar_model.dart';

class ZekrItem extends StatelessWidget {
  AzkarModel azkarItem;
  int index;
  Function onClick;

  ZekrItem({super.key, required this.azkarItem, required this.index, required this.onClick});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onClick(index),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 20.w),
        margin: EdgeInsets.only(bottom: 12.h),
        width: double.infinity,
        height: 160.h,
        decoration: BoxDecoration(
          color: AppColors.main_color,
          borderRadius: BorderRadius.circular(20.r),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    azkarItem.title,
                    style: TextStyles.boarding_title_style.copyWith(
                      color: AppColors.bg_color,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Directionality(
                    textDirection: TextDirection.rtl,
                    child: Text(
                      "${azkarItem.zekrList.length} أذكار",
                      style: TextStyles.boarding_body_style.copyWith(
                        color: AppColors.bg_color,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width: 12.w,),
            Image.asset(
              "assets/images/zekr${index + 1}.png",
              width: 80.w,
              height: 80.h,
            ),
          ],
        ),
      ),
    );
    ;
  }
}
