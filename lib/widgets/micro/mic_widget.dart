// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

class MicWidget extends StatefulWidget {
  final void Function(String result) addMessage;

  const MicWidget({
    Key? key,
    required this.addMessage,
  }) : super(key: key);

  @override
  State<MicWidget> createState() => _MicWidgetState();
}

class _MicWidgetState extends State<MicWidget> {
  final SpeechToText _speechToText = SpeechToText();

  bool isListening = false;
  String _lastWords = '';

  Future<void> _initSpeech() async {
    await _speechToText.initialize();
  }

  Future<void> _startListening() async {
    await _speechToText.listen(
      onResult: _onSpeechResult,
      partialResults: false,
      listenMode: ListenMode.search,
    );
  }

  void _onSpeechResult(SpeechRecognitionResult result) async {
    _lastWords = result.recognizedWords;
    widget.addMessage(_lastWords);
  }

  Future<void> _stopListening() async {
    await _speechToText.stop();
  }

  @override
  void initState() {
    _initSpeech();
    _speechToText.statusListener = (status) {
      if (status == 'listening') {
        setState(() {
          isListening = true;
        });
      } else if (status == 'notListening') {
        setState(() {
          isListening = false;
        });
      }
    };
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      width: 70,
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18),
            ),
            backgroundColor: Colors.white,
            padding: const EdgeInsets.all(5),
          ),
          child: isListening
              ? const LoadingIndicator(
                  indicatorType: Indicator.lineScalePulseOutRapid,
                  colors: [Colors.blue, Colors.pink, Colors.red],
                )
              : const Icon(
                  color: Colors.pink,
                  Icons.mic,
                  size: 40,
                ),
          onPressed: () async {
            // If not yet listening for speech start, otherwise stop
            FocusManager.instance.primaryFocus?.unfocus();

            if (!isListening) {
              await _startListening();
            } else {
              await _stopListening();
            }
          }),
    );
  }
}
