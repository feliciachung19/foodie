import 'dart:developer';

import 'package:flutter/material.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  _SignupScreenState createState() => _SignupScreenState();
}

// Define a corresponding State class.
// This class holds the data related to the login screen.
class _SignupScreenState extends State<SignupScreen> {

  // Create a text controller and use it to retrieve the current value
  // of the email Field.
  final myEmailTextController = TextEditingController();
  // Create a text controller and use it to retrieve the current value
  // of the password Field.
  final myPasswordTextController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    myEmailTextController.dispose();
    myPasswordTextController.dispose();
    super.dispose();
  }

  Text buildTitleText(String blockName) {
    return Text(
      blockName,
      style: const TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
          fontFamily: 'Handlee',
          fontSize: 40),
      textAlign: TextAlign.left,
    );
  }

  @override
  build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildTitleText("Sign Up"),
          TextField(
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Email',
            ),
            controller: myEmailTextController,
          ),
          TextField(
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Password',
            ),
            controller: myPasswordTextController,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ElevatedButton(
                  onPressed: () {
                    log("Back button pressed");
                  },
                  child: const Text("Back"),
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12), // <-- Radius
                      ),
                      primary: Colors.black,
                      onPrimary: Colors.white
                  )
              ),
              ElevatedButton(
                  onPressed: () {
                    log("Sign Up button pressed");
                    log("Email: " + myEmailTextController.text);
                    log("Password: " + myPasswordTextController.text);
                  },
                  child: const Text("Next"),
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12), // <-- Radius
                      ),
                      primary: Colors.black,
                      onPrimary: Colors.white
                  )
              ),
            ],
          )
        ],
      ),
    );
  }
}