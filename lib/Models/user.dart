class User {
  final String? uid;

  User({this.uid});
}

class UserData {
  final String uid;
  final String name;
  final int games;
  final int wins;
  final int bestScore;
  final String pushID;
  UserData(
      {required this.uid,
      required this.name,
      required this.games,
      required this.wins,
      required this.bestScore,
      required this.pushID});
}
