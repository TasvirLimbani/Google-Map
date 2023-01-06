import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseQuery {
  FirebaseQuery._();
  static final FirebaseQuery firebaseQuery = FirebaseQuery._();
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  Future<void> addSong(Map<String, dynamic> data) async {
    firebaseFirestore.collection('Favorite_song').add(data);
  }

  Future<void> removeSong(String uid) async {
    firebaseFirestore.collection('Favorite_song').doc(uid).delete();
  }

  Future<void> updateSong(String uid, Map<String, dynamic> data) async {
    firebaseFirestore.collection('Music').doc(uid).update(data);
  }
}
