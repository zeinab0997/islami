import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:islamy/core/utils/app_colors.dart';
import 'package:islamy/core/utils/app_images.dart';
import 'package:islamy/core/utils/app_strings.dart';
import 'package:islamy/core/utils/text_styles.dart';
import 'package:islamy/data/cache_helper/cache_helper.dart';
import 'package:islamy/view/screens/home/home_screen.dart';

class OnboardingScreen extends StatefulWidget {
  static const String routeName = "ONBOARDING_SCREEN";

  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  var pageDecoration = PageDecoration(
    titleTextStyle: TextStyles.boarding_title_style,
    imageFlex: 3,
    bodyTextStyle: TextStyles.boarding_body_style,
    bodyPadding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
    pageColor: AppColors.bg_color,
    imagePadding: EdgeInsets.zero,
  );

  Widget _buildImage(String assetName, [double width = 350, double height = 300]) {
    return Image.asset('assets/images/$assetName', width: width.w, height: height.h,);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: IntroductionScreen(
        globalBackgroundColor: AppColors.bg_color,
        allowImplicitScrolling: false,
        infiniteAutoScroll: false,
        pages: [
          PageViewModel(
            title: AppStrings.welcome_app,
            body: "",
            image: _buildImage('onboarding1.png'),
            decoration: pageDecoration,
          ),
          PageViewModel(
            title: AppStrings.welcome,
            body: AppStrings.have_you_in_community,
            image: _buildImage('onboarding2.png'),
            decoration: pageDecoration,
          ),
          PageViewModel(
            title: AppStrings.reading_quran,
            body: AppStrings.read,
            image: _buildImage('onboarding3.png'),
            decoration: pageDecoration,
          ),
          PageViewModel(
            title: AppStrings.bearish,
            body: AppStrings.praise,
            image: _buildImage('onboarding4.png'),
            decoration: pageDecoration,
          ),
          PageViewModel(
            title: AppStrings.radio,
            body: AppStrings.listen,
            image: _buildImage('onboarding5.png'),
            decoration: pageDecoration,
          ),
        ],
        globalHeader: Image.asset(AppImages.islami_logo_img),
        showBackButton: true,
        showNextButton: true,
        showDoneButton: true,
        //rtl: true, // Display as right-to-left
        back: Text(AppStrings.back, style: TextStyles.navigators_styles),
        next: Text(AppStrings.next, style: TextStyles.navigators_styles),
        done: Text(AppStrings.finish, style: TextStyles.navigators_styles),
        onDone: () {
          CacheHelper.saveEligibility();
          Navigator.pushReplacementNamed(context, HomeScreen.routeName);
        },

        curve: Curves.fastLinearToSlowEaseIn,
        controlsMargin: EdgeInsets.all(16.r),
        dotsDecorator: DotsDecorator(
          size: Size(8.w, 10.h),
          color: AppColors.gray_color,
          activeSize: Size(16.0.w, 10.0.h),
          activeColor: AppColors.main_color,
          activeShape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(25.r)),
          ),
        ),

      ),
    );
  }
}
