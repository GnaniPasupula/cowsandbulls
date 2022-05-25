import 'package:cowsandbulls/Models/user.dart';
import 'package:cowsandbulls/Screens/SettingForm.dart';
import 'package:cowsandbulls/Screens/SinglePlayer.dart';
import 'package:cowsandbulls/Services/auth.dart';
import 'package:cowsandbulls/Services/database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MyStatefulWidget(),
    );
  }
}

class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({Key? key}) : super(key: key);

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  final AuthService _auth = AuthService();
  String _currentName = 'YourName';
  String _receiverID = '';

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

    return StreamBuilder<UserData>(
        stream: DatabaseService(uid: user.uid!).userData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            UserData? userData = snapshot.data;
            _currentName = userData!.name;
            _receiverID = userData.uid;
          }

          return MaterialApp(
              home: Scaffold(
            appBar: AppBar(
              actions: [
                TextButton.icon(
                  icon: const Icon(
                    Icons.account_circle,
                    color: Colors.white,
                  ),
                  label: Text(
                    _currentName,
                    style: const TextStyle(color: Colors.white),
                  ),
                  onPressed: () => _showSettingsPanel(),
                ),
                TextButton.icon(
                  icon: const Icon(Icons.exit_to_app, color: Colors.white),
                  label: const Text(
                    'Logout',
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () async {
                    await _auth.signout();
                  },
                ),
              ],
            ),
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                          padding: const EdgeInsets.all(25),
                          child: Column(children: [
                            Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  Text("CowsNBulls",
                                      style: TextStyle(
                                          fontSize: 25,
                                          fontWeight: FontWeight.bold))
                                ]),
                            const SizedBox(
                              height: 40,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.75,
                                  height: MediaQuery.of(context).size.height *
                                      0.18 /
                                      3,
                                  decoration: const BoxDecoration(
                                      color: Colors.blue,
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(5))),
                                  child: TextButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                SinglePlayer()),
                                      );
                                    },
                                    child: const Text(
                                      "SinglePlayer",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 15,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 40,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.75,
                                  height: MediaQuery.of(context).size.height *
                                      0.18 /
                                      3,
                                  decoration: const BoxDecoration(
                                      color: Colors.blue,
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(5))),
                                  child: TextButton(
                                    onPressed: () async {},
                                    child: const Text(
                                      "MultiPlayer",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 15,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ])),
                    ],
                  ),
                ],
              ),
            ),
          ));
        });
  }

  void _showSettingsPanel() {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder: (context) {
          return Container(
            height: MediaQuery.of(context).size.height * 0.75,
            decoration: new BoxDecoration(
              color: Colors.blueGrey[700],
              borderRadius: new BorderRadius.only(
                topLeft: const Radius.circular(25.0),
                topRight: const Radius.circular(25.0),
              ),
            ),
            padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 60.0),
            child: SettingsForm(),
          );
        });
  }
}
