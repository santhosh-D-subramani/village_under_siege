import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:village_under_siege/features/Home%20Screen/Screens/controlllers/lobby_controller.dart';
import 'package:village_under_siege/helpers/Widgets/custom_list_tile.dart';

import '../../../helpers/utils.dart';
import '../../Game Screen/role_assigning.dart';

class LobbyScreen extends StatefulWidget {
  const LobbyScreen(
      {super.key,
      required this.roomID,
       this.difficulty,
     //  this.playerCount
      });
  final String roomID;
  // final int? playerCount;
  final int? difficulty;
  @override
  State<LobbyScreen> createState() => _LobbyScreenState();
}

class _LobbyScreenState extends State<LobbyScreen> {
  String userID = '';
  bool isCreator = false;
  int playerCount = 0;
  @override
  void initState() {
    if (FirebaseAuth.instance.currentUser != null) {
      setState(() {
        userID = FirebaseAuth.instance.currentUser?.uid ?? '';
      });
    }
    checkIsMod();
    super.initState();
  }

  void checkIsMod() async{
    String creatorId = await Utils.fetchOrganiser(widget.roomID) ?? '';
    int tempPlayerCount =  await Utils.fetchPlayerCount(widget.roomID) ?? 0;
     setState(() {
       playerCount = tempPlayerCount;
       isCreator = creatorId == userID;
     });

  }
  @override
  Widget build(BuildContext context) {
    final lobbyController = Get.put(LobbyController());
    final DatabaseReference roomRef =
    FirebaseDatabase.instance.ref().child('Rooms').child(widget.roomID);

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (bool didPop, Object? result) async{
        if (didPop) {
          return;
        }



        if (isCreator) {
          var  roomRef = FirebaseDatabase.instance
              .ref("Rooms");
          roomRef.remove()
              .then((_) => {
            log('Room deleted successfully.${widget.roomID}')
          });
        }
        if (context.mounted) {
          Navigator.pop(context);
        }
},
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Lobby'),
        ),
        bottomNavigationBar:isCreator? BottomAppBar(
            child: CustomListTile(
          child: TextButton(
              onPressed: () {

                ///TODO: change this to == in production
                if(lobbyController.playerCount.value == playerCount){
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return RoleAssigning(
                      playersCount: playerCount,
                      difficulty: widget.difficulty!,
                    );
                  }));
                }else{
                  Utils.showAlertPopUp(context, 'Room Not filled Yet', 'Wait for All players to join');
                }



              },
              child: const Text('Start Game')),
        )):null,
        body: Column(
          children: [
            CustomListTile(
                child: ListTile(
              title: TextField(controller: TextEditingController(text: 'Room Id: ${widget.roomID}'),),
              trailing: const Icon(Icons.share),
            )),
            ListTile(
              title: Obx(()=>Text('Players Joined: ${lobbyController.playerCount.value}/$playerCount')),
            ),
            Expanded(
              child: StreamBuilder(
                stream: roomRef.child('players').onValue,
                builder: (context,snapshot) {

             if (snapshot.connectionState == ConnectionState.waiting) {
               return const Center(child: CircularProgressIndicator());
             }

             if (snapshot.hasError) {
               return Center(child: Text('Error: ${snapshot.error}'));
             }

             if (!snapshot.hasData || snapshot.data!.snapshot.value == null) {
               return const Center(child: Text('No players found'));
             }

           final players = snapshot.data!.snapshot.value as List;

                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      lobbyController.playerCount.value = players.length;

                    });
             return GridView.builder(
                      itemCount: players.length,
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3),
                      itemBuilder: (context, index) {
                        final currentPlayer = players[index];
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              const SizedBox( height: 80,
                                width: 100,
                                child: CircleAvatar(
                                  child: Icon(Icons.person),
                                ),
                              ),
                              Text('$currentPlayer')
                            ],
                          ),
                        );
                      });
                }
              ),
            ),
          ],
        ),
      ),
    );
  }
}
