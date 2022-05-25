import 'package:cowsandbulls/Models/user.dart';
import 'package:cowsandbulls/Screens/Home.dart';
import 'package:cowsandbulls/authenticate.dart';
import 'package:flutter/Material.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    print(user);

    if (user == null) {
      return Authenticate();
    } else {
      return Home();
    }
  }
}
