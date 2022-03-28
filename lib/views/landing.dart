import 'package:example/TabBar/tabcontroller.dart' as demo;
import 'package:example/services/services.dart';
import 'package:example/services/utility.dart';
import 'package:example/views/welcome.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LandingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting)
          return loadingScreen();
        else if (snapshot.connectionState == ConnectionState.active) {
          final user = snapshot.data;
          if (user != null) {
            return demo.TabController();
          } else {
            return const Welcome();
          }
        } else
          return errorScreen();
      },
    );
  }
}
