import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islamy/core/utils/app_colors.dart';
import 'package:islamy/core/utils/app_images.dart';
import 'package:islamy/core/utils/text_styles.dart';
import 'package:just_audio/just_audio.dart';


class RadioItem extends StatelessWidget {
  AudioPlayer audioPlayer;
  String name;
  Function onClick;
  bool isPlaying;
  bool isLoading;
  int index;

  RadioItem({super.key, required this.audioPlayer, required this.name, required this.onClick, required this.isPlaying, required this.isLoading, required this.index});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 144.h,
      decoration: BoxDecoration(
          color: AppColors.main_color,
          borderRadius: BorderRadius.circular(20.r)
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Image.asset(AppImages.hadith_bottom_dec, width: double.infinity, fit: BoxFit.cover,),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text("Radio $name", style: TextStyles.boarding_body_style.copyWith(color: AppColors.bg_color),),
              isLoading? CircularProgressIndicator(color: Colors.white,):IconButton(onPressed: ()=>onClick(audioPlayer, index), icon: (audioPlayer.playing || isPlaying)? Icon(
                Icons.pause, color: AppColors.bg_color,
                size: 48.r,
              ):Icon(
                Icons.play_arrow_rounded, color: AppColors.bg_color,
                size: 48.r,
              ))
            ],
          )
        ],
      ),
    );
  }
}
