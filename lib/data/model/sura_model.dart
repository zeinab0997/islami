import 'package:islamy/core/utils/app_lists.dart';

class SuraModel {
  String nameEng;
  String nameAr;
  int index;
  int numOfVerses;

  SuraModel({
    required this.nameAr,
    required this.nameEng,
    required this.index,
    required this.numOfVerses,
  });

  static SuraModel getSuraModel(int index) {
    return SuraModel(
      nameAr: AppLists.surasNamesListAr[index],
      nameEng: AppLists.surasNamesListEng[index],
      index: index,
      numOfVerses: AppLists.versesNumList[index],
    );
  }

  static SuraModel getSearchedSuraModel(int index) {
    return SuraModel(
      nameAr: AppLists.searchedSurasNamesListAr[index],
      nameEng: AppLists.searchedSurasNamesListEng[index],
      index: AppLists.searchedSurasIndexList[index],
      numOfVerses: AppLists.searchedSurasVersesNumList[index],
    );
  }
}
