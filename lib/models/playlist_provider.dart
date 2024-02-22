import 'package:flutter/material.dart';
import 'package:music_player/models/song.dart';

class PlaylistProvider extends ChangeNotifier {
  final List<Song> _playlist = [
    //1
    Song(
      songName: '1',
      artistName: '1',
      albumArtImagePath:
          'https://avatars.mds.yandex.net/i?id=7edc6dcb9f563263f3dd8b0e26ca6053b5403bef-10749046-images-thumbs&n=13',
      audioPath: 'assets/audio/1.mp3',
    ),

    //2
    Song(
      songName: '2',
      artistName: '2',
      albumArtImagePath:
          'https://avatars.mds.yandex.net/i?id=7edc6dcb9f563263f3dd8b0e26ca6053b5403bef-10749046-images-thumbs&n=13',
      audioPath: 'assets/audio/2.mp3',
    ),

    //3
    Song(
      songName: '3',
      artistName: '3',
      albumArtImagePath:
          'https://avatars.mds.yandex.net/i?id=7edc6dcb9f563263f3dd8b0e26ca6053b5403bef-10749046-images-thumbs&n=13',
      audioPath: 'assets/audio/3.mp3',
    ),
  ];
  //current song playing index
  int? _currentSongIndex;

  /*

  G E T T E R S

  */
  List<Song> get playlist => _playlist;
  int? get currentSongIndex => _currentSongIndex;

  /*

  S E T T E R S
  
  */
  set currentSongIndex(int? newIndex) {
    _currentSongIndex = newIndex;

    notifyListeners();
  }
}
