import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islamy/core/utils/app_colors.dart';
import 'package:islamy/core/utils/app_strings.dart';
import 'package:islamy/view/items/bottom_nav_bar_item.dart';

class BottomNavBar extends StatefulWidget {
  Function onChange;
  BottomNavBar({super.key, required this.onChange});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {

  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      selectedItemColor: Colors.white,
      iconSize: 32.r,
      unselectedItemColor: AppColors.bg_color,
      backgroundColor: AppColors.main_color,
      type: BottomNavigationBarType.fixed,
      showUnselectedLabels: false,
      onTap: (index) {
        setState(() {
          currentIndex = index;
        });
        widget.onChange(currentIndex);
      },
      items: [
        BottomNavigationBarItem(
          label: currentIndex == 0 ? AppStrings.quran_tab_label : "",
          icon: BottomNavBarItem(
            index: 0,
            currentIndex: currentIndex,
            iconName: "ic_quran",
          ),
        ),
        BottomNavigationBarItem(
          label: currentIndex == 1 ? AppStrings.hadith_tab_label : "",
          icon: BottomNavBarItem(
            index: 1,
            currentIndex: currentIndex,
            iconName: "ic_hadeth",
          ),
        ),
        BottomNavigationBarItem(
          label: currentIndex == 2 ? AppStrings.azkar_tab_label : "",
          icon: BottomNavBarItem(
            index: 2,
            currentIndex: currentIndex,
            iconName: "ic_sebha",
          ),
        ),
        BottomNavigationBarItem(
          label: currentIndex == 3 ? AppStrings.radio_tab_label : "",
          icon: BottomNavBarItem(
            index: 3,
            currentIndex: currentIndex,
            iconName: "ic_radio",
          ),
        ),
        BottomNavigationBarItem(
          label: currentIndex == 4 ? AppStrings.time_tab_label : "",
          icon: BottomNavBarItem(
            index: 4,
            currentIndex: currentIndex,
            iconName: "ic_times",
          ),
        ),
      ],
    );
  }
}
