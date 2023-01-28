// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:voice_chat_gpt/services/chat_gpt_service.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'ChatGPT-3',
      home: ChatPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

const backgroundColor = Color(0xff343541);
const botBackgroundColor = Color(0xff444654);

class ChatMessage {
  final String text;
  final ChatMessageType chatMessageType;
  ChatMessage({
    required this.text,
    required this.chatMessageType,
  });
}

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

  late bool isLoading;
  String _lastWords = '';

  @override
  void initState() {
    super.initState();
    isLoading = false;
    _initSpeech();
  }

  /// This has to happen only once per app
  void _initSpeech() async {
    await _speechToText.initialize();
  }

  /// Each time to start a speech recognition session
  Future<void> _startListening() async {
    setState(() {});
    await _speechToText.listen(
        onResult: _onSpeechResult,
        partialResults: false,
        listenMode: ListenMode.search);
    print('Stopped Listening');
  }

  /// Manually stop the active speech recognition session
  /// Note that there are also timeouts that each platform enforces
  /// and the SpeechToText plugin supports setting timeouts on the
  /// listen method.
  Future<void> _stopListening() async {
    await _speechToText.stop();
    setState(() {});
  }

  /// This is the callback that the SpeechToText plugin calls when
  /// the platform returns recognized words.
  void _onSpeechResult(SpeechRecognitionResult result) async {
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
    _speak(newMessage.message);
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
              child: _buildList(),
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
              color: _speechToText.isListening
                  ? Colors.red
                  : const Color.fromRGBO(142, 142, 160, 1),
            ),
            onPressed: () async {
              // If not yet listening for speech start, otherwise stop
              if (_speechToText.isNotListening) {
                await _startListening();
              } else {
                await _stopListening();
              }
            }),
      ),
    );
  }

  ListView _buildList() {
    return ListView.builder(
      controller: _scrollController,
      itemCount: _messages.length,
      itemBuilder: (context, index) {
        var message = _messages[index];
        return ChatMessageWidget(
          text: message.text,
          chatMessageType: message.chatMessageType,
        );
      },
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

class ChatMessageWidget extends StatelessWidget {
  const ChatMessageWidget(
      {super.key, required this.text, required this.chatMessageType});

  final String text;
  final ChatMessageType chatMessageType;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      padding: const EdgeInsets.all(16),
      color: chatMessageType == ChatMessageType.bot
          ? botBackgroundColor
          : backgroundColor,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          chatMessageType == ChatMessageType.bot
              ? Container(
                  margin: const EdgeInsets.only(right: 16.0),
                  child: CircleAvatar(
                    backgroundColor: const Color.fromRGBO(16, 163, 127, 1),
                    child: Image.asset(
                      'assets/bot.jpg',
                    ),
                  ),
                )
              : Container(
                  margin: const EdgeInsets.only(right: 16.0),
                  child: const CircleAvatar(
                    child: Icon(
                      Icons.person,
                    ),
                  ),
                ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.all(8.0),
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(8.0)),
                  ),
                  child: Text(
                    text,
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge
                        ?.copyWith(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
