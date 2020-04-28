List<String> cddConvertString2List(String content) {
  List<String> res = [];
  if (content.length == 2) return res;
  String item = "";
  int cnt = 0;
  for (int i = 1; i < content.length - 1; ++i) {
    if (content[i] == '\"' || content[i] == " " || content[i] == ",") continue;
    cnt++;
    item += content[i];
    if (cnt == 2) {
      cnt = 0;
      res.add(item);
      item = "";
    }
  }
  return res;
}

// main(List<String> args) {
//   String content = "[\"衣服\", \"食物\"]";
//   List<String> list = [];
//   String item = "";
//   bool flag = false;
//   for (int i = 1; i < content.length - 1; ++i) {
//     if (content[i] == "\"") {
//       if (flag) {
//         list.add(item);
//         flag = false;
//         item = "";
//       } else {
//         flag = true;
//       }
//     } else if (content[i] != "," && content[i] != " ") {
//       item += content[i];
//     }
//   }
//   for (var item in list) {
//     print(item);
//   }
//   print(list);
// }
