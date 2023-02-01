import 'package:flutter_tts/flutter_tts.dart';

class TextToSpeechProvider {
  bool isSpeaking = false;
  late final FlutterTts _tts;

  TextToSpeechProvider() {
    _tts = FlutterTts();
    _tts.setSpeechRate(0.4);
  }

  Future<void> speak({
    required String text,
    void Function()? setOnSpeakingCompletion,
  }) async {
    isSpeaking = true;
    await _tts.speak(text);
    _tts.setCompletionHandler(() {
      if (setOnSpeakingCompletion != null) {
        setOnSpeakingCompletion();
      }
      isSpeaking = false;
    });
  }

  Future<void> stopSpeaking() async {
    isSpeaking = false;
    await _tts.stop();
  }
}
