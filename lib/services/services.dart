import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

/// Class for adding styles
class Styler {
  // Create a TextStyle
  static TextStyle createTextStyle(
      {double fontSize = 17,
      FontWeight fontweight = FontWeight.w600,
      Color textColor = Colors.black}) {
    return TextStyle(
        fontSize: fontSize, fontWeight: fontweight, color: textColor);
  }
}

/// Compute size responsively
class SizeConfig {
  static MediaQueryData _mediaQueryData = MediaQueryData();
  static late double? screenWidth;
  static late double? screenHeight;
  static late double blockSizeHorizontal;
  static late double blockSizeVertical;

  // Init
  static void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData.size.width;
    screenHeight = _mediaQueryData.size.height;
    blockSizeHorizontal = screenWidth! / 100;
    blockSizeVertical = screenHeight! / 100;
    // print(
    //     "Width: $screenWidth\nHeight $screenHeight\nHorizontal $blockSizeHorizontal \nVertical $blockSizeVertical");
  }

  // Compute Scalefactor for height
  static double scaleHeight(double height) =>
      blockSizeVertical * ((height / screenHeight!) * 100);

  // Compute Scalefactor for Width
  static double scaleWidth(double width) =>
      blockSizeHorizontal * ((width / screenWidth!) * 100);
}

// Manage FB calls
class FirebaseManager {
  // Wrapper to login a valid User
  static Future<bool> login(
      {required String email, required String password}) async {
    try {
      // NOTE User vllt gegen Globalen User tauschen

      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      final User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        if (user.emailVerified) {
          return true;
        } else {
          print("Email is not verified");
          return false;
        }
      } else {
        print("Unexpected behavior. User is null");
        //TODO Handle case if user is null
        // NOte User kann eigentlich nicht 0 werden
      }
      // TODO snackback mit E-Mail Verifizierung?

    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        // Todo Alert Fehlermeldung
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        // Todo Alert Fehlermeldung
        print('Wrong password provided for that user.');
      }
    }
    return false;
  }

  // Logout
  static Future<bool> logout() async {
    await FirebaseAuth.instance.signOut();
    return FirebaseAuth.instance.currentUser == null;
  }

  // static create() async {
  //   final User? user = FirebaseAuth.instance.currentUser;
  //   await user?.sendEmailVerification();
  // }
}
