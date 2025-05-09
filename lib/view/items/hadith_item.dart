import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islamy/core/utils/app_colors.dart';
import 'package:islamy/core/utils/app_images.dart';
import 'package:islamy/core/utils/text_styles.dart';
import 'package:islamy/data/model/hadith_model.dart';

class HadithItem extends StatelessWidget {
  MapEntry<int, HadithModel> hadithItem;
  HadithItem({super.key, required this.hadithItem});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
          color: AppColors.main_color,
          borderRadius: BorderRadius.circular(18.r),
          image: DecorationImage(image: AssetImage(AppImages.hadith_item_bg,),)
      ),
      child: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: EdgeInsets.only(top: 12.w, left:  12.w, right:  12.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Image.asset(AppImages.sura_details_tl_dec, color: AppColors.bg_color,),
                    Image.asset(AppImages.sura_details_tr_dec, color: AppColors.bg_color),
                  ],
                ),
              ),
              Image.asset(AppImages.hadith_bottom_dec, width: double.infinity, fit: BoxFit.fill,),
            ],
          ),
          Container(
            alignment: Alignment.center,
            padding: EdgeInsets.only(top: 48.h, left: 16.w, right: 16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  hadithItem.value.title,
                  style: TextStyles.boarding_body_style.copyWith(
                    color: AppColors.bg_color,
                  ),
                ),
                Expanded(
                  child: ListView(
                    physics: NeverScrollableScrollPhysics(),
                    children: [
                      for(String line in hadithItem.value.content)
                        Text(
                          line,
                          style: TextStyles.navigators_styles.copyWith(
                            color: AppColors.bg_color,
                          ),
                          textAlign: TextAlign.center,
                        ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
