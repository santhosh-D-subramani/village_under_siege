import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:village_under_siege/features/Home%20Screen/Screens/lobby_screen.dart';
import 'package:village_under_siege/helpers/Widgets/custom_list_tile.dart';
import 'package:village_under_siege/helpers/utils.dart';
class JoinRoom extends StatefulWidget {
  const JoinRoom({super.key});

  @override
  State<JoinRoom> createState() => _JoinRoomState();
}

class _JoinRoomState extends State<JoinRoom> {
  final TextEditingController roomIdTextEditingController = TextEditingController();
  late  DatabaseReference roomRef;

  String email = '';

  @override
  void initState() {
    if (FirebaseAuth.instance.currentUser != null) {
      setState(() {
        email =   FirebaseAuth.instance.currentUser?.email ?? '';
      });
      print(email);
    }
      roomIdTextEditingController.text = '-OBFSIVNWNw2ph_brdon';
      roomRef = FirebaseDatabase.instance
          .ref("Rooms/${roomIdTextEditingController.text}");
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
    appBar: AppBar(title: const Text('Join Room'),),
    body: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
       const SizedBox(height: 50,),
        CustomListTile(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              autofocus: true,
              controller: roomIdTextEditingController,
              decoration: const InputDecoration(labelText: 'Room Id',helperText: 'If you don\'t have one? Go-back and\n create new one for your friends'),
            ),
          ),
        )
      ],
    ),
    bottomNavigationBar: BottomAppBar(
      child: CustomListTile(
          child: TextButton(
          onPressed: () async{
            final DatabaseReference roomRef = FirebaseDatabase.instance.ref("Rooms/${roomIdTextEditingController.text}");

            // Check if the room ID exists
            final DataSnapshot roomSnapshot = await roomRef.get();
            if (roomSnapshot.exists) {
              final data = roomSnapshot.value as Map<dynamic, dynamic>?;

              if (data != null) {
                final int playerCount = data['playerCount'] ?? 0;
                print('playerCount : $playerCount');
                final List<dynamic> players = data['players']?.toList() ?? [];
                print('players: $players');
                if (playerCount > players.length) {

                  if (!players.contains(Utils.trimGmail(email))) {
                    players.add(Utils.trimGmail(email));
                    await roomRef.child("players").set(players); // Update the entire list
                    print("Player added to the room.");
                  } else {
                    print("Player is already in the room.");
                  }

               //   Utils.addPlayerToRoom(roomIdTextEditingController.text, email);
                  // if (email.isNotEmpty) {
                  //   roomRef.set({
                  //     'players': {Utils.trimGmail(email)},
                  //   });
                  // }
                        if (context.mounted) {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                                return LobbyScreen(roomID: roomIdTextEditingController.text,);
                          }));
                        }
                      } else {
                  if (context.mounted) {
                    Utils.showAlertPopUp(context, 'Room Full', 'Room is Full Try again later/ join different room');
                  }
                  print("Player count is equal to or greater than the number of players in the room.");


                }
              }
            } else {
              if (context.mounted) {
                Utils.showAlertPopUp(context, 'Room ID does not exist', 'content');
              }
            }

                  // Navigator.push(context, MaterialPageRoute(builder: (context) {
                  //   return ;
                  // }));
                }, child: const Text('Join Game'))),
    ),
    
    );
  }
}

