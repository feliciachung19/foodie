import 'dart:developer';
import 'package:flutter/material.dart';

import 'login_screen.dart';
import 'register_screen.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    BoxDecoration buildBackground() {
      return const BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/Food1a.jpg"),
          fit: BoxFit.cover,
        ),
      );
    }

    Text buildTitleText(String blockName) {
      return Text(
        blockName,
        style: const TextStyle(
            color: Color.fromRGBO(255, 255, 255, 1),
            fontWeight: FontWeight.bold,
            fontFamily: 'Handlee',
            fontSize: 50),
        textAlign: TextAlign.left,
      );
    }

    Text buildSubTitleText(String subText) {
      return Text(
        subText,
        style: const TextStyle(
            color: Color.fromRGBO(255, 255, 255, 1),
            fontWeight: FontWeight.normal,
            fontFamily: 'Handlee',
            fontSize: 25),
          textAlign: TextAlign.left,
      );
    }

    return Scaffold(
      body: Container(
        decoration: buildBackground(),
        child: ListView(
          children: [
            Container(
              padding: const EdgeInsets.all(75),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  buildTitleText("Eat."),
                  buildTitleText("Sleep."),
                  buildTitleText("Repeat."),
                  buildSubTitleText("The one and only meal prep and recipe app for busy students like us."),
                ],
              ),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                    onPressed: () {
                      log("Login button pressed");
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (context) => const LoginScreen()));
                    },
                    child: const Text("Login"),
                    style: ElevatedButton.styleFrom(
                      shape: const StadiumBorder(),
                      primary: const Color.fromRGBO(165, 207, 247, 1.0),
                      onPrimary: Colors.black
                    )
                ),
                ElevatedButton(
                    onPressed: () {
                      log("Sign Up button pressed");
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (context) => const RegisterScreen()));
                    },
                    child: const Text("Sign Up"),
                    style: ElevatedButton.styleFrom(
                        shape: const StadiumBorder(),
                        primary: const Color.fromRGBO(6, 32, 69, 1.0),
                        onPrimary: Colors.white
                    )
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
