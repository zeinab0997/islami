import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islamy/core/utils/app_colors.dart';
import 'package:islamy/core/utils/app_images.dart';
import 'package:islamy/core/utils/app_lists.dart';
import 'package:islamy/core/utils/reusable_fun.dart';
import 'package:islamy/core/utils/text_styles.dart';
import 'package:islamy/data/cache_helper/cache_helper.dart';
import 'package:islamy/data/model/sura_model.dart';
import 'package:islamy/view/items/verse_item.dart';
import 'package:just_audio/just_audio.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class SuraDetailsScreen extends StatefulWidget {
  static const String routeName = "SURA_DETAILS_SCREEN";

  const SuraDetailsScreen({super.key});

  @override
  State<SuraDetailsScreen> createState() => _SuraDetailsScreenState();
}

class _SuraDetailsScreenState extends State<SuraDetailsScreen>
    with WidgetsBindingObserver {
  List<String> verses = [];
  late AudioPlayer verseAudioPlayer;
  int selectedVerseIndex = -1;
  String selectedReciter =
      CacheHelper.getReciterUrl() == null
          ? AppLists.reciters[0].url
          : CacheHelper.getReciterUrl()!;

  ItemScrollController itemScrollController = ItemScrollController();
  ItemPositionsListener itemPositionsListener = ItemPositionsListener.create();
  AppLifecycleState? _appLifecycleState;

  bool isLoading = false;

  @override
  void initState() {
    verseAudioPlayer = AudioPlayer();
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  Future<void> loadVerse({
    required int suraIndex,
    required int verseIndex,
  }) async {
    if (!await ReusableFun.hasInternet()) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("No Internet connection! 🛜")));
      return;
    }
    String sura = "001";
    String verse = "001";
    if (suraIndex.toString().length == 1) {
      sura = "00$suraIndex";
    } else if (suraIndex.toString().length == 2) {
      sura = "0$suraIndex";
    } else {
      sura = "$suraIndex";
    }

    if (verseIndex.toString().length == 1) {
      verse = "00$verseIndex";
    } else if (verseIndex.toString().length == 2) {
      verse = "0$verseIndex";
    } else {
      verse = "$verseIndex";
    }

    print("sura index $sura");
    print("verse index $verse");

    try {
      await verseAudioPlayer.stop();
      print("https://everyayah.com/data/$selectedReciter/$sura$verse.mp3");
      await verseAudioPlayer.setUrl(
        "https://everyayah.com/data/$selectedReciter/$sura$verse.mp3",
      );
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  void dispose() {
    verseAudioPlayer.dispose();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {

    setState(() {
      _appLifecycleState = state;
    });
    if (state == AppLifecycleState.paused || state == AppLifecycleState.inactive) {
      verseAudioPlayer.pause();
    }
    super.didChangeAppLifecycleState(state);
  }

  @override
  Widget build(BuildContext context) {
    var suraModel = ModalRoute.of(context)?.settings.arguments as SuraModel;
    if (verses.isEmpty) {
      loadSuraFile(suraModel.index + 1);
    }

    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.bg_color,
        appBar: AppBar(
          backgroundColor: AppColors.bg_color,
          centerTitle: true,
          title: Text(suraModel.nameEng, style: TextStyles.boarding_body_style),
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back, color: AppColors.main_color, size: 24.r),
          ),
        ),
        body: Stack(
          alignment: Alignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 18.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Image.asset(AppImages.sura_details_tl_dec),
                      Image.asset(AppImages.sura_details_tr_dec),
                    ],
                  ),
                ),
                Image.asset(AppImages.sura_details_bottom_dec),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(top: 18.h, left: 18.w, right: 18.w),
              child: Column(
                children: [
                  Text(suraModel.nameAr, style: TextStyles.boarding_title_style),
                  SizedBox(height: 56.h),
                  Expanded(
                    child: ScrollablePositionedList.separated(
                      itemScrollController: itemScrollController,
                      itemPositionsListener: itemPositionsListener,
                      separatorBuilder: (context, index) {
                        return SizedBox(height: 8.h);
                      },
                      itemBuilder: (context, index) {
                        return VerseItem(
                          verse: verses[index],
                          suraIndex: suraModel.index,
                          numOfVerses: suraModel.numOfVerses,
                          verseIndex: index,
                          onClick: isLoading? null:onVerseClicked,
                          isClicked: selectedVerseIndex == index,
                        );
                      },
                      itemCount: verses.length,
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                alignment: Alignment.center,
                padding: EdgeInsets.symmetric(horizontal: 12.w),
                height: 85.h,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: AppColors.main_color,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(16.r),
                    topLeft: Radius.circular(16.r),
                  ),
                ),
                child: Row(
                  children: [
                    IconButton(
                      onPressed:isLoading? null: () {
                        if (verseAudioPlayer.playing) {
                          verseAudioPlayer.pause();
                        } else {
                          if (selectedVerseIndex == -1) {
                            onVerseClicked(
                              sura_index: suraModel.index + 1,
                              verse_index: 0,
                              numOfVerses: suraModel.numOfVerses,
                            );
                          } else {
                            verseAudioPlayer.play();
                          }
                        }
                        setState(() {});
                      },
                      icon: isLoading? CircularProgressIndicator(color: AppColors.bg_color,):Icon(
                       (_appLifecycleState == AppLifecycleState.paused || _appLifecycleState == AppLifecycleState.inactive ||   verseAudioPlayer.playing)
                            ? Icons.pause
                            : Icons.play_arrow_rounded,
                        color: AppColors.bg_color,
                        size: 48.r,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 12),
                      child: DropdownButton<String>(
                        value: selectedReciter,
                        underline: SizedBox(),
                        icon: Icon(
                          Icons.arrow_drop_down,
                          color: AppColors.bg_color,
                          size: 32.r,
                        ),
                        items:
                            AppLists.reciters.map((item) {
                              return DropdownMenuItem<String>(
                                value: item.url,
                                child: Text(
                                  item.title,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyles.boarding_body_style.copyWith(
                                    color: AppColors.bg_color,
                                  ),
                                ),
                              );
                            }).toList(),
                        onChanged: (value) {
                          setState(() {
                            selectedReciter = value!;
                            CacheHelper.saveReciterUrl(selectedReciter);
                            CacheHelper.saveReciter(
                              AppLists
                                  .reciters[AppLists.reciters.indexWhere(
                                    (reciter) => reciter.url == selectedReciter,
                                  )]
                                  .title,
                            );
                            if (selectedVerseIndex >= 0) {
                              onVerseClicked(
                                sura_index: suraModel.index + 1,
                                verse_index: selectedVerseIndex,
                                numOfVerses: suraModel.numOfVerses,
                                reciter: selectedReciter,
                              );
                            }
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void onVerseClicked({
    required int sura_index,
    required int verse_index,
    required int numOfVerses,
    String? reciter,
  }) {
    verseAudioPlayer.processingStateStream.listen((state) {// Avoid overlap

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

    reciter ??= AppLists.reciters[0].url;
    print(reciter);
    scrollToVerse(verse_index);
    loadVerse(suraIndex: sura_index, verseIndex: verse_index + 1).then((
      value,
    ) async {
      print("old vers index =  ${verse_index}");

      setState(() {
        selectedVerseIndex = verse_index;
      });
      if (verseAudioPlayer.playing) {
        await verseAudioPlayer.pause();
        print("Paused");
      } else {
        await verseAudioPlayer.play();
        if (verseAudioPlayer.playerState.processingState ==
            ProcessingState.completed) {
          print("finished");
          verse_index = verse_index + 1;
          print("new vers index =  ${verse_index}");
          print("nov =  ${numOfVerses}");
          if (verse_index < numOfVerses) {
            print("new sura index   =  $sura_index");
            scrollToVerse(verse_index);
            onVerseClicked(
              sura_index: sura_index,
              verse_index: verse_index,
              numOfVerses: numOfVerses,
            );
          }
        }
        print("Playing");
      }
    });
  }

  void scrollToVerse(int index) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final positions = itemPositionsListener.itemPositions.value;
      bool isVisible = positions.any((pos) => pos.index == selectedVerseIndex);
      if (!isVisible) {
        itemScrollController.scrollTo(
          index: index,
          duration: Duration(milliseconds: 500),
          curve: Curves.easeInOut,
          alignment: 0, // 0.5 means center of the screen
        );
      }
    });
  }

  Future<void> loadSuraFile(int index) async {
    String suraFile = await rootBundle.loadString(
      "assets/suras_files/$index.txt",
    );
    List<String> lines = suraFile.split("\n");

    verses = lines;
    setState(() {});
  }
}
