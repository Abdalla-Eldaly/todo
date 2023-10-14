import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/Common/CommonTextFormField.dart';
import 'package:todo_list/Database/model/UserDou.dart';
import 'package:todo_list/DialogUtalites.dart';
import 'package:todo_list/Homepage/Home-Page.dart';
import 'package:todo_list/Provider/Authprovider/Authprovider.dart';
import 'package:todo_list/Register-Page/Register.dart';
import '../Register-Page/Isvalid.dart';

class Login extends StatefulWidget {
  static String RouteName = 'Login';

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController email =
      TextEditingController(text: 'abdalla@gmail.com');

  TextEditingController password = TextEditingController(text: 'Toot469@ab');

  DialogShown meassagestate = DialogShown();

  var FormKey = GlobalKey<FormState>();

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
                height: 300,
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
                obscuretext: true,
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                            15.0), // Adjust the value as needed
                      ),
                    ),
                  ),
                  onPressed: () {
                    Loginpress();
                  },
                  child: Row(
                    children: [
                      Expanded(
                        child: Align(
                          alignment: Alignment.center,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10.0),
                            child: Text(
                              'Login',
                              style: TextStyle(fontSize: 20),
                            ),
                          ),
                        ),
                      ),
                      Icon(Icons.arrow_forward, color: Colors.white),
                    ],
                  ),

              ),
              SizedBox(height: 30,),
              TextButton(
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, Register.RouteName);
                  },
                  child: Text('Creat account ?'))
            ],
          ),
        ),
      ),
    );
  }

  void Loginpress() async {
    if (FormKey.currentState!.validate() == false) {
      return;
    }
    var authprovider = Provider.of<Authproviderr>(context, listen: false);
    try {
      meassagestate.Showloading(context, 'loading...');
      await authprovider.Login(email.text, password.text);
      print(' dam!!');
      meassagestate.ShowHiding(context);
      print(' dam!!2');

      meassagestate.Showmessage(context,
          message: 'Login is Successfully',
          posActiontitle: 'OK', posAction: () {
        Navigator.pushReplacementNamed(context, HomePage.RouteName);
      });
    } on FirebaseAuthException catch (e) {
      meassagestate.ShowHiding(context);
      meassagestate.Showmessage(context,
          message: 'Email or Password Wrong \n try again',
          posActiontitle: 'OK');
      if (e.code == 'user-not-found' || e.code == 'wrong-password') {
        meassagestate.Showmessage(context,
            message: 'Email or Password Wrong \n try again',
            posActiontitle: 'OK');
      }
    }
  }
}
