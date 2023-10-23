import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/Database/model/TaskDou.dart';
import 'package:todo_list/Provider/Authprovider/Authprovider.dart';
import 'package:todo_list/listtask/TaskWidget.dart';

class Listtask extends StatelessWidget {
  const Listtask({super.key});

  @override
  Widget build(BuildContext context) {
    var authprovider= Provider.of<Authproviderr>(context);
    return Column(
      children: [
        Expanded(
         child: StreamBuilder(
           stream: TaskDou.listentoTasks(authprovider.databaseuser?.id??""),
           builder: (context, snapshot) {
             if(snapshot.connectionState==ConnectionState.waiting){
               return Center(child: CircularProgressIndicator());
             }
             if(snapshot.hasError){
                Center(
                  child: Column(
                    children: [
                      Center(child: Text('Something is wrong\nPlease try again')),
                      ElevatedButton(onPressed: (){}, child: Text('Try again'))
                    ],
                  ),
                );

             }
             var taskList = snapshot.data?.docs.map((snapshot) => snapshot.data()).toList();
             return ListView.builder(itemBuilder:(context, index) {
               return TaskWidget(taskList![index]);
             },
             itemCount: taskList?.length??0);
           },
         ),
        ),
      ],
    );
  }
}
