import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islamy/core/utils/app_colors.dart';
import 'package:islamy/core/utils/reusable_fun.dart';
import 'package:islamy/core/utils/text_styles.dart';
import 'package:islamy/data/model/zekr_model.dart';

class ZekrDetailsItem extends StatelessWidget {
  ZekrModel zekr;
  Function onClick;
  int index;
  bool isSelected;
  bool isPlaying;
  bool isLoading;

  ZekrDetailsItem({
    super.key,
    required this.zekr,
    required this.onClick,
    required this.index,
    required this.isSelected,
    required this.isPlaying,
    required this.isLoading
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.r),
      margin: EdgeInsets.only(bottom: 12.h),
      decoration: BoxDecoration(
        color: isSelected ? AppColors.main_color : null,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: AppColors.main_color, width: 1.r),
      ),
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Column(
          children: [
            Text(
              zekr.arTxt,
              style:
                  isSelected
                      ? TextStyles.boarding_body_style.copyWith(
                        color: AppColors.bg_color,
                      )
                      : TextStyles.boarding_body_style,
              textAlign: TextAlign.justify,
            ),
            SizedBox(height: 12.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  "عدد التكرار : ${zekr.rebeate}",
                  style:
                      isSelected
                          ? TextStyles.navigators_styles.copyWith(
                            color: AppColors.bg_color,
                          )
                          : TextStyles.navigators_styles,
                ),
                IconButton(
                  onPressed: () async{
                    if (!await ReusableFun.hasInternet()) {
                    ScaffoldMessenger.of(
                    context,
                    ).showSnackBar(SnackBar(content: Text("No Internet connection! 🛜")));
                    return;
                    }
                    onClick(zekr.audioUrl, index);},
                  icon: isLoading? CircularProgressIndicator(color: Colors.white,):Icon(
                    (isSelected && isPlaying)
                        ? Icons.pause
                        : Icons.play_arrow_rounded,
                    color:
                        isSelected ? AppColors.bg_color : AppColors.main_color,
                    size: 32.r,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
