import 'package:cloud_firestore/cloud_firestore.dart';

class Task {
  static String CollectionName = 'tasks';
  String? id;
  String? title;
  String? description;
  Timestamp? datatime;
  bool? isdone;
  Task(
      {this.id,
      this.description,
      this.datatime,
      this.title,
      this.isdone = false});


  Task.fromfirestore(Map<String, dynamic>? data)
      : this(
      id: data?['id'],
      title: data?['title'],
      description: data?['description'],
      datatime: data?['datatime'],
      isdone: data?['isdone']
  );

  Map<String, dynamic> tofirestore() {
    return {
      "id": id,
      "title": title,
      "description": description,
      "datatime": datatime,
      "isdone": isdone,
    };
  }
}
