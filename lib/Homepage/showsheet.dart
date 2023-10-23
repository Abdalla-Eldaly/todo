import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/Common/CommonTextFormField.dart';
import 'package:todo_list/Database/model/Task.dart';
import 'package:todo_list/Database/model/TaskDou.dart';
import 'package:todo_list/DialogUtalites.dart';
import 'package:todo_list/Provider/Authprovider/Authprovider.dart';
import 'package:firebase_auth/firebase_auth.dart';

class showsheet extends StatefulWidget {
  @override
  State<showsheet> createState() => _showsheetState();
}

class _showsheetState extends State<showsheet> {
  TextEditingController title = TextEditingController();
  TextEditingController description = TextEditingController();
  DialogShown messagestate = DialogShown();
  var FormKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Form(
        key: FormKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: ListView(
            children: [
              Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Center(
                        child: Text(
                      'Add Task',
                      style: TextStyle(fontSize: 30),
                    )),
                    CommonTextFormField(
                      labeltext: 'Title',
                      obscuretext: false,
                      controller: title,
                      Validator: (text) {
                        if (text == null || text!.trim().isEmpty) {
                          return 'Write your task';
                        }
                      },
                    ),
                    CommonTextFormField(
                      obscuretext: false,
                      labeltext: 'Description',
                      Lines: 3,
                      controller: description,
                      Validator: (text) {
                        if (text == null || text!.trim().isEmpty) {
                          return 'Write your task';
                        }
                      },
                    ),
                    InkWell(
                        onTap: () {
                          showdatapicker();
                        },
                        child: Container(
                            padding: EdgeInsets.symmetric(vertical: 10),
                            decoration: BoxDecoration(
                                border: Border.symmetric(
                                    horizontal:
                                        BorderSide(color: Colors.grey))),
                            child: Text(selecteddata == null
                                ? 'Data'
                                : '${selecteddata?.day} / ${selecteddata?.month} / ${selecteddata?.year}'))),
                    Visibility(
                        visible: Showmessageerror,
                        child: Text(
                          'Please add Data for the Task',
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: Colors.red),
                        )),
                    SizedBox(
                      height: 10,
                    ),
                    ElevatedButton(
                        style: ButtonStyle(
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                  15.0), // Adjust the value as needed
                            ),
                          ),
                        ),
                        onPressed: () {
                          Addtask();
                        },
                        child: const Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10.0),
                          child: Text(
                            'Add Task',
                            style: TextStyle(fontSize: 18),
                          ),
                        ))
                  ])
            ],
          ),
        ),
      ),
    );
  }

  bool Showmessageerror = false;
  isvalid() {
    bool notvalid = true;
    if (FormKey.currentState?.validate() == false) {
      notvalid = false;
    }
    if (selecteddata == null) {
      notvalid = false;
      setState(() {
        Showmessageerror = true;
      });
    }
    return notvalid;
  }

  TaskDou taskDou = TaskDou();

  Addtask() async {
    if (!isvalid()) return;
    var authprovider = Provider.of<Authproviderr>(context, listen: false);

    Task task = Task(
      title: title.text,
      description: description.text,
      datatime: Timestamp.fromMillisecondsSinceEpoch(
          selecteddata!.millisecondsSinceEpoch),
    );

    messagestate.Showloading(context, 'Creating Task...');

    await TaskDou.creattask(task, authprovider.databaseuser!.id!);
    messagestate.ShowHiding(context);
    messagestate.Showmessage(context,
        message: 'Task created Successfully',
        posActiontitle: 'OK', posAction: () {
      Navigator.pop(context);
    });
  }

  DateTime? selecteddata;
  showdatapicker() async {
    var data = await showDatePicker(
        context: context,
        initialDate: selecteddata ?? DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(Duration(days: 365)));
    setState(() {
      selecteddata = data;
      if (selecteddata != null) {
        Showmessageerror = false;
      }
    });
  }
}
