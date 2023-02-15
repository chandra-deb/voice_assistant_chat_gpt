// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:voice_chat_gpt/providers/input_button_provider.dart';
import 'package:voice_chat_gpt/providers/settings_provider.dart';
import 'package:voice_chat_gpt/utils/popup_dialog.dart';

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

  late final _inputButtonProvider = context.read<InputButtonProvider>();
  // bool isListening = false;
  String _lastWords = '';
  bool isInitialized = false;

  Future<void> _initSpeech() async {
    isInitialized = await _speechToText.initialize();
    print(isInitialized);
  }

  Future<void> _startListening() async {
    if (isInitialized == false) {
      showPopup(context,
          child: SizedBox(
            height: 150,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                    'You have to give microphone permission to use voice recognition feature.'),
                Text('To enable this:'),
                Text(
                  'Click The App Settings button',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  'Then go to Permissions and allow microphone permission',
                  style: TextStyle(fontWeight: FontWeight.bold),
                )
              ],
            ),
          ),
          buttonName: 'Open Settings',
          onPressed: openAppSettings);
    } else {
      await _speechToText.listen(
        onResult: _onSpeechResult,
        partialResults: false,
        listenMode: ListenMode.search,
      );
    }
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
        _inputButtonProvider.setShowIsListeningTrue();
        // setState(() {
        //   isListening = true;
        // });
      } else if (status == 'notListening') {
        _inputButtonProvider.setShowMicTrue();
        // setState(() {
        //   isListening = false;
        // });
      }
    };
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = context.watch<SettingsProvider>().appTheme == AppTheme.dark;
    return SizedBox(
      height: 50,
      width: 70,
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18),
            ),
            backgroundColor: isDark ? Colors.pink : Colors.white,
            padding: const EdgeInsets.all(5),
          ),
          child: _inputButtonProvider.isShowListening
              ? LoadingIndicator(
                  indicatorType: Indicator.lineScalePulseOutRapid,
                  colors: isDark
                      ? [Colors.white, Colors.blue, Colors.green]
                      : [Colors.blue, Colors.pink, Colors.red],
                )
              : Icon(
                  color: isDark ? Colors.white : Colors.pink,
                  Icons.mic,
                  size: 40,
                ),
          onPressed: () async {
            // If not yet listening for speech start, otherwise stop
            FocusManager.instance.primaryFocus?.unfocus();

            if (!_inputButtonProvider.isShowListening) {
              await _startListening();
            } else {
              await _stopListening();
            }
          }),
    );
  }
}
