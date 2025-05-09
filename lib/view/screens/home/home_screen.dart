import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:islamy/core/utils/app_colors.dart';
import 'package:islamy/core/utils/app_images.dart';
import 'package:islamy/core/utils/app_lists.dart';
import 'package:islamy/core/utils/app_strings.dart';
import 'package:islamy/core/utils/text_styles.dart';
import 'package:islamy/data/cache_helper/cache_helper.dart';
import 'package:islamy/view/items/bottom_nav_bar_item.dart';
import 'package:islamy/view/items/bottom_nav_bar.dart';
import 'package:islamy/view/screens/home/tabs/hadith_tab/hadith_tab.dart';
import 'package:islamy/view/screens/home/tabs/quran_tab/quran_tab.dart';
import 'package:islamy/view/screens/home/tabs/radio_tab.dart';
import 'package:islamy/view/screens/home/tabs/azkar_tab/azkar_tab.dart';
import 'package:islamy/view/screens/home/tabs/time_tab/time_tab.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = "HOME_SCREEN";

  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentIndex = 0;

  List<String> bgNames = [
    "quran_bg",
    "hadith_bg",
    "sebha_bg",
    "radio_bg",
    "time_bg",
  ];
  List<Widget> tabs = [
    QuranTab(),
    HadithTab(),
    AzkarTab(),
    RadioTab(),
    TimeTab(),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration:  BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/${bgNames[currentIndex]}.png"),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: Column(
            children: [
              currentIndex == 4? SizedBox(): Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [Image.asset(AppImages.islami_logo_img)],
              ),
              Expanded(child: tabs[currentIndex]),
            ],
          ),
        ),
        bottomNavigationBar: BottomNavBar(
          onChange: (index) {
            setState(() {
              currentIndex = index;
            });
          },
        ),
      ),
    );
  }
}
