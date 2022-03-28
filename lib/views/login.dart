import 'package:example/services/constants.dart';
import 'package:example/services/services.dart';
import 'package:example/services/utility.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController _emailController =
      TextEditingController(text: "dqulmrmx@guerrillamail.info");
  TextEditingController _passwordController =
      TextEditingController(text: "1234567890");
  @override
  Widget build(BuildContext context) {
    final width = getWidth();
    final height = getHeight();
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(),
      body: Container(
          height: height,
          width: width,
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: width * 0.7,
                child: TextField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                ),
              ),
              Container(
                width: width * 0.7,
                child: TextField(
                  controller: _passwordController,
                  obscureText: true,
                ),
              ),
              ElevatedButton(
                  onPressed: () async {
                    final success = await FirebaseManager.login(
                        email: _emailController.text,
                        password: _passwordController.text);
                    if (success) {
                      Navigator.pushNamedAndRemoveUntil(
                          context, Routes.root, (route) => false);
                    }
                  },
                  child: Text("Login"))
            ],
          )),
    );
  }
}
