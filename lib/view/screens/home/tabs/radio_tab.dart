import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islamy/core/api/urls.dart';
import 'package:islamy/core/utils/app_strings.dart';
import 'package:islamy/core/utils/reusable_fun.dart';
import 'package:islamy/view/items/radio_item.dart';
import 'package:just_audio/just_audio.dart';

class RadioTab extends StatefulWidget {
  const RadioTab({super.key});

  @override
  State<RadioTab> createState() => _RadioTabState();
}

class _RadioTabState extends State<RadioTab> with WidgetsBindingObserver {
  late AudioPlayer egyptAudioPlayer;
  late AudioPlayer kuwaitAudioPlayer;

  bool isPlaying = false;
  bool isLoading = false;

  int? currentlyLoadingIndex;

  @override
  void initState() {
    egyptAudioPlayer = AudioPlayer();
    kuwaitAudioPlayer = AudioPlayer();
    WidgetsBinding.instance.addObserver(this);
    initRadio();
    super.initState();
  }

  Future<void> initRadio() async {
    if (!await ReusableFun.hasInternet()) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("No Internet connection! 🛜")));
      return;
    }
    try {
      await egyptAudioPlayer.setUrl(Urls.egyptRadioUrl);
      await kuwaitAudioPlayer.setUrl(Urls.kuwaitRadioUrl);
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  void dispose() {
    egyptAudioPlayer.dispose();
    kuwaitAudioPlayer.dispose();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused ||
        state == AppLifecycleState.inactive) {
      egyptAudioPlayer.pause();
      kuwaitAudioPlayer.pause();
      setState(() {
        isPlaying = false;
      });
    }
    super.didChangeAppLifecycleState(state);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.h),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            RadioItem(
              audioPlayer: egyptAudioPlayer,
              name: AppStrings.egypt,
              onClick: onAudioClicked,
              isPlaying: isPlaying,
              isLoading: currentlyLoadingIndex == 1,
              index: 1,
            ),
            SizedBox(height: 16.h),
            RadioItem(
              audioPlayer: kuwaitAudioPlayer,
              name: AppStrings.kuwait,
              onClick: onAudioClicked,
              isPlaying: isPlaying,
              isLoading: currentlyLoadingIndex == 2,
              index: 2,
            ),
          ],
        ),
      ),
    );
  }

  onAudioClicked(AudioPlayer player, int index) async {
    if (!await ReusableFun.hasInternet()) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("No Internet connection! 🛜")));
      return;
    }
    player.processingStateStream.listen((state) {
      if (currentlyLoadingIndex != index) return;
      if (state == ProcessingState.loading || state == ProcessingState.buffering) {
        print('🔄 Audio is loading...');
        setState(() {
          currentlyLoadingIndex = index;

        });
      } else{
        setState(() {
          currentlyLoadingIndex = null;

        });
      }
    });
    if (player.playing) {
      player.pause();
      print("Paused");
      setState(() {});
    } else {
      player.play();
      print("Playing");
      setState(() {});
    }
  }
}
