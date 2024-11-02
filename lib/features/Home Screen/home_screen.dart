import 'package:flutter/material.dart';
import 'package:village_under_siege/common.dart';
import 'package:village_under_siege/features/Home%20Screen/Screens/create_new_room.dart';
import 'package:village_under_siege/helpers/Widgets/custom_list_tile.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      body:  Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            createRoom(context),
            joinRoom(context),

          ],
        ),
      ),
    );
  }

  SizedBox joinRoom(BuildContext context) {
    return SizedBox(
            height: 100,
            width: MediaQuery.of(context).size.width,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: CustomListTile(
                child: TextButton(
                    style: const ButtonStyle(
                        shape: WidgetStatePropertyAll(BeveledRectangleBorder())
                    ),
                    onPressed: (){}, child: const Text('Join Room')),
              ),
            ),
          );
  }

  SizedBox createRoom(BuildContext context) {
    return SizedBox(
            height: 100,
            width: MediaQuery.of(context).size.width,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: CustomListTile(
                child: TextButton(
                    style: const ButtonStyle(
                      shape: WidgetStatePropertyAll(BeveledRectangleBorder())
                    ),
                    onPressed: (){
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                            return const CreateNewRoom(
                            );
                      }));
                    }, child: const Text('Create Room')),
              ),
            ),
          );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
     // backgroundColor: Theme.of(context).colorScheme.inversePrimary,

      leading:  Padding(
        padding: const EdgeInsets.all(8.0),
        child: IconButton(icon:const Icon( Icons.person), onPressed: () {  },),

      ),
      title: const Text(appName),
      actions: [
        IconButton(onPressed: (){
          showDialog<String>(
            context: context,
            builder: (BuildContext context) => Dialog(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      const Text(rules),
                      const SizedBox(height: 15),
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text('Close'),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        }, icon: const Icon(Icons.info))
      ],
    );
  }
}
