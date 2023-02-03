import 'package:flutter/cupertino.dart';
import 'package:flutter_tts/flutter_tts.dart';

class TextToSpeechProvider extends ChangeNotifier {
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
    await _tts.speak(text);
    isSpeaking = true;
    notifyListeners();
    _tts.setCompletionHandler(() {
      if (setOnSpeakingCompletion != null) {
        setOnSpeakingCompletion();
      }
      isSpeaking = false;
      notifyListeners();
    });
  }

  Future<void> stopSpeaking() async {
    isSpeaking = false;
    notifyListeners();
    await _tts.stop();
  }
}
