// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
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
    setState(() {
      isListening = true;
    });
    await _speechToText.listen(
      onResult: _onSpeechResult,
      partialResults: false,
      listenMode: ListenMode.search,
    );
  }

  void _onSpeechResult(SpeechRecognitionResult result) async {
    setState(() {
      isListening = false;
    });
    _lastWords = result.recognizedWords;
    widget.addMessage(_lastWords);
  }

  Future<void> _stopListening() async {
    setState(() {
      isListening = false;
    });
    await _speechToText.stop();
  }

  @override
  void initState() {
    _initSpeech();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      width: 60,
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white,
            enableFeedback: true,
          ),
          child: isListening
              ? const LoadingIndicator(
                  indicatorType: Indicator.lineScalePulseOutRapid,
                  colors: [Colors.red, Colors.blue, Colors.teal],
                )
              : const Icon(
        color: Colors.green,
              Icons.mic,
              color: isListening
                  ? Colors.red
                  : const Color.fromRGBO(142, 142, 160, 1),
            ),
            onPressed: () async {
              // If not yet listening for speech start, otherwise stop
              if (!isListening) {
                await _startListening();
              } else {
                await _stopListening();
              }
            }),
      ),
    );
  }
}
