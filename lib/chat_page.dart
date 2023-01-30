import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

import 'constants/constants.dart';
import 'models/chat_message_model.dart';
import 'providers/text_to_speech_provider.dart';
import 'services/chat_gpt_service.dart';
import 'widgets/chat_message_list_widget.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final _scrollController = ScrollController();
  final SpeechToText _speechToText = SpeechToText();

  final List<ChatMessage> _messages = [];
  String conversation = '';
  late bool isListening;
  late bool isLoading;
  String _lastWords = '';

  @override
  void initState() {
    super.initState();
    isLoading = false;
    isListening = false;
    _initSpeech();
  }

  /// This has to happen only once per app
  void _initSpeech() async {
    await _speechToText.initialize();
  }

  /// Each time to start a speech recognition session
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

  /// Manually stop the active speech recognition session
  /// Note that there are also timeouts that each platform enforces
  /// and the SpeechToText plugin supports setting timeouts on the
  /// listen method.
  Future<void> _stopListening() async {
    setState(() {
      isListening = false;
    });
    await _speechToText.stop();
  }

  /// This is the callback that the SpeechToText plugin calls when
  /// the platform returns recognized words.
  void _onSpeechResult(SpeechRecognitionResult result) async {
    setState(() {
      isListening = false;
    });
    _lastWords = result.recognizedWords;
    await messageAdder(_lastWords);
  }

  Future<void> messageAdder(String text) async {
    setState(
      () {
        _messages.add(
          ChatMessage(
            text: text,
            chatMessageType: ChatMessageType.user,
          ),
        );
        isLoading = true;
      },
    );
    var input = text;
    Future.delayed(const Duration(milliseconds: 50)).then((_) => _scrollDown());
    conversation = "$conversation${'Human'}: $input\nAI:";
    var newMessage = await ChatGptService().generateResponse(
      // message: "$conversation \nHuman: $input",
      message: conversation,
    );
    // ignore: use_build_context_synchronously
    context.read<TextToSpeechProvider>().speak(newMessage.message);
    conversation = "$conversation${newMessage.message}\n";
    setState(() {
      isLoading = false;
      _messages.add(
        ChatMessage(
          text: newMessage.message,
          chatMessageType: ChatMessageType.bot,
        ),
      );
    });
    Future.delayed(const Duration(milliseconds: 50)).then((_) => _scrollDown());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        title: const Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(
            'ChatGPT',
            maxLines: 2,
            textAlign: TextAlign.center,
          ),
        ),
        backgroundColor: botBackgroundColor,
      ),
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: ChatMessageListViewWidget(
                messages: _messages,
                scrollController: _scrollController,
              ),
            ),
            Visibility(
              visible: isLoading,
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: CircularProgressIndicator(
                  color: Colors.white,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: _buildMic(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMic() {
    return Visibility(
      visible: !isLoading,
      child: Container(
        color: botBackgroundColor,
        child: IconButton(
            iconSize: 40,
            icon: Icon(
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

  void _scrollDown() {
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }
}
