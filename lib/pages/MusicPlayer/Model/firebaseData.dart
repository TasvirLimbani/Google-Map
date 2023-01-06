import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo/pages/MusicPlayer/Model/songData.dart';

class DatabaseService {
  final String? uid;
  DatabaseService({this.uid});

  final CollectionReference songCollection =
      FirebaseFirestore.instance.collection('Music');
  final CollectionReference arijitSinghCollection =
      FirebaseFirestore.instance.collection('Arijit_singh');
  final CollectionReference favoriteCollection =
      FirebaseFirestore.instance.collection('Favorite_song');
  final CollectionReference a_r_rahmanCollection =
      FirebaseFirestore.instance.collection('A_R_Rahman');

  Future updateSongData(
    String image,
    String movieName,
    int songName,
    String songUrl,
    String thumbnailImage,
    int songId,
    bool isVerified,
  ) async {
    return await songCollection.doc(uid).set({
      'image': image,
      'movie_name': movieName,
      'song_name': songName,
      'song_url': songUrl,
      'thumbnail_image': thumbnailImage,
      'song_id': songId,
      'is_verified': isVerified,
    });
  }

  Future updateArijitSinghData(
    String image,
    String movieName,
    int songName,
    String songUrl,
    String thumbnailImage,
    int songId,
    bool isVerified,
  ) async {
    return await arijitSinghCollection.doc(uid).set({
      'image': image,
      'movie_name': movieName,
      'song_name': songName,
      'song_url': songUrl,
      'thumbnail_image': thumbnailImage,
      'song_id': songId,
      'is_verified': isVerified,
    });
  }

  Future updateFavoriteSong(
    String image,
    String movieName,
    int songName,
    String songUrl,
    String thumbnailImage,
    int songId,
    bool isVerified,
  ) async {
    return await favoriteCollection.doc(uid).set({
      'image': image,
      'movie_name': movieName,
      'song_name': songName,
      'song_url': songUrl,
      'thumbnail_image': thumbnailImage,
      'song_id': songId,
      'is_verified': isVerified,
    });
  }

  Future updateA_R_Rahman(
    String image,
    String movieName,
    int songName,
    String songUrl,
    String thumbnailImage,
    int songId,
    bool isVerified,
  ) async {
    return await a_r_rahmanCollection.doc(uid).set({
      'image': image,
      'movie_name': movieName,
      'song_name': songName,
      'song_url': songUrl,
      'thumbnail_image': thumbnailImage,
      'song_id': songId,
      'is_verified': isVerified,
    });
  }

  Stream<List<SongData>> get songs {
    return songCollection.snapshots().map((e) {
      List<SongData> modal = e.docs.map((et) {
        return SongData.fromSnapShort(et);
      }).toList();
      return modal;
    });
  }

  Stream<List<SongData>> get arijitSingh {
    return arijitSinghCollection.snapshots().map((e) {
      List<SongData> modal = e.docs.map((et) {
        return SongData.fromSnapShort(et);
      }).toList();
      return modal;
    });
  }

  Stream<List<SongData>> get favoriteSong {
    return favoriteCollection.snapshots().map((e) {
      List<SongData> favSOng = e.docs.map((et) {
        return SongData.fromSnapShort(et);
      }).toList();
      return favSOng;
    });
  }

  Stream<List<SongData>> get A_R_Rahman {
    return a_r_rahmanCollection.snapshots().map((e) {
      List<SongData> A_R_Rahman = e.docs.map((et) {
        return SongData.fromSnapShort(et);
      }).toList();
      return A_R_Rahman;
    });
  }
}
