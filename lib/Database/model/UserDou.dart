import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo_list/Database/model/User.dart';

class UserDou {
  static CollectionReference<User> getcollectoin([String? uid]) {
    var db = FirebaseFirestore.instance;
    var CollectionUser = db.collection(User.CollectionName).withConverter(
          fromFirestore: (snapshot, options) =>
              User.fromfirestore(snapshot.data()),
          toFirestore: (object, options) => object.tofirestore(),
        );
    return CollectionUser;
  }

  static Future<void> creatUser(User user) {
    var Usercollection = getcollectoin();
    var doc = Usercollection.doc(user.id);
    return doc.set(user);
  }

  static Future<User?> getUser(String uid) async{
    var doc = getcollectoin()
        .doc(uid);

    var docSnapshot = await doc.get();

    return docSnapshot.data();
  }
  static getallusertasks(String uid) async {
    var snapshotdoc = await getcollectoin(uid).get();
    var doc = await snapshotdoc.docs;
    doc.map((snapshot) => snapshot.data()).toList();
  }
}
