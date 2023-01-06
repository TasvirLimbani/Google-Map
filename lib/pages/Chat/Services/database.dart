import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final String? uid;

  DatabaseService({this.uid});
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  final CollectionReference chatCollection =
      FirebaseFirestore.instance.collection("chats");

  Future updateUserData(
      {required String name, required String password}) async {
    return await chatCollection
        .doc(uid)
        .set({'email': name, 'password': password});
  }

  Stream<QuerySnapshot> get chats {
    return chatCollection.snapshots();
  }
}
