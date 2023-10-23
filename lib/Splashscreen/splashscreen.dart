import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/Homepage/Home-Page.dart';
import 'package:todo_list/Login-Page/Login.dart';
import 'package:todo_list/Provider/Authprovider/Authprovider.dart';

class Splashscreen extends StatefulWidget {
  static const String RouteName = 'Splash';

  @override
  _SplashscreenState createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {
  @override
  void initState() {
    super.initState();
    // Delay for 2 seconds and then navigate
    Future.delayed(Duration(seconds: 2), () {
      navigat();
    });
  }

  void navigat() async {
    var provider = Provider.of<Authproviderr>(context, listen: false);

    if (provider.isuserloginbefor()) {
      await provider.retriveuserfromdatabase();
      Navigator.pushReplacementNamed(context, HomePage.RouteName);
    } else {
      Navigator.pushReplacementNamed(context, Login.RouteName);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset('assets/images/logo.png'),
      ),
    );
  }
}
