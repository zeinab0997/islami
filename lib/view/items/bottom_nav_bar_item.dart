import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islamy/core/utils/app_colors.dart';

class BottomNavBarItem extends StatelessWidget {
  int index, currentIndex;
  String iconName;
  BottomNavBarItem({super.key, required this.index, required this.currentIndex, required this.iconName});

  @override
  Widget build(BuildContext context) {
    return currentIndex == index? Container(
      padding: EdgeInsets.symmetric(vertical: 6.h, horizontal: 20.w),
      decoration: BoxDecoration(
        color: AppColors.bg_color.withValues(alpha: 0.60),
        borderRadius: BorderRadius.circular(64.r),
      ),
      child: ImageIcon(AssetImage("assets/icons/$iconName.png")),
    ): ImageIcon(AssetImage("assets/icons/$iconName.png"));
  }
}
