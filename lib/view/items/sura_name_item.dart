import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islamy/core/utils/app_images.dart';
import 'package:islamy/core/utils/app_strings.dart';
import 'package:islamy/core/utils/text_styles.dart';
import 'package:islamy/data/model/sura_model.dart';

class SuraNameItem extends StatelessWidget {
  SuraModel suraModel;
  SuraNameItem({super.key, required this.suraModel,});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            Image.asset(AppImages.sura_num, width: 52.w, height: 52.h,),
            Text("${suraModel.index + 1}", style: TextStyles.navigators_styles.copyWith(color: Colors.white),),
          ],
        ),
        SizedBox(width: 24.w,),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(suraModel.nameEng, style: TextStyles.boarding_body_style.copyWith(color: Colors.white),),
            Text("${suraModel.numOfVerses} ${AppStrings.verses}", style: TextStyles.verses_num_style,),
          ],
        ),
        Spacer(),
        Text(suraModel.nameAr, style: TextStyles.boarding_body_style.copyWith(color: Colors.white),),
      ],
    );
  }
}
