import 'package:cloud_firestore/cloud_firestore.dart';

class SongData {
  String image = "";
  String movie_name = "";
  String song_name = "";
  String song_url = "";
  String thumbnail_image = "";
  int? song_id;
  bool is_verified = false;
  String uid = "";
  SongData.fromSnapShort(QueryDocumentSnapshot snapshot) {
    final data = snapshot.data() as Map;
    image = data['image'];
    movie_name = data['movie_name'];
    song_name = data['song_name'];
    song_url = data['song_url'];
    thumbnail_image = data['thumbnail_image'];
    song_id = data['song_id'];
    is_verified = data['is_verified'];
    uid = snapshot.id;
  }
}
