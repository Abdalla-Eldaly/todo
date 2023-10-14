import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo_list/Database/model/Task.dart';
import 'package:todo_list/Database/model/UserDou.dart';

class TaskDou {
 static  CollectionReference<Task>getcollection(String uid) {
     return UserDou.getcollectoin()
        .doc(uid)
        .collection(Task.CollectionName)
        .withConverter(
          fromFirestore: (snapshot, options) =>
              Task.fromfirestore(snapshot.data()),
          toFirestore: (task, options) => task.tofirestore(),
        );
  }

  static Future <void> creattask(Task task,String uid) {
       var refdoc = getcollection(uid).doc();
      task.id =refdoc.id;
      return refdoc.set(task);
  }
}
