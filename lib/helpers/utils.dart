import 'package:flutter/material.dart';

class Utils{
static bool isValidEmail(String email) {
  final emailRegex = RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$");
  return emailRegex.hasMatch(email);
}

static showAlertPopUp(BuildContext context, String alertTitle,String content) {
    return   showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title:  Text(alertTitle),
        content:  Text(content),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(ctx).pop();
            },
            child: const Text("Okay"),
          ),
        ],
      ),
    );

  }
}