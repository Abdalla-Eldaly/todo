import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo_list/Database/model/User.dart' as MyUser;
import 'package:todo_list/Database/model/UserDou.dart';

class Authproviderr extends ChangeNotifier {
 MyUser.User? databaseuser;
 User? authfirebaseuser;

  Future<void> registerptov(
      String FullName, String username, String email, String password) async {
    var credential =
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    await UserDou.creatUser(MyUser.User(
        id: credential.user?.uid,
        Fullnamed: FullName,
        Username: username,
        email: email));
  }





  Future<void>Login(String email, String password) async {
    final credential = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
    var user = await UserDou.getUser(credential.user!.uid);
    databaseuser = user;
    authfirebaseuser = credential.user;
    notifyListeners();
  }

  void logout() {
    databaseuser = null;
     FirebaseAuth.instance.signOut();
  }

  bool isuserloginbefor() {
    return FirebaseAuth.instance.currentUser!=null;
  }

  Future<void> retriveuserfromdatabase()async {
   authfirebaseuser = FirebaseAuth.instance.currentUser;
   databaseuser =await UserDou.getUser(authfirebaseuser!.uid);
  }
}
