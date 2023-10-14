import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/DialogUtalites.dart';
import 'package:todo_list/Login-Page/Login.dart';
import 'package:todo_list/Provider/Authprovider/Authprovider.dart';

class Drawerlist extends StatelessWidget {
DialogShown messagestate = DialogShown();
  @override
  Widget build(BuildContext context) {
    var authprovider = Provider.of<Authproviderr>(context);
    return ListView(
      padding: EdgeInsets.zero,
      children: <Widget>[
        Container(
          width: double.infinity,
          height: 200,
          decoration: BoxDecoration(
            color: Color.fromRGBO(1, 97, 163, 1.0),
          ),
        ),

        ListTile(
          leading: Icon(Icons.logout,size: 40,), // Add an icon here
          title: Text('Log out',style: TextStyle(fontSize: 22,fontWeight: FontWeight.w600),),
          onTap: () {
            messagestate.Showmessage(context, message: 'Log out ? ',posActiontitle: 'Ok',negActiontitle: 'Cancel',posAction:
            (){
              authprovider.logout();
              Navigator.of(context).pushReplacementNamed(Login.RouteName);
            });

          },
        ),
        // Add more ListTiles for other menu items
      ],
    );
  }
}
