// // ignore_for_file: public_member_api_docs, sort_constructors_first
// import 'package:flutter/material.dart';
// import 'package:speech_to_text/speech_recognition_result.dart';
// import 'package:speech_to_text/speech_to_text.dart';

// class SpeechToTextProvider extends ChangeNotifier {
//   bool _isListening = false;
//   String _lastWords = '';
//   late final SpeechToText _speechToText;
//   final Function(String msg) wrkr;

//   SpeechToTextProvider(
//     this.wrkr,
//   ) {
//     _speechToText = SpeechToText();
//     _initSpeech();
//   }

//   void _initSpeech() async {
//     await _speechToText.initialize();
//   }

//   String get lastWords => _lastWords;
//   bool get isListening => _isListening;

//   Future<void> startListening() async {
//     _isListening = true;
//     notifyListeners();
//     await _speechToText.listen(
//       onResult: _onSpeechResult,
//       partialResults: false,
//       listenMode: ListenMode.search,
//     );
//   }

//   Future<void> stopListening() async {
//     _isListening = false;
//     notifyListeners();
//     await _speechToText.stop();
//   }

//   void _onSpeechResult(SpeechRecognitionResult result) async {
//     notifyListeners();
//     _isListening = false;
//     _lastWords = result.recognizedWords;
//     wrkr(_lastWords);
//   }
// }
