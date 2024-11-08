import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:village_under_siege/features/Game%20Screen/game_screen.dart';
import 'package:village_under_siege/helpers/Widgets/custom_list_tile.dart';

class RoleAssigning extends StatefulWidget {
  const RoleAssigning({super.key, required this.playersCount, required this.difficulty});
  final int playersCount;
  final int difficulty;
  @override
  State<RoleAssigning> createState() => _RoleAssigningState();
}

class _RoleAssigningState extends State<RoleAssigning> {
  List<String> _villagerRoles = [];
  List<String> _mafiaRoles = [];
  @override
  void initState() {
    setState(() {
      _villagerRoles = [];
      _mafiaRoles = [];
      _splitRoles(widget.playersCount);
    });
    super.initState();
  }
  void _splitRoles(int playerCount) {
    List<String> roles = [];

    // Base roles for 10 players
    roles.addAll([
      "Villager: Doctor",
      "Villager: Police",
      "Villager: Rambo",
      "Villager: Saint",
      "Villager: Lover",
      "Villager: Normal",
      "Mafia: Godfather",
      "Mafia: Lover",
      "Mafia: Normal",
      "Mafia: Normal"
    ]);

    int additionalPlayers = playerCount - 10;
    int additionalMafias = (additionalPlayers / 4).floor();
    int additionalVillagers = additionalPlayers - additionalMafias;

    // Add extra Mafia members
    for (int i = 0; i < additionalMafias; i++) {
      roles.add("Mafia: Normal");
    }

    // Add extra Villager roles
    for (int i = 0; i < additionalVillagers; i++) {
      roles.add("Villager: Normal");
    }

    // Shuffle roles for randomness
    roles.shuffle();

    // Split roles into Villagers and Mafia with Player IDs
    int playerId = 1;
    for (var role in roles) {
      if (role.startsWith("Villager")) {
        _villagerRoles.add("Player $playerId: ${role.replaceFirst("Villager: ", "")}");
      } else if (role.startsWith("Mafia")) {
        _mafiaRoles.add("Player $playerId: ${role.replaceFirst("Mafia: ", "")}");
      }
      playerId++;
    }

    Future.delayed(const Duration(seconds: 6), (){
      if (mounted) {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
          return const GameScreen();
        }));
      }
    });

  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Role Assigning'),
      ),
      bottomNavigationBar: const BottomAppBar(
        child: Center(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              CupertinoActivityIndicator(),
              SizedBox(width: 8,),
              Text('Loading Game ...'),
            ],
          ),
        ),
      ),
      body: Column(
        children: [
          ListTile(
            title: Text('Total Players: ${widget.playersCount}'),
          ),
           ListTile(title: Text('Villagers: ${_villagerRoles.length}'),),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(8.0),
              itemCount: _villagerRoles.length,
              itemBuilder: (context, index) {
                String currentRole = _villagerRoles[index].replaceFirst("Villager: ", "");
                return CustomListTile(
                  child: ListTile(
                    title: Text(currentRole),
                  ),
                );
              },
            ),
          ),
           ListTile(title: Text('Mafia\'s: ${_mafiaRoles.length}'),),

          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(8.0),
              itemCount: _mafiaRoles.length,
              itemBuilder: (context, index) {
                String currentRole = _mafiaRoles[index].replaceFirst("Mafia: ", "");

                return CustomListTile(
                  child: ListTile(
                    title: Text(currentRole),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}