import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:village_under_siege/common.dart';
import 'package:village_under_siege/features/Home%20Screen/home_screen.dart';
import 'package:village_under_siege/helpers/Widgets/custom_list_tile.dart';
import 'package:firebase_database/firebase_database.dart';
import '../../helpers/Widgets/particle_widget.dart';
import '../../helpers/utils.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController emailTextEditingController =
      TextEditingController();
  final TextEditingController passwordTextEditingController =
      TextEditingController();

  @override
  void initState() {

    User? user = FirebaseAuth.instance.currentUser;
    if(user != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
          return const HomeScreen();
        }));
      });

    }
    super.initState();
  }

  @override
  void dispose() {
    emailTextEditingController.dispose();
    passwordTextEditingController.dispose();
    super.dispose();
  }

  void loginUser() async {
    if (_formKey.currentState?.validate() == true) {
      try {
        final userCredential =
            await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailTextEditingController.text,
          password: passwordTextEditingController.text,
        );

        if (userCredential.user != null) {
          // Login successful, navigate to the home page
          if (mounted) {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => const HomeScreen()),
            );
          }
        }
      } catch (e) {
        // Handle login errors
        if (kDebugMode) {
          print('Error: $e');
        }
      }
    }
  }

  Future<void> createAccount() async {
    print(' createAccount()');
    try {
      final userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailTextEditingController.text,
        password: passwordTextEditingController.text,
      );

    print(userCredential);
    print(emailTextEditingController.text);
    print(passwordTextEditingController.text);
    DatabaseReference userRef = FirebaseDatabase.instance
        .ref()
        .child("Users")
        .child(userCredential.user!.uid);
    Map<String, dynamic> userData = {
      'email': emailTextEditingController.text.toString(),
      'uid': userCredential.user!.uid,
    };
    userRef.set(userData);
      if (mounted) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const HomeScreen()),
        );
      }
    } on Exception catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //   appBar: AppBar(),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Stack(
            children: [
             //const ParticleWidget(),
              Center(
                child: CustomListTile(
                  color: getDefaultColor(context, true),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Text(appName, style: TextStyle(fontSize: 22)),
                          const SizedBox(
                            height: 10,
                          ),
                          CustomListTile(
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  top: 8.0, right: 8, left: 8, bottom: 10),
                              child: TextFormField(
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter an email';
                                  } else if (!Utils.isValidEmail(value)) {
                                    return 'Please enter a valid email';
                                  }
                                  return null;
                                },
                                controller: emailTextEditingController,
                                decoration: const InputDecoration(
                                    border: InputBorder.none,
                                    icon: Icon(Icons.email_rounded),
                                    labelText: 'Email ID'),
                              ),
                            ),
                          ),
                          // RichText(
                          //   textAlign: TextAlign.center,
                          //   text: const TextSpan(
                          //     children: [
                          //       WidgetSpan(
                          //         child: Icon(Icons.lock, size: 14),
                          //       ),
                          //       TextSpan(
                          //         text: ' Secure Password less Sign-in ',
                          //         style: TextStyle( fontSize: 14),
                          //       ),
                          //     ],
                          //   ),
                          // ),

                          CustomListTile(
                            needConstraints: false,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextFormField(
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter an Password';
                                  }
                                  return null;
                                },
                                controller: passwordTextEditingController,
                                decoration: const InputDecoration(

                                    border: InputBorder.none,
                                    icon: Icon(Icons.password),
                                    labelText: 'Password'),
                              ),
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width,
                            constraints: const BoxConstraints(
                                minHeight: 60, maxHeight: 100),
                            child: CustomListTile(
                                child: TextButton(
                              style: const ButtonStyle(
                                  shape: WidgetStatePropertyAll(
                                      BeveledRectangleBorder())),
                              onPressed: loginUser,
                              child: const Text('Login'),
                            )),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width,
                            constraints: const BoxConstraints(
                                minHeight: 60, maxHeight: 100),
                            child: CustomListTile(
                              color: Colors.transparent,
                              child: TextButton(
                                style: const ButtonStyle(
                                  side: WidgetStatePropertyAll(BorderSide(
                                      color: Colors.black,
                                      style: BorderStyle.solid)),
                                ),
                                onPressed: createAccount,
                                child: const Text('Create Account'),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                            // ),
                            // const Center(child: Text('Or Login with')),
                            // const SizedBox(
                            //   height: 20,
                            // ),
                            // Row(
                            //   mainAxisSize: MainAxisSize.min,
                            //   children: [
                            //     CustomListTile(
                            //       child: TextButton.icon(
                            //           style: const ButtonStyle(
                            //               shape: WidgetStatePropertyAll(
                            //                   BeveledRectangleBorder())),
                            //           onPressed: () {},
                            //           icon: const Icon(Icons.ac_unit),
                            //           label: const Text('Google Sign-In')),
                            //     ),
                            //   ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
