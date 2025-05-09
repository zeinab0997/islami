import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper{
  static late final sharedPref;

  static init()async{
    sharedPref = await SharedPreferences.getInstance();
  }

  static Future<bool> saveEligibility()async{
    bool result = await sharedPref.setBool("onBoarding", true);
    return result;
  }

  static bool? getEligibility(){
    return sharedPref.getBool("onBoarding");
  }

  static Future<bool> saveReciter(String reciter)async{
    bool result = await sharedPref.setString("reciter", reciter);
    return result;
  }

  static Future<bool> saveReciterUrl(String url)async{
    bool result = await sharedPref.setString("reciterUrl", url);
    return result;
  }

  static String? getReciter(){
    return sharedPref.getString("reciter");
  }

  static String? getReciterUrl(){
    return sharedPref.getString("reciterUrl");
  }

  static Future<bool> saveGovIndex(int index)async{
    bool result = await sharedPref.setInt("govIndex", index);
    return result;
  }

  static Future<bool> saveGov(String gov)async{
    bool result = await sharedPref.setString("gov", gov);
    return result;
  }


  static int? getGovIndex(){
    return sharedPref.getInt("govIndex");
  }

  static String? getGov(){
    return sharedPref.getString("gov");
  }

}