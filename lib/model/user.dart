class User {
  String? userID;
  String userName;
  int bathTime;
  int? order;

  User(
      {this.userID,
      required this.userName,
      required this.bathTime,
      this.order});
}
