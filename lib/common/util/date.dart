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
String cddFormatBirthdayToRestore(DateTime dt) {
  String ans = "${dt.year}-";
  if (dt.month < 10) ans = ans + "0";
  ans = ans + "${dt.month}-";
  if (dt.day < 10) ans = ans + "0";
  ans = ans + "${dt.day}";
  return ans;
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
