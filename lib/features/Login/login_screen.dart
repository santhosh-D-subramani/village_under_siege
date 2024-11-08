import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:particles_flutter/component/particle/particle.dart';
import 'package:particles_flutter/particles_engine.dart';
import 'package:village_under_siege/common.dart';
import 'package:village_under_siege/helpers/Widgets/custom_list_tile.dart';
import 'package:village_under_siege/helpers/Widgets/particle_widget.dart';

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
  var acs = ActionCodeSettings(
    // URL you want to redirect back to. The domain (www.example.com) for this
    ///TODO: URL must be whitelisted in the Firebase Console.
    ///maybe try with github pages.io thing
      url: 'https://www.example.com/finishSignUp?cartId=1234',
      // This must be true
      handleCodeInApp: true,
      iOSBundleId: 'com.l2c.village_under_siege',
      androidPackageName: 'com.l2c.village_under_siege',
      // installIfNotAvailable
      androidInstallApp: true,
      // minimumVersion
      androidMinimumVersion: '21');
  @override
  void dispose() {
    emailTextEditingController.dispose();
    passwordTextEditingController.dispose();
    super.dispose();
  }

  void loginUser(){
    if (_formKey.currentState?.validate() == true) {

      FirebaseAuth.instance.sendSignInLinkToEmail(
          email: emailTextEditingController.text, actionCodeSettings: acs)
          .catchError((onError) => print('Error sending email verification $onError'))
          .then((value) => print('Successfully sent email verification'));

      // If the form is valid, display a snack-bar or take action
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Valid email!')),
      );
    }
  }
  void createAccount(){

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
            //  const ParticleWidget(),
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
                          RichText(
                            textAlign: TextAlign.center,
                            text: const TextSpan(
                              children: [
                                WidgetSpan(
                                  child: Icon(Icons.lock, size: 14),
                                ),
                                TextSpan(
                                  text: ' Secure Password less Sign-in ',
                                  style: TextStyle( fontSize: 14),
                                ),
                              ],
                            ),
                          ),

                          // CustomListTile(
                          //   needConstraints: false,
                          //   child: Padding(
                          //     padding: const EdgeInsets.all(8.0),
                          //     child: TextFormField(
                          //
                          //       controller: passwordTextEditingController,
                          //       decoration: const InputDecoration(
                          //           border: InputBorder.none,
                          //           icon: Icon(Icons.password),
                          //           labelText: 'Password'),
                          //     ),
                          //   ),
                          // ),
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
                          ),
                          const Center(child: Text('Or Login with')),
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              CustomListTile(
                                child: TextButton.icon(
                                    style: const ButtonStyle(
                                        shape: WidgetStatePropertyAll(
                                            BeveledRectangleBorder())),
                                    onPressed: () {},
                                    icon: const Icon(Icons.ac_unit),
                                    label: const Text('Google Sign-In')),
                              ),
                            ],
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

