import 'package:example/services/services.dart';
import 'package:flutter/material.dart';

// Loading Screen
Widget loadingScreen() => const Center(
      child: CircularProgressIndicator(),
    );

// Error Screen
Widget errorScreen() => const Center(
      child: Text("There was an error"),
    );

// Wrapper for Phone height
double getHeight() => SizeConfig.screenHeight!;
// Wrapper for Phone Width
double getWidth() => SizeConfig.screenWidth!;
