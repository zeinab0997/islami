import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islamy/core/utils/app_colors.dart';
import 'package:islamy/core/utils/reusable_fun.dart';
import 'package:islamy/core/utils/text_styles.dart';
import 'package:islamy/data/model/azkar_model.dart';
import 'package:islamy/view/items/zekr_details_item.dart';
import 'package:just_audio/just_audio.dart';

class ZekrDetailsScreen extends StatefulWidget {
  static const String routeName = "ZEKR_DETAILS_SCREEN";

  ZekrDetailsScreen({super.key});

  @override
  State<ZekrDetailsScreen> createState() => _ZekrDetailsScreenState();
}

class _ZekrDetailsScreenState extends State<ZekrDetailsScreen> with WidgetsBindingObserver{
  late AudioPlayer zekrAudioPalyer;
  int selectedZekr = -1;
  bool isPlaying = false;
  bool isLoading = false;

  @override
  void initState() {
    zekrAudioPalyer = AudioPlayer();
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  Future<void> loadZekrAudio({required String url}) async {
    if (!await ReusableFun.hasInternet()) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("No Internet connection! 🛜")));
      return;
    }
    try {
      await zekrAudioPalyer.stop();
      await zekrAudioPalyer.setUrl(url);
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  void dispose() {
    zekrAudioPalyer.dispose();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused || state == AppLifecycleState.inactive) {
      zekrAudioPalyer.pause();
      setState(() {
        isPlaying = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var zekrItem = ModalRoute.of(context)?.settings.arguments as AzkarModel;
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.bg_color,
        appBar: AppBar(
          backgroundColor: AppColors.bg_color,
          centerTitle: true,
          title: Text(zekrItem.title, style: TextStyles.boarding_body_style),
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back, color: AppColors.main_color, size: 24.r),
          ),
        ),
        body: Padding(
          padding: EdgeInsets.only(top: 18.h, left: 18.w, right: 18.w,),

          child: ListView.builder(
            itemBuilder: (context, index) {
              return ZekrDetailsItem(
                zekr: zekrItem.zekrList[index],
                onClick: onZekrPlay,
                index: index,
                isSelected: selectedZekr == index,
                isPlaying: isPlaying,
                isLoading: isLoading,
              );
            },
            itemCount: zekrItem.zekrList.length,
          ),
        ),
      ),
    );
  }

  onZekrPlay(String zekrAudioUrl, int zekrIndex)async {
    if(selectedZekr == zekrIndex){

      zekrAudioPalyer.processingStateStream.listen((state) {// Avoid overlap

        if (state == ProcessingState.loading || state == ProcessingState.buffering) {
          setState(() {
            isLoading = true;
          });
        } else {
          setState(() {
            isLoading = false;
          });
        }
      });

      if(zekrAudioPalyer.playing){
        await zekrAudioPalyer.pause();
        setState(() {
          isPlaying = false;
        });
      }else{
        setState(() {
          isPlaying = true;
        });
        await zekrAudioPalyer.play();
      }
    }else{
      setState(() {
        isPlaying = true;
        selectedZekr = zekrIndex;
      });
      loadZekrAudio(url: zekrAudioUrl).then((value) async {
        await zekrAudioPalyer.play();
      });
    }
  }
}
