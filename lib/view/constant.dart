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
    'normal',
    'necktie',
    'ribbon',
    'crown',
    'swimmingRing',
    'candy',
    'cookie',
    'note',
    'heart',
    'silkhat',
  ];

  // カード画像（裏面）
  static const List<String> backCard = [
    'cards_hazure',
    'cards_hazure',
    'cards_hazure',
    'cards_atari',
    'cards_hazure',
    'cards_hazure',
  ];
}
