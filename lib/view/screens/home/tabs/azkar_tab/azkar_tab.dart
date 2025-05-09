import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islamy/core/api/api_manager.dart';
import 'package:islamy/core/utils/app_colors.dart';
import 'package:islamy/core/utils/reusable_fun.dart';
import 'package:islamy/core/utils/text_styles.dart';
import 'package:islamy/data/model/azkar_model.dart';
import 'package:islamy/view/items/zekr_item.dart';
import 'package:islamy/view/screens/home/tabs/azkar_tab/zekr_details_screen.dart';

class AzkarTab extends StatefulWidget {
  const AzkarTab({super.key});

  @override
  State<AzkarTab> createState() => _AzkarTabState();
}

class _AzkarTabState extends State<AzkarTab> {
  List<int> zekrNums = [1, 27, 28, 15, 16, 25, 129, 61, 55];
  List<AzkarModel> azkarList = [];

  @override
  void initState() {
    loadAzkarList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child:
          azkarList.length == 0
              ? Center(
                child: CircularProgressIndicator(color: AppColors.main_color),
              )
              : ListView.builder(
                itemBuilder: (context, index) {
                  return ZekrItem(
                    azkarItem: azkarList[index],
                    index: index,
                    onClick: onZekrClicked,
                  );
                },
                itemCount: azkarList.length,
              ),
    );
  }

  void loadAzkarList() async {
    if (!await ReusableFun.hasInternet()) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("No Internet connection! 🛜")));
      return;
    }
    for (int i = 0; i < zekrNums.length; i++) {
      print(zekrNums[i]);
      AzkarModel azkar = await ApiManager.getZekrList(
        zekrNum: "${zekrNums[i]}",
      );
      azkarList.add(azkar);
      setState(() {});
    }
  }

  onZekrClicked(int index) {
    Navigator.pushNamed(
      context,
      ZekrDetailsScreen.routeName,
      arguments: azkarList[index],
    );
  }
}
