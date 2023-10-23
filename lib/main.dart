import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/Homepage/Home-Page.dart';
import 'package:todo_list/Login-Page/Login.dart';
import 'package:todo_list/Provider/Authprovider/Authprovider.dart';
import 'package:todo_list/Register-Page/Register.dart';
import 'package:todo_list/Splashscreen/splashscreen.dart';

import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(ChangeNotifierProvider(
      create: (BuildContext) => Authproviderr(), child: const MyApp()));
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'To Do',
      theme: ThemeData(
        floatingActionButtonTheme:
            FloatingActionButtonThemeData(backgroundColor: Color(0xFe5D9CEC)),
        scaffoldBackgroundColor: Color(0xFFDEEBDA),
        colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.blue,
        primary:  Color(0xFe5D9CEC)),
        useMaterial3: false,
      ),
      routes: {
        Register.RouteName: (_) => Register(),
        Login.RouteName: (_) => Login(),
        HomePage.RouteName: (_) => HomePage(),
        Splashscreen.RouteName:(_)=>Splashscreen()
      },
      initialRoute: Splashscreen.RouteName,
    );
  }
}
