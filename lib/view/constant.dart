import 'package:flutter/material.dart';

// 定数を管理するクラス
class Constant {
  // 色
  static const Color lightBlueColor = Color.fromARGB(255, 150, 222, 231);
  static const Color bathWhite = Color.fromARGB(255, 239, 253, 255);
  static Color lightGreyColor = Colors.grey.shade700;
  static Color greyColor = const Color.fromRGBO(0, 0, 0, 0.3);

  // お風呂のインターバル時間
  static const int intervalTime = 10;

  // デモ用データ
  static String groupID = 'grO7qrXoht7jZYjEQH0a';
  static String userID = 'K7V2qcKZgAPPr6xZZxFs';

  // アイコン画像名
  static const List<String> dressUp = [
    'normal_dack',
    'necktie_dack',
    'ribbon_dack',
    'crown_dack',
    'swimmingring_dack',
    'candy_dack',
    'cookie_dack',
    'note_dack',
    'heart_dack',
    'silkhat_dack',
  ];
}
