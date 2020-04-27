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

/// 获取相差天数
String cddGetDifferenceInDay(DateTime dt) {
  var now = DateTime.now();
  var difference = now.difference(dt);
  return "${difference.inDays.toString()}天";
}
