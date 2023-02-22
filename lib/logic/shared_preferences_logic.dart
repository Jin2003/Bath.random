import 'package:shared_preferences/shared_preferences.dart';

import '../view/constant.dart';

class SharedPreferencesLogic {
  static const keyGroupID = 'groupID';
  static const keyUserID = 'userID';

  // groupIDをローカルに保存
  Future<void> storeGroupID(String groupID) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString(keyGroupID, groupID);
  }

  // userIDをローカルに保存
  Future<void> storeUserID(String userID) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString(keyUserID, userID);
  }

  // IDをローカルから取得
  Future<Map<String, String?>> fetchID() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return {
      keyGroupID: sharedPreferences.getString(keyGroupID),
      keyUserID: sharedPreferences.getString(keyUserID),
    };
  }

  // IDを削除
  void deleteID() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.clear();
  }

  void moveDemo() {
    storeGroupID(Constant.groupID);
    storeUserID(Constant.userID);
  }
}
