import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:village_under_siege/helpers/Widgets/custom_list_tile.dart';
class JoinRoom extends StatefulWidget {
  const JoinRoom({super.key});

  @override
  State<JoinRoom> createState() => _JoinRoomState();
}

class _JoinRoomState extends State<JoinRoom> {
  final TextEditingController roomIdTextEditingController = TextEditingController();

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
      child: CustomListTile(child: TextButton(onPressed: (){

      }, child: const Text('Join Game'))),
    ),
    
    );
  }
}

