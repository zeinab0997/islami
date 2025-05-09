class ZekrModel {
  final int id;
  final String arTxt;
  final String engTxt;
  final int rebeate;
  final String audioUrl;

  ZekrModel({
    required this.id,
    required this.arTxt,
    required this.engTxt,
    required this.rebeate,
    required this.audioUrl,
  });

  factory ZekrModel.fromJson(Map<String, dynamic> json) {
    return ZekrModel(
      id: int.parse(json['ID'].toString()),
      arTxt: json['ARABIC_TEXT'] ?? '',
      engTxt: json['TRANSLATED_TEXT'] ?? '',
      rebeate: int.parse(json['REPEAT'].toString()),
      audioUrl: json['AUDIO'] ?? '',
    );
  }
}
