import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/Common/CommonTextFormField.dart';
import 'package:todo_list/Database/model/User.dart' as MyUser;
import 'package:todo_list/Database/model/UserDou.dart';
import 'package:todo_list/DialogUtalites.dart';
import 'package:todo_list/Login-Page/Login.dart';
import 'package:todo_list/Provider/Authprovider/Authprovider.dart';

import 'Isvalid.dart';

class Register extends StatefulWidget {
  static String RouteName = 'Register';

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  TextEditingController FullName =
      TextEditingController(text: 'abdalla eldaly');

  TextEditingController username = TextEditingController(text: 'abdalledaly');

  TextEditingController email =
      TextEditingController(text: 'abdalla@gmail.com');

  TextEditingController password = TextEditingController(text: 'Toot469@ab');

  TextEditingController passwordcomfirmation =
      TextEditingController(text: 'Toot469@ab');

  DialogShown messagestate = DialogShown();

  var FormKey = GlobalKey<FormState>();
  bool passwordVisible = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14),
        decoration: const BoxDecoration(
            color: Colors.white,
            image: DecorationImage(
              image: AssetImage('assets/images/bg.png'),
              fit: BoxFit.fill,
            )),
        child: Form(
          key: FormKey,
          child: ListView(
            children: [
              const SizedBox(
                height: 225,
              ),
              CommonTextFormField(
                Validator: (text) {
                  if (text == null || text.trim().isEmpty) {
                    return 'please enter the Full Name';
                  }
                  return null;
                },
                controller: FullName,
                labeltext: 'FullName',
                prefixIcon: Icons.person_pin_rounded,
                keyboardtype: TextInputType.name,
                obscuretext: false,
              ),
              CommonTextFormField(
                Validator: (text) {
                  if (text == null || text.trim().isEmpty) {
                    return 'please enter the username';
                  }
                  return null;
                },
                controller: username,
                labeltext: 'UserName',
                prefixIcon: Icons.person,
                keyboardtype: TextInputType.text,
                obscuretext: false,
              ),
              CommonTextFormField(
                Validator: (text) {
                  if (text == null || text.trim().isEmpty) {
                    return 'please enter the email';
                  }
                  if (!InvalidEmail(text)) {
                    return 'please enter valid email';
                  }
                  return null;
                },
                controller: email,
                labeltext: 'Email',
                prefixIcon: Icons.email_rounded,
                keyboardtype: TextInputType.emailAddress,
                obscuretext: false,
              ),
              CommonTextFormField(
                Validator: (text) {
                  if (text == null || text.trim().isEmpty) {
                    return 'please enter Password';
                  }
                  if (!InvalidPassword(text)) {
                    return 'Enter Strong Password';
                  }
                  return null;
                },
                controller: password,
                labeltext: 'Password',

                keyboardtype: TextInputType.text,
                prefixIcon: Icons.lock_person_rounded,
                obscuretext: true,
              ),
              CommonTextFormField(

                Validator: (text) {
                  if (password.text != passwordcomfirmation.text) {
                    return 'enter the same Password';
                  }
                  return null;
                },
                controller: passwordcomfirmation,
                labeltext: 'Password comfirmation',
                togglePasswordVisibility: true, // Specify whether to display the toggle button
                togglePasswordCallback: (isVisible) {
                  setState(() {
                    passwordVisible = isVisible;
                  });
                },
                keyboardtype: TextInputType.text,
                obscuretext: true,
                prefixIcon: Icons.lock_outlined,
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    child: Text('Creat Account',style: TextStyle(fontSize: 20),),
                  ),
                  onPressed: () {
                    CreatAccount();

                  },
                style: ButtonStyle(
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0), // Adjust the value as needed
                    ),
                  ),
                ),
                  ),
              SizedBox(
                height: 10,
              ),
              TextButton(
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, Login.RouteName);
                  },
                  child: Text('You have account already ?'))
            ],
          ),
        ),
      ),
    );
  }

  void CreatAccount() async {
    if (FormKey.currentState!.validate() == false) {
      return;
    }
    var authprovider = Provider.of<Authproviderr>(context, listen: false);
    try {
      messagestate.Showloading(context, 'loading...', iscancel: false);
      await authprovider.registerptov(
          FullName.text, username.text, email.text, password.text);

      // messagestate.ShowHiding(context);
      messagestate.Showmessage(context,
          message: 'Registered Succseefully',
          posActiontitle: 'Ok',
          negActiontitle: 'Cancel', posAction: () {
        Navigator.pushReplacementNamed(context, Login.RouteName);
      });
    } on FirebaseAuthException catch (e) {
      messagestate.ShowHiding(context);

      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        messagestate.Showmessage(context,
            message: 'The account already exists for that email.',
            posActiontitle: 'OK');
        print('The account already exists for that email.1');
      }
    } catch (e) {
      messagestate.Showmessageerror(context, 'Something went wrong');
      print(e);
    }
  }
}
