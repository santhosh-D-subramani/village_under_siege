
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:village_under_siege/features/Login/login_screen.dart';
import 'package:village_under_siege/helpers/Widgets/custom_list_tile.dart';
class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String email = '';
  @override
  void initState() {
    if (FirebaseAuth.instance.currentUser != null) {
     setState(() {
       email = FirebaseAuth.instance.currentUser?.email ?? '';
     });
    }
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: Column(
        children: [
          CustomListTile(child: ListTile(
            title: Text(email),
            trailing: IconButton(onPressed: (){
              if (FirebaseAuth.instance.currentUser != null) {

                FirebaseAuth.instance.signOut();
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) {
                          return const LoginScreen();
                    }));
                  }
            }, icon: const Icon(Icons.output_rounded)),
          ))
        ],
      ),
    );
  }
}
