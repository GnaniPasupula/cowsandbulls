class Game {
  final String uid;
  Game({required this.uid});
}

class GameData {
  final bool turn;
  final String uid;
  final String bulls;
  final String cows;
  final String guess;
  final String name;
  final String receiverID;
  final String receiverNumber;
  final String senderID;
  final String senderNumber;
  GameData(
      {required this.turn,
      required this.uid,
      required this.bulls,
      required this.cows,
      required this.guess,
      required this.name,
      required this.receiverID,
      required this.receiverNumber,
      required this.senderID,
      required this.senderNumber});
}
