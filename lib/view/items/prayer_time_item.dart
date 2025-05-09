import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:islamy/core/utils/text_styles.dart';

class PrayerTimeItem extends StatelessWidget {
  String pray;
  String time;
  PrayerTimeItem({super.key, required this.pray, required this.time});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(time, style: TextStyles.sebha_title_style,),
        Text(pray, style: TextStyles.sebha_title_style,),
      ],
    );
  }
}
