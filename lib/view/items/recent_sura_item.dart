import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islamy/core/utils/app_colors.dart';
import 'package:islamy/core/utils/app_images.dart';
import 'package:islamy/core/utils/app_strings.dart';
import 'package:islamy/core/utils/text_styles.dart';
import 'package:islamy/data/model/sura_model.dart';

class RecentSuraItem extends StatelessWidget {
  SuraModel suraModel;
  RecentSuraItem({super.key, required this.suraModel});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150.h,
      padding: EdgeInsets.all(8.r),
      decoration: BoxDecoration(
        color: AppColors.main_color,
        borderRadius: BorderRadius.circular(20.r)
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [

          Padding(
            padding: EdgeInsets.all(8.r),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(suraModel.nameEng, style: TextStyles.boarding_title_style.copyWith(color: AppColors.bg_color),),
                Text(suraModel.nameAr, style: TextStyles.boarding_title_style.copyWith(color: AppColors.bg_color),),
                Text("${suraModel.numOfVerses} ${AppStrings.verses}", style: TextStyles.verses_num_style.copyWith(color: AppColors.bg_color),),
              ],
            ),
          ),
          Image.asset(AppImages.sura_item,),
        ],
      ),
    );
  }
}
