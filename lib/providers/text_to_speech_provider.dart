import 'package:flutter_tts/flutter_tts.dart';

class TextToSpeechProvider {
  bool isSpeaking = false;
  late final FlutterTts _tts;

  TextToSpeechProvider() {
    _tts = FlutterTts();
    _tts.setSpeechRate(0.4);
  }

  Future<void> speak(String text) async {
    isSpeaking = true;
    await _tts.speak(text);
    _tts.setCompletionHandler(() {
      isSpeaking = false;
    });
  }

  Future<void> stopSpeaking() async {
    isSpeaking = false;
    await _tts.stop();
  }
}
