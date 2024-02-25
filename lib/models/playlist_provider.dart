import 'package:audioplayers/audioplayers.dart';
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
      audioPath:
          "https://cdndl.zaycev.net/track/24511654/Cq23Z8fx9dLr2ZrLEvCExaKysKXi6ZsFPjPSLtLPgstiCBSAnaArCswezF9aY6dgvE5BKoVv1hKNZVbMLKXS5AXi6hwwumqzuVms62b7FFX6UhTnRUxvo9RognuRBsyjwUq2zN2br1h7nsMHFgP9izxMsrZMjEteAMUzJpoms7tsRUPupuehK6grdfq6H99r1xvJTrbYrkaxDAE9hDamUp15d47zgNNWQTukZNyJLCshfgPRybtpyS1RkwX2L6aMrY1W1As7KqRko3qQRTB3zX27yMHcHMqKdq81aDX7s6qbxZ2DkPork9sbAAYtNRVtodZ45yNiASzvZTzC9sr4UpUaLKwzK6",
    ),

    //2
    Song(
      songName: '2',
      artistName: '2',
      albumArtImagePath:
          'https://avatars.mds.yandex.net/i?id=7edc6dcb9f563263f3dd8b0e26ca6053b5403bef-10749046-images-thumbs&n=13',
      audioPath:
          'https://cdndl.zaycev.net/track/24952856/BPTWczXQ9QBycJc7UjaiQ5LyYRK7qqnwLWqLqyNd6j18rTUtp6zYz63G9NZTTXCn5STUejKaYfn8VWHpaT2ei1Vbw3j4hMzBfbYSF3a6EFkLGcbu6qTFwpizeCpvGWKNeiiec21mwmXTAvbyLERkWv7bKoj6tqpxunwJjXeZtGKi7VEzEafQutT6QffevJS6WneUBr8w12en4phJdSv4f4bqfHTzViiA9HQZEJ2UUZWVhb3PkyomtWAwnycLnotB6h3DWyXM65oTLJ1r7DcbkVcK2C48zDQhxoV1VwFhtMSZ3cjDtCHeAumHJm4rvjdtJYrsvH8pmchXBRUhR85cMyU45aaM74',
    ),

    //3
    Song(
      songName: '3',
      artistName: '3',
      albumArtImagePath:
          'https://avatars.mds.yandex.net/i?id=7edc6dcb9f563263f3dd8b0e26ca6053b5403bef-10749046-images-thumbs&n=13',
      audioPath:
          'https://cdndl.zaycev.net/track/24880076/2FvSnw5naWcGf21WojDHEcn7B6PW7nc5a664YgzEhCiNNYZRVjJSapiZkTHhQsov7bYu6e8oBW563LzQVU5EMjUUTFv48k3YHQBchndpLKncTupRQmp8Gi1wUQ6y1QDZsWZft463jqUzJJVeTXTMaYGS37V2iDToJuugKkk9TfqvdQgB86nXHoGH9nPKn9k6uYY2FDPoNGyAUQDYFeG5hGsUb1jvCViurtF7c81yXWvdfesczT6oKTkuaTwCDshrazrPT1K6b159anf1co2bo93A8r4sR13cQ5Acw5NX8LQo83ukMrc8jLgbCqYFPuzgpUJ4UhEUXjXwhUWmn7dWaDxr2oqaRF',
    ),
  ];
  //current song playing index
  int? _currentSongIndex;

  /*

  A U D I O P L A Y E R 

  */

  // audio player
  final AudioPlayer _audioPlayer = AudioPlayer();

  // durations
  Duration _currentDuration = Duration.zero;
  Duration _totalDuration = Duration.zero;

  //constructor
  PlaylistProvider() {
    listenToDuraton();
  }

  //initially not playing
  bool _isPlaying = false;

  //play the song
  void play() async {
    final String path = _playlist[_currentSongIndex!].audioPath;
    await _audioPlayer.stop(); //stop current song
    await _audioPlayer.play(UrlSource(path)); //play the new song
    _isPlaying = true;
    notifyListeners();
  }

  //pause current song
  void pause() async {
    await _audioPlayer.pause();
    _isPlaying = false;
    notifyListeners();
  }

  //resume playing
  void resume() async {
    await _audioPlayer.resume();
    _isPlaying = true;
    notifyListeners();
  }

  //pause or resume
  void pauseOrResume() async {
    if (_isPlaying) {
      pause();
    } else {
      resume();
    }

    notifyListeners();
  }

  //seek to a specific position in the current song
  void seek(Duration position) async {
    await _audioPlayer.seek(position);
  }

  //play next song
  void playNextSong() async {
    if (_currentSongIndex != null) {
      if (_currentSongIndex! < _playlist.length - 1) {
        //go to the next song if it's not the last song
        currentSongIndex = _currentSongIndex! + 1;
      } else {
        // if it's the last song, loop back to the first song
        currentSongIndex = 0;
      }
    }
  }

  //play previous song
  void playPreviousSong() async {
    //if more the 2 seconds have passed, restart the current song
    if (_currentDuration.inSeconds > 2) {
      seek(Duration.zero);
    }
    // if it's within first 2 second of the song, go to previous song
    else {
      if (_currentSongIndex! > 0) {
        currentSongIndex = _currentSongIndex! - 1;
      } else {
        //if it's the first song, loop back to last song
        currentSongIndex = _playlist.length - 1;
      }
    }
  }

  //listen to duration
  void listenToDuraton() {
    //listen for total duration
    _audioPlayer.onDurationChanged.listen((newDuration) {
      _totalDuration = newDuration;
      notifyListeners();
    });

    //listen for current duration
    _audioPlayer.onPositionChanged.listen((newPosition) {
      _currentDuration = newPosition;
      notifyListeners();
    });

    //listen for song completion
    _audioPlayer.onPlayerComplete.listen((event) {
      playNextSong();
    });
  }

  //dispose audio player

  /*

  G E T T E R S

  */
  List<Song> get playlist => _playlist;
  int? get currentSongIndex => _currentSongIndex;
  bool get isPlaying => _isPlaying;
  Duration get currentDuration => _currentDuration;
  Duration get totalDuration => _totalDuration;

  /*

  S E T T E R S
  
  */
  set currentSongIndex(int? newIndex) {
    _currentSongIndex = newIndex;

    if (newIndex != null) {
      play(); //play the song at the new index
    }

    notifyListeners();
  }
}
