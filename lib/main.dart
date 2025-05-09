import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hijri/hijri_calendar.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:islamy/data/cache_helper/cache_helper.dart';
import 'package:islamy/splash_screen.dart';
import 'package:islamy/view/screens/home/home_screen.dart';
import 'package:islamy/view/screens/home/tabs/azkar_tab/zekr_details_screen.dart';
import 'package:islamy/view/screens/home/tabs/hadith_tab/hadith_details_screen.dart';
import 'package:islamy/view/screens/home/tabs/quran_tab/sura_details_screen.dart';
import 'package:islamy/view/screens/onboarding_screen.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting('ar', null);
  HijriCalendar.setLocal('ar'); // or 'en'
  await CacheHelper.init();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(const Islamy());
}

class Islamy extends StatelessWidget {
  const Islamy({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(430, 932),
      minTextAdapt: true,
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          initialRoute: SplashScreen.routeName,
          routes: {
            SplashScreen.routeName: (context) => SplashScreen(),
            OnboardingScreen.routeName: (context) => OnboardingScreen(),
            HomeScreen.routeName: (context) => HomeScreen(),
            SuraDetailsScreen.routeName: (context) => SuraDetailsScreen(),
            HadithDetailsScreen.routeName: (context) => HadithDetailsScreen(),
            ZekrDetailsScreen.routeName: (context) => ZekrDetailsScreen(),
          },
        );
      },
    );
  }
}

