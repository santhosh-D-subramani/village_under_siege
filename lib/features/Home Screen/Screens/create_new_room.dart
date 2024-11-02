import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:village_under_siege/features/Home%20Screen/Screens/lobby_screen.dart';
import 'package:village_under_siege/helpers/Widgets/custom_list_tile.dart';
import 'package:village_under_siege/helpers/utils.dart';

class CreateNewRoom extends StatefulWidget {
  const CreateNewRoom({super.key});

  @override
  State<CreateNewRoom> createState() => _CreateNewRoomState();
}

class _CreateNewRoomState extends State<CreateNewRoom> {
  final _playersCountTextEditingController = TextEditingController();
  int _selectedValue = 1;

  @override
  void initState() {
_playersCountTextEditingController.text = '10';
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      bottomNavigationBar: buildBottomAppBar(context),
      body: Column(
        children: [
          playersCountTextField(),
          easyMode(),
          hardMode(),
        ],
      ),
    );
  }
  BottomAppBar buildBottomAppBar(BuildContext context)  {
    return BottomAppBar(
        child: CustomListTile(
          child: TextButton(
              onPressed: () {
                var uuid = const Uuid();
                var id = uuid.v4();
                if(_playersCountTextEditingController.text.isEmpty){
                  Utils.showAlertPopUp(context, 'No Players',
                      ' 0 Players To start a game');
                  return;

                }
                int playerCount =
                int.parse(_playersCountTextEditingController.text);

                if (playerCount < 10){
                  Utils.showAlertPopUp(context, "Not enough Players",
                      "- You need minimum of 10 Players");
                  return;
                }

                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return LobbyScreen(
                    roomID: id,
                    difficulty: _selectedValue, playerCount: playerCount,
                  );
                }));
              },
              child: const Text('Create Room')),
        ));
  }
  RadioListTile<int> hardMode() {
    return RadioListTile(
          title: const Text('Hard'), // Display the title for option 1
          subtitle: const Text(
              'player innocence is not  notified'), // Display a subtitle for option 1
          value: 0, // Assign a value of 1 to this option
          groupValue:
              _selectedValue, // Use _selectedValue to track the selected option
          onChanged: (value) {
            setState(() {
              _selectedValue =
                  value!; // Update _selectedValue when option 1 is selected
            });
          },
        );
  }

  RadioListTile<int> easyMode() {
    return RadioListTile(
          title: const Text('Easy'), // Display the title for option 1
          subtitle: const Text(
              'after a player dies all users notified of player innocent / guilty'), // Display a subtitle for option 1
          value: 1, // Assign a value of 1 to this option
          groupValue:
              _selectedValue, // Use _selectedValue to track the selected option
          onChanged: (value) {
            setState(() {
              _selectedValue =
                  value!; // Update _selectedValue when option 1 is selected
            });
          },
        );
  }

  Padding playersCountTextField() {
    return Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            controller: _playersCountTextEditingController,
            decoration: const InputDecoration(
                labelText: 'Players Count', helperText: 'Minimum 10 players'),
            keyboardType: TextInputType.number,
          ),
        );
  }

  AppBar buildAppBar() {
    return AppBar(
      title: const Text('Create New Room'),
    );
  }


}
