import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/Homepage/Home-Page.dart';
import 'package:todo_list/Login-Page/Login.dart';
import 'package:todo_list/Provider/Authprovider/Authprovider.dart';

class Splashscreen extends StatelessWidget {
  static String RouteName = 'Splash';
  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(seconds: 2), () {
      navigat(context);
    });
    return Scaffold(
      body: Center(child: Image.asset('assets/images/logo.png')),
    );
  }

  void navigat(BuildContext context) async {
    var provider = Provider.of<Authproviderr>(context, listen: false);
    if (provider.isuserloginbefor()) {
      await provider.retriveuserfromdatabase();
      Navigator.pushReplacementNamed(context, HomePage.RouteName);
    } else {
      Navigator.pushReplacementNamed(context, Login.RouteName);
    }
  }
}
