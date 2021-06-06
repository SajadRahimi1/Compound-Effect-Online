import 'dart:typed_data';
import 'dart:io';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:path_provider/path_provider.dart';

class Player {
  FlutterSound _flutterSound = FlutterSound();
  Future<void> play(String path) async {
    var dir = await getApplicationDocumentsDirectory();
    File file = File("${dir.path}/$path");
    Uint8List bytes = file.readAsBytesSync();
    await _flutterSound.thePlayer.openAudioSession();
    await _flutterSound.thePlayer.startPlayer(fromDataBuffer: bytes);
  }

  void pause() {
    if (_flutterSound.thePlayer.isOpen()) {
      _flutterSound.thePlayer.isPlaying
          ? _flutterSound.thePlayer.pausePlayer()
          : _flutterSound.thePlayer.resumePlayer();
    }
  }
}
