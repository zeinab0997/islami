import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islamy/core/utils/app_colors.dart';
import 'package:islamy/core/utils/app_images.dart';
import 'package:islamy/core/utils/app_strings.dart';
import 'package:islamy/core/utils/text_styles.dart';
import 'package:islamy/data/model/hadith_model.dart';
import 'package:islamy/data/model/sura_model.dart';

class HadithDetailsScreen extends StatefulWidget {
  static const String routeName = "HADITH_DETAILS_SCREEN";

  const HadithDetailsScreen({super.key});

  @override
  State<HadithDetailsScreen> createState() => _HadithDetailsScreenState();
}

class _HadithDetailsScreenState extends State<HadithDetailsScreen> {

  @override
  Widget build(BuildContext context) {
    var hadithModel = ModalRoute.of(context)?.settings.arguments as MapEntry<int, HadithModel>;
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.bg_color,
        appBar: AppBar(
          backgroundColor: AppColors.bg_color,
          centerTitle: true,
          title: Text("${AppStrings.hadith_tab_label} ${hadithModel.key+1}", style: TextStyles.boarding_body_style),
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back, color: AppColors.main_color, size: 24.r),
          ),
        ),
        body: Stack(
          alignment: Alignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 18.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Image.asset(AppImages.sura_details_tl_dec),
                      Image.asset(AppImages.sura_details_tr_dec),
                    ],
                  ),
                ),
                Image.asset(AppImages.sura_details_bottom_dec),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(top: 18.h, left: 18.w, right: 18.w),
              child: Column(
                children: [
                  Text(hadithModel.value.title, style: TextStyles.boarding_title_style),
                  SizedBox(height: 56.h),
                  Expanded(
                    child: ListView(
                      children: [
                        for(String line in hadithModel.value.content)
                          Text(
                            line,
                            style: TextStyles.navigators_styles.copyWith(
                              color: AppColors.main_color,
                            ),
                            textAlign: TextAlign.center,
                          ),
                      ],
                    ),
                  ),
                ],
              )
            ),
          ],
        ),
      ),
    );
  }
}
