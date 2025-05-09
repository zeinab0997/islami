import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islamy/core/utils/app_colors.dart';
import 'package:islamy/core/utils/app_images.dart';
import 'package:islamy/core/utils/text_styles.dart';
import 'package:islamy/data/model/hadith_model.dart';
import 'package:islamy/view/items/hadith_item.dart';
import 'package:islamy/view/screens/home/tabs/hadith_tab/hadith_details_screen.dart';

class HadithTab extends StatefulWidget {
  HadithTab({super.key});

  @override
  State<HadithTab> createState() => _HadithTabState();
}

class _HadithTabState extends State<HadithTab> {
  List<HadithModel> ahadithList = [];

  @override
  Widget build(BuildContext context) {
    if (ahadithList.isEmpty) {
      loadAhadithFile();
    }
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16.h),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: CarouselSlider(
              options: CarouselOptions(
                height: MediaQuery.of(context).size.height,
                enlargeCenterPage: true,
              ),
              items: ahadith(ahadithList),
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> ahadith(List<HadithModel> ahadith) {
    final List<Widget> ahadithItems =
        ahadith
            .asMap().entries.map(
              (item) => GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, HadithDetailsScreen.routeName, arguments: item);
                  },
                  child: HadithItem(hadithItem: item)),
            )
            .toList();

    return ahadithItems;
  }

  loadAhadithFile() {
    rootBundle
        .loadString("assets/files/ahadith.txt")
        .then((ahadithFile) {
          List<String> ahadith = ahadithFile.split("#");
          for (String hadith in ahadith) {
            List<String> lines = hadith.trim().split("\n");
            String title = lines[0];
            lines.removeAt(0);
            List<String> content = lines;
            HadithModel hadithModel = HadithModel(
              title: title,
              content: content,
            );
            ahadithList.add(hadithModel);
          }
          setState(() {});
        })
        .catchError((error) {
          print("Error $error");
        });
  }
}
