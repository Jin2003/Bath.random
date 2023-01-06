class User {
  // ignore: prefer_typing_uninitialized_variables
  var groupRef; // groupへの参照
  String userID;
  String userName;
  int bathTime;
  int? order;

  User(
      {required this.groupRef,
      required this.userID,
      required this.userName,
      required this.bathTime,
      this.order});
}
