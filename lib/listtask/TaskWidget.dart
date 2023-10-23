import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/Database/model/Task.dart';
import 'package:todo_list/Database/model/TaskDou.dart';

import 'package:todo_list/DialogUtalites.dart';
import 'package:todo_list/Provider/Authprovider/Authprovider.dart';

class TaskWidget extends StatefulWidget {
  Task task;
  TaskWidget(this.task);

  @override
  State<TaskWidget> createState() => _TaskWidgetState();
}

class _TaskWidgetState extends State<TaskWidget> {
  @override
  Widget build(BuildContext context) {
    return Slidable(
      startActionPane: ActionPane(
        children: [
          SlidableAction(
            onPressed: (context) {
              deletTask();
            },
            icon: Icons.delete,
            backgroundColor: Colors.red,
            label: "Delete",
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(14),
            bottomLeft: Radius.circular(14),
          ),
          )
        ],
        motion: StretchMotion(),
      ),
      child: Container(
        padding: EdgeInsets.all(8),
        margin: EdgeInsets.symmetric(vertical: 8, horizontal: 24),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(14)),
            color: Colors.white),
        child: Row(
          children: [
            Container(
              width: 4,
              height: 64,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(18)),
                  color: Theme.of(context).primaryColor),
            ),
            Expanded(
                child: Container(
              padding: EdgeInsets.symmetric(horizontal: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.task.title ?? "Firebase",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).primaryColor),
                  ),
                  Text(widget.task.description ?? "firestore",
                      style:
                          TextStyle(fontSize: 13, fontWeight: FontWeight.bold))
                ],
              ),
            )),
            Container(
              width: 69,
              height: 34,
              child: Stack(
                children: [
                  Positioned(
                    left: 0,
                    top: 0,
                    child: Container(
                      width: 69,
                      height: 34,
                      decoration: ShapeDecoration(
                        color: Color(0xFF5D9CEC),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.center,
                    // Adjust the top position for the icon
                    child: Icon(
                      Icons.check, // Replace with the icon you want
                      color: Colors.white, // Icon color
                      size: 35, // Icon size
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  DialogShown messagestate = DialogShown();

  void deletTask(){
    messagestate.Showmessage(context, message: 'Are you sure to delete this task?',posActiontitle: "OK",negActiontitle:"Cancel",posAction: (){
      deletTaskFromFirestore();
    });

  }

 void deletTaskFromFirestore()async{
    var authprovider =Provider.of<Authproviderr>(context,listen: false);

    await TaskDou.removeTask(widget.task!.id!,authprovider.databaseuser!.id!);
 }
}
