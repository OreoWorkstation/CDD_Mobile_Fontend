import 'dart:math';

String generateRandomNickname() {
  String alphabet = 'qwertyuiopasdfghjklzxcvbnmQWERTYUIOPASDFGHJKLZXCVBNM';
  int strlenght = 30;

  /// 生成的字符串固定长度
  String left = '';
  for (var i = 0; i < 8; i++) {
    left = left + alphabet[Random().nextInt(alphabet.length)];
  }
  return left;
}
