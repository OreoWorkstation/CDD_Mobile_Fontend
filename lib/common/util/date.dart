/// 获取年龄
int cddGetAge(DateTime dt) {
  var now = DateTime.now();

  var age = now.year - dt.year;

  if (age == 0) {
    return age;
  }

  if (now.month < dt.month) {
    return age - 1;
  } else if (now.month > dt.month) {
    return age;
  } else {
    if (now.day < dt.day) {
      return age - 1;
    } else {
      return age;
    }
  }
}

/// x月x日
String cddGetBirthdayWithoutYear(DateTime dt) {
  return "${dt.month}月${dt.day}日";
}

/// xxxx-xx-xx 为了转成DateDate
DateTime cddFormatDatetime(DateTime dt) {
  return DateTime(dt.year, dt.month, dt.day);
}

/// xxxx年x月-x日
String cddFormatBirthday(DateTime dt) {
  return "${dt.year}年${dt.month}月${dt.day}日";
}

/// 获取相差天数
String cddGetDifferenceInDay(DateTime dt) {
  var now = DateTime.now();
  var difference = now.difference(dt);
  return "${difference.inDays.toString()}天";
}

Map<int, String> _number2Chinese = {
  1: "一",
  2: "二",
  3: "三",
  4: "四",
  5: "五",
  6: "六",
  7: "七",
  8: "八",
  9: "九",
  10: "十",
  11: "十一",
  12: "十二",
};

/// 获取中文星期：星期一
String cddGetChineseWeekday(DateTime dt) {
  String res = "星期";
  for (int i = 1; i <= 7; ++i) {
    if (dt.weekday == i) {
      if (i == 7)
        res += "日";
      else
        res += _number2Chinese[dt.weekday];
      break;
    }
  }
  return res;
}

/// 获取中文月份：一月
String cddGetChineseMonth(DateTime dt) {
  String res = "";
  for (int i = 1; i <= 12; ++i) {
    if (dt.month == i) {
      res += _number2Chinese[dt.month];
      break;
    }
  }
  res += "月";
  return res;
}
