import 'package:cowsandbulls/Game/Game.dart';
import 'package:cowsandbulls/Models/user.dart';
import 'package:cowsandbulls/Services/database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class SinglePlayer extends StatefulWidget {
  @override
  _SinglePlayerState createState() => _SinglePlayerState();
}

class _SinglePlayerState extends State<SinglePlayer> {
  int? _currentGames;
  int? _currentWins;
  int? _currentBestScore;

  String checkNum = '';

  List<List<int>> display = [];
  List<int> randomNumber = [];
  int bestScore = 0;

  final TextEditingController ecls = new TextEditingController();

  @override
  void initState() {
    _getThingsOnStartup().then((value) {
      print('Async done');
      CreateRandomNum randomNumOne = CreateRandomNum();
      randomNumber = randomNumOne.randomNum();
      print(randomNumber);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

    return StreamBuilder<UserData>(
        stream: DatabaseService(uid: user.uid!).userData,
        builder: (context, snapshot) {
          UserData? userData = snapshot.data;

          if (snapshot.hasData) {
            print(userData);
            _currentGames = userData!.games;
            _currentWins = userData.wins;
            _currentBestScore = userData.bestScore;
          }

          return MaterialApp(
              home: Scaffold(
            body: SafeArea(
              child: Column(children: [
                Card(
                  elevation: 0.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(0.0),
                  ),
                  child: ListTile(
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: const <Widget>[
                        Text(
                          'Guess',
                          style: TextStyle(
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          'Bulls',
                          style: TextStyle(
                            color: Colors.greenAccent,
                          ),
                        ),
                        Text(
                          'Cows',
                          style: TextStyle(
                            color: Colors.redAccent,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: display.length,
                    itemBuilder: (context, index) {
                      return Card(
                        elevation: 0.0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(0.0),
                        ),
                        child: ListTile(
                          onTap: () {},
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              display[index][0] < 999
                                  ? Text(
                                      '0' + display[index][0].toString(),
                                      style: const TextStyle(
                                        color: Colors.black,
                                      ),
                                    )
                                  : Text(
                                      display[index][0].toString(),
                                      style: const TextStyle(
                                        color: Colors.black,
                                      ),
                                    ),
                              Text(
                                display[index][1].toString(),
                                style: const TextStyle(
                                  color: Colors.greenAccent,
                                ),
                              ),
                              Text(
                                display[index][2].toString(),
                                style: const TextStyle(
                                  color: Colors.redAccent,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Builder(
                      builder: (context) => SizedBox(
                        width: 80.0,
                        child: TextField(
                          controller: ecls,
                          maxLength: 4,
                          autocorrect: true,
                          decoration: const InputDecoration(
                            labelText: "Guess",
                            focusedBorder: UnderlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.black, width: 2.0),
                            ),
                          ),
                          onSubmitted: (String str) {
                            setState(() {
                              checkNum = str;
                              CheckNumber checkNumberTen = CheckNumber(
                                  int.parse(checkNum), randomNumber);
                              List<int>? bullsAndcows10 =
                                  checkNumberTen.bullsAndCows();
                              print(bullsAndcows10);
                              if (bullsAndcows10 != null) {
                                if (bullsAndcows10[1] != 4) {
                                  display.add(bullsAndcows10);
                                  bestScore++;
                                } else {
                                  CreateRandomNum randomNumOne =
                                      CreateRandomNum();
                                  randomNumber = randomNumOne.randomNum();
                                  display = [];

                                  bestScore++;
                                  if (_currentGames != null) {
                                    _currentGames = _currentGames! + 1;
                                  } else {
                                    _currentGames = 1;
                                  }
                                  if (_currentWins != null) {
                                    _currentWins = _currentWins! + 1;
                                  } else {
                                    _currentWins = 1;
                                  }

                                  if (_currentBestScore == null ||
                                      _currentBestScore! > bestScore) {
                                    _currentBestScore = bestScore;
                                  } else {
                                    _currentBestScore = _currentBestScore;
                                  }
                                  print('..........This is game over........');
                                  DatabaseService(uid: user.uid!)
                                      .updateUserData(
                                          userData?.name ?? "YourName",
                                          _currentGames ?? userData!.games,
                                          _currentWins ?? userData!.wins,
                                          _currentBestScore ??
                                              userData!.bestScore,
                                          userData?.pushID ?? "bis");
                                  bestScore = 0;
                                  Scaffold.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                          'Yay! You have won, guess is $checkNum'),
                                      action: SnackBarAction(
                                        label: 'OK',
                                        onPressed: () {
                                          // Some code to undo the change.
                                        },
                                      ),
                                    ),
                                  );
                                }
                              } else {
                                Scaffold.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text('Enter a valid number'),
                                    action: SnackBarAction(
                                      label: 'OK',
                                      onPressed: () {
                                        // Some code to undo the change.
                                      },
                                    ),
                                  ),
                                );
                              }
                            });
                            ecls.clear();
                          },
                          keyboardType: TextInputType.number,
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.digitsOnly
                          ],
                        ),
                      ),
                    ),
                  ],
                )
              ]),
            ),
          ));
        });
  }

  Future _getThingsOnStartup() async {
    await Future.delayed(Duration(seconds: 1));
  }
}
