import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islamy/core/utils/app_colors.dart';
import 'package:islamy/core/utils/app_images.dart';
import 'package:islamy/core/utils/app_lists.dart';
import 'package:islamy/core/utils/app_strings.dart';
import 'package:islamy/core/utils/text_styles.dart';
import 'package:islamy/data/model/sura_model.dart';
import 'package:islamy/view/items/recent_sura_item.dart';
import 'package:islamy/view/items/sura_name_item.dart';
import 'package:islamy/view/screens/home/tabs/quran_tab/sura_details_screen.dart';

class QuranTab extends StatefulWidget {
  QuranTab({super.key});

  @override
  State<QuranTab> createState() => _QuranTabState();
}

class _QuranTabState extends State<QuranTab> {
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    searchController.addListener(onSearch);
    super.initState();
  }

  void onSearch(){
    AppLists.searchedSurasNamesListEng.clear();
    AppLists.searchedSurasNamesListAr.clear();
    AppLists.searchedSurasIndexList.clear();
    AppLists.searchedSurasVersesNumList.clear();
    String searchText = searchController.text;
    if(searchText.isNotEmpty){
      for(int i = 0; i < AppLists.surasNamesListEng.length; i++){
        String data = AppLists.surasNamesListEng[i];
        if(data.toLowerCase().contains(searchText.toLowerCase())){
          AppLists.searchedSurasNamesListEng.add(data);
          AppLists.searchedSurasNamesListAr.add(AppLists.surasNamesListAr[i]);
          AppLists.searchedSurasIndexList.add(i);
          AppLists.searchedSurasVersesNumList.add(AppLists.versesNumList[i]);
        }
      }
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _searchItem(),
          AppLists.searchedSurasNamesListEng.isNotEmpty? SizedBox():Text(AppStrings.most_recent, style: TextStyles.navigators_styles.copyWith(color: Colors.white),),
          SizedBox(height: 8.h,),
          AppLists.searchedSurasNamesListEng.isNotEmpty? SizedBox():SizedBox(
            height: 150.h,
            child: ListView.separated(
              separatorBuilder: (context, index) {
                return SizedBox(width: 12.w,);
              },
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
              return GestureDetector(
                  onTap: () => Navigator.pushNamed(context, SuraDetailsScreen.routeName, arguments: SuraModel.getSuraModel(index)),
                  child: RecentSuraItem(suraModel: SuraModel.getSuraModel(index),));
            }, itemCount: AppLists.surasNamesListAr.length,),
          ),
          SizedBox(height: 8.h,),
          AppLists.searchedSurasNamesListEng.isNotEmpty? SizedBox():Text(AppStrings.suras_list, style: TextStyles.navigators_styles.copyWith(color: Colors.white),),
          SizedBox(height: 8.h,),
          Expanded(
            child: ListView.separated(
              separatorBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.only(bottom: 8.h),
                  child: Divider(
                    endIndent: 48.w,
                    indent: 48.w,
                  ),
                );
              },
              itemBuilder: (context, index) {
              return GestureDetector(
                  onTap: () => Navigator.pushNamed(context, SuraDetailsScreen.routeName, arguments: AppLists.searchedSurasNamesListEng.isNotEmpty? SuraModel.getSearchedSuraModel(index):SuraModel.getSuraModel(index)),
                  child: SuraNameItem(suraModel: AppLists.searchedSurasNamesListEng.isNotEmpty? SuraModel.getSearchedSuraModel(index):SuraModel.getSuraModel(index),));
            }, itemCount: AppLists.searchedSurasNamesListEng.isNotEmpty? AppLists.searchedSurasNamesListEng.length:AppLists.surasNamesListEng.length),
          )
        ],
      ),
    );
  }

  Widget _searchItem(){
    return Column(
      children: [
        TextField(
          controller: searchController,
          style: TextStyles.navigators_styles.copyWith(color: Colors.white),
          cursorColor: Colors.white,
          decoration: InputDecoration(
            prefixIcon: Padding(
              padding:  EdgeInsets.symmetric(horizontal: 8.r),
              child: Image.asset(AppImages.ic_quran, color: AppColors.main_color, width: 24.w, height: 24.h,),
            ),
            label: Text(AppStrings.sura_name, style: TextStyles.navigators_styles.copyWith(color: Colors.white),),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: AppColors.main_color, width: 1),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: AppColors.main_color, width: 1),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: AppColors.main_color, width: 1),
            ),
          ),
        ),
        SizedBox(height: 20.h,),
      ],
    );
  }
}
