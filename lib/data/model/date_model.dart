class DateInfo {
  final HijriDate hijri;
  final GregorianDate gregorian;
  final String readable;
  final String timestamp;

  DateInfo({
    required this.hijri,
    required this.gregorian,
    required this.readable,
    required this.timestamp,
  });

  factory DateInfo.fromJson(Map<String, dynamic> json) {
    return DateInfo(
      readable: json['readable'],
      timestamp: json['timestamp'],
      hijri: HijriDate.fromJson(json['hijri']),
      gregorian: GregorianDate.fromJson(json['gregorian']),
    );
  }
}


class HijriDate {
  final String date;
  final String format;
  final String day;
  final Weekday weekday;
  final HijriMonth month;
  final String year;
  final Designation designation;
  final List<dynamic> holidays;
  final List<dynamic> adjustedHolidays;
  final String method;

  HijriDate({
    required this.date,
    required this.format,
    required this.day,
    required this.weekday,
    required this.month,
    required this.year,
    required this.designation,
    required this.holidays,
    required this.adjustedHolidays,
    required this.method,
  });

  factory HijriDate.fromJson(Map<String, dynamic> json) {
    return HijriDate(
      date: json['date'],
      format: json['format'],
      day: json['day'],
      weekday: Weekday.fromJson(json['weekday']),
      month: HijriMonth.fromJson(json['month']),
      year: json['year'],
      designation: Designation.fromJson(json['designation']),
      holidays: json['holidays'],
      adjustedHolidays: json['adjustedHolidays'],
      method: json['method'],
    );
  }
}

class Weekday {
  final String en;
  final String? ar;

  Weekday({required this.en, this.ar});

  factory Weekday.fromJson(Map<String, dynamic> json) {
    return Weekday(
      en: json['en'],
      ar: json['ar'],
    );
  }
}

class HijriMonth {
  final int number;
  final String en;
  final String ar;
  final int days;

  HijriMonth({
    required this.number,
    required this.en,
    required this.ar,
    required this.days,
  });

  factory HijriMonth.fromJson(Map<String, dynamic> json) {
    return HijriMonth(
      number: json['number'],
      en: json['en'],
      ar: json['ar'],
      days: json['days'],
    );
  }
}


class GregorianDate {
  final String date;
  final String format;
  final String day;
  final Weekday weekday;
  final GregorianMonth month;
  final String year;
  final Designation designation;
  final bool lunarSighting;

  GregorianDate({
    required this.date,
    required this.format,
    required this.day,
    required this.weekday,
    required this.month,
    required this.year,
    required this.designation,
    required this.lunarSighting,
  });

  factory GregorianDate.fromJson(Map<String, dynamic> json) {
    return GregorianDate(
      date: json['date'],
      format: json['format'],
      day: json['day'],
      weekday: Weekday.fromJson(json['weekday']),
      month: GregorianMonth.fromJson(json['month']),
      year: json['year'],
      designation: Designation.fromJson(json['designation']),
      lunarSighting: json['lunarSighting'],
    );
  }
}

class GregorianMonth {
  final int number;
  final String en;

  GregorianMonth({required this.number, required this.en});

  factory GregorianMonth.fromJson(Map<String, dynamic> json) {
    return GregorianMonth(
      number: json['number'],
      en: json['en'],
    );
  }
}


class Designation {
  final String abbreviated;
  final String expanded;

  Designation({
    required this.abbreviated,
    required this.expanded,
  });

  factory Designation.fromJson(Map<String, dynamic> json) {
    return Designation(
      abbreviated: json['abbreviated'],
      expanded: json['expanded'],
    );
  }
}