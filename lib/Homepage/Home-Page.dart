import 'package:flutter/material.dart';
import 'package:todo_list/Homepage/showsheet.dart';
import 'package:todo_list/Listtab/listtab.dart';
import 'package:todo_list/settingtab/settingtab.dart';

import 'Drawerlist.dart';

class HomePage extends StatefulWidget {
static String RouteName='homepage';

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: tabs[selectindex],
      appBar: AppBar(
        toolbarHeight: 100,
        title: Text('To Do'),

      ),
        drawer: Drawer(
          child: Drawerlist(),
        ),
floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
floatingActionButton: FloatingActionButton(

  shape: StadiumBorder(side: BorderSide(color: Colors.white, width: 4)),
  onPressed: () {
    Showmodalbottomsheet();
  },
  child: Icon(Icons.add),
),
        bottomNavigationBar: BottomAppBar(
          shape: CircularNotchedRectangle(),
          notchMargin: 8,
          child: BottomNavigationBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            onTap: (index) {
              setState(() {
                selectindex = index;
              });
            },
            currentIndex: selectindex,
            items: const [
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.list,
                    size: 33,
                  ),
                  label: ''),
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.settings,
                    size: 33,
                  ),
                  label: ''),
            ],
          ),
        ));



  }

  int selectindex=0;

  List<Widget>tabs=[listtab(),settingtab()];

  Showmodalbottomsheet(){
    showModalBottomSheet(context: context, builder: (builder)=>showsheet());
  }
}


