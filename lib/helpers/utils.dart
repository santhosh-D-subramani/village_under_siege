import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class Utils {
static bool isValidEmail(String email) {
  final emailRegex = RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$");
  return emailRegex.hasMatch(email);
}

static Future<int?> fetchPlayerCount(String roomId) async{
  final DatabaseReference dbRef = FirebaseDatabase.instance.ref("Rooms/$roomId/playerCount");
  try {
    final DataSnapshot snapshot = await dbRef.get();
    if (snapshot.exists) {
      return snapshot.value as int;
    } else {
      print("playerCount not found for room: $roomId");
      return null;
    }
  } catch (e) {
    print("Error fetching organiser: $e");
    return null;
  }

}

static Future<String?> fetchOrganiser(String roomId) async {
  final DatabaseReference dbRef = FirebaseDatabase.instance.ref("Rooms/$roomId/organiser");

  try {
    final DataSnapshot snapshot = await dbRef.get();
    if (snapshot.exists) {
      return snapshot.value as String;
    } else {
      print("Organiser not found for room: $roomId");
      return null;
    }
  } catch (e) {
    print("Error fetching organiser: $e");
    return null;
  }
}

// static  Future<void> addPlayerToRoom(String roomId, String newPlayerEmail) async {
//   final DatabaseReference playersRef = FirebaseDatabase.instance.ref("Rooms/$roomId/players");
//  // playersRef.push().key!:
//   playersRef.update({playersRef.push().Utils.trimGmail(newPlayerEmail.trim())});
// }
static String? getEmail() {
  if (FirebaseAuth.instance.currentUser != null) {
     return FirebaseAuth.instance.currentUser?.email;
  }
  return null;
}
static String? getUid() {
  if (FirebaseAuth.instance.currentUser != null) {
     return FirebaseAuth.instance.currentUser?.uid;
  }
  return null;
}


static String trimGmail(String email) {
  return email.replaceAll('@gmail.com', '');
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