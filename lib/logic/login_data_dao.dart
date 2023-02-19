import 'package:bath_random/model/group_data.dart';
import 'package:bath_random/model/user_data.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class LoginDataDao {
  final CollectionReference _groupCollection =
      FirebaseFirestore.instance.collection('group');
  final CollectionReference _userColloction =
      FirebaseFirestore.instance.collection('user');

  // グループを作成
  Future<String> createGroupData(int userCounts) async {
    // _groupCollection.add(groupData.toJson());
    String groupID = _groupCollection.doc().id;
    await _groupCollection.doc(groupID).set({
      'groupID': groupID,
      'userCounts': userCounts,
      'isSetOrder': false,
    });

    return groupID;
  }

  // ユーザを作成
  Future<String> createUserData(
      String groupID, String userName, int bathTime) async {
    String userID = _userColloction.doc().id;
    await _userColloction.doc(userID).set({
      'groupID': groupID,
      'userID': userID,
      'userName': userName,
      'bathTime': bathTime,
      'order': -1,
    });
    return userID;
  }

  // グループIDからグループの情報を取得
  Future<GroupData> fetchGroupData(String groupID) async {
    print('groupID: $groupID');
    var groupData = await _groupCollection.doc(groupID).get().then(
      (DocumentSnapshot doc) {
        final data = doc.data() as Map<String, dynamic>;
        print('fetch data: $data');
        return GroupData(
          groupID: groupID,
          userCounts: data['userCounts'],
          isSetOrder: data['isSetOrder'],
          groupStartTime: data['groupStartTime'],
        );
      },
      onError: (error) => print('Error getting document: $error'),
    );
    return groupData;
  }

  // グループIDからuserのデータをすべて取得
  Future<List<UserData>> fetchUserData(String groupID) async {
    List<UserData> list = [];

    await _userColloction
        .where('groupID', isEqualTo: groupID)
        .get()
        .then((QuerySnapshot snapshot) {
      List<DocumentSnapshot> docs = snapshot.docs;
      for (var data in docs) {
        print(data);
        list.add(UserData(
          groupID: groupID,
          userID: data['userID'],
          userName: data['userName'],
          bathTime: data['bathTime'],
        ));
      }
    });
    return list;
  }

  // グループを削除
  Future<void> deleteGroup(String? groupID) async {
    final groupDoc = _groupCollection.doc(groupID);
    await groupDoc.delete();
  }

  // groupIDに登録されたグループ(一つ)を取得
  Stream<GroupData> streamGroupData(String groupID) {
    return _groupCollection.doc(groupID).snapshots().map(
        (event) => GroupData.fromJson(event.data() as Map<String, dynamic>));
  }

  // 同一のグループのユーザを全員取得
  Stream<List<UserData>> streamUserData(String groupID) {
    final stream =
        _userColloction.where('groupID', isEqualTo: groupID).snapshots();
    return stream.map(
      (e) => e.docs
          .map((e) => UserData.fromJson(e.data() as Map<String, dynamic>))
          .toList(),
    );
  }

  // ユーザの情報（１つ）を取得
  Future<UserData> fetchMyUserData(String userID) async {
    return await _userColloction.doc(userID).get().then(
        (value) => UserData.fromJson(value.data() as Map<String, dynamic>));
  }

  // groupIDに登録されたユーザー(複数)を取得
  Stream<QuerySnapshot<Object?>> getUserSnapshots(String groupID) {
    return _userColloction.where('groupID', isEqualTo: groupID).snapshots();
  }

  // シャッフルデータ登録
  Future<void> shuffleData(List<UserData> userDataList) async {
    int index = 0;
    for (var userData in userDataList) {
      await _userColloction.doc(userData.userID).update({
        'order': index++,
      });
    }
  }

  // 順番決定設定
  Future<void> disabledStart(String groupID) async {
    await _groupCollection.doc(groupID).update({
      'isSetOrder': true,
    });
  }

  // お風呂スタートボタンを押した時間を設定
  Future<void> startBath(String groupID) async {
    final nowStamp = DateTime.now();
    await _groupCollection.doc(groupID).update({
      'groupStartTime': nowStamp,
    });
  }

  // お風呂に入る時間を設定
  Future<void> setMyStartTime(String userID, DateTime startTime) async {
    await _userColloction.doc(userID).update({
      'startTime': Timestamp.fromDate(startTime),
    });
  }

  // デモ用: スタートボタンを有効にする
  Future<void> enableStart(String groupID) async {
    await _groupCollection.doc(groupID).update({
      'isSetOrder': false,
    });
  }

  // TODO: index番目の画像をcurrentIconに変更する
  Future<void> setCurrentIcon(String userID, int index) async {
    await _userColloction.doc(userID).update({
      'currentIcon': index,
    });
  }

  // TODO: index番目の画像をmyIconsに追加する
  Future<void> addIcon(String userID, int index) async {
    await _userColloction.doc(userID).update({
      'currentIcon': FieldValue.arrayUnion([index]),
    });
  }
}
