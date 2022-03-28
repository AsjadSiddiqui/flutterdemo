import 'package:example/services/services.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      body: Container(
          child: Center(
        child: ElevatedButton(
            onPressed: () async {
              FirebaseManager.logout();
            },
            child: Text("Logout")),
      )),
    );
  }
}
