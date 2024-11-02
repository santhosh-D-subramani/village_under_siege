import 'package:flutter/material.dart';

class Utils{

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