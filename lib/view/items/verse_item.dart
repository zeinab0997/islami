import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islamy/core/utils/app_colors.dart';
import 'package:islamy/core/utils/text_styles.dart';

class VerseItem extends StatelessWidget {
  String verse;
  int suraIndex;
  int verseIndex;
  int numOfVerses;
  Function? onClick;
  bool isClicked;

  VerseItem({
    super.key,
    required this.verse,
    required this.suraIndex,
    required this.verseIndex,
    required this.onClick,
    required this.isClicked,
    required this.numOfVerses
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onClick == null? null:() => onClick!(sura_index: ++suraIndex, verse_index: verseIndex, numOfVerses: numOfVerses),
      child: Container(
        width: double.infinity,
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 4.w),
        decoration: BoxDecoration(
          color: isClicked? AppColors.main_color: null,
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(
            color: isClicked ? AppColors.bg_color : AppColors.main_color,
            width: 1.r,
          ),
        ),
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: Text(
            "${verse} [${verseIndex + 1}]",
            style:
                isClicked
                    ? TextStyles.boarding_body_style.copyWith(
                      color: AppColors.bg_color,
                    )
                    : TextStyles.boarding_body_style,
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
    ;
  }
}
