import 'package:flutter/material.dart';
import 'package:village_under_siege/helpers/Widgets/custom_list_tile.dart';

import '../../Game Screen/role_assigning.dart';

class LobbyScreen extends StatefulWidget {
  const LobbyScreen(
      {super.key,
      required this.roomID,
      required this.difficulty,
      required this.playerCount});
  final String roomID;
  final int playerCount;
  final int difficulty;
  @override
  State<LobbyScreen> createState() => _LobbyScreenState();
}

class _LobbyScreenState extends State<LobbyScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lobby'),
      ),
      bottomNavigationBar: BottomAppBar(
          child: CustomListTile(
        child: TextButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return RoleAssigning(
                  playersCount: widget.playerCount,
                  difficulty: widget.difficulty,
                );
              }));
            },
            child: const Text('Start Game')),
      )),
      body: Column(
        children: [
          CustomListTile(
              child: ListTile(
            title: Text('Room Id: ${widget.roomID}'),
            trailing: const Icon(Icons.share),
          )),
          ListTile(
            title: Text('Players Joined: ${widget.playerCount}'),
          ),
          Expanded(
            child: GridView.builder(
                itemCount: widget.playerCount,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3),
                itemBuilder: (context, index) {
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
                        Text('${index+1}')
                      ],
                    ),
                  );
                }),
          ),
        ],
      ),
    );
  }
}
