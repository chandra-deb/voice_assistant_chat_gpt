import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'constants/constants.dart';
import 'models/chat_message_model.dart';
import 'providers/text_to_speech_provider.dart';
import 'services/chat_gpt_service.dart';
import 'widgets/mini/chat_message_list_widget.dart';
import 'widgets/mini/input_bar_widget.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final _scrollController = ScrollController();
  final List<ChatMessage> _messages = [];
  String conversation = '';
  late bool isLoading;

  @override
  void initState() {
    super.initState();
    isLoading = false;
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
        child: Container(
            padding: const EdgeInsets.all(15),
            child: Column(
              children: [
                Expanded(
                  child: Container(
                    color: Colors.red,
                    child: ChatMessageListViewWidget(
                      messages: _messages,
                      scrollController: _scrollController,
                    ),
                  ),
                ),
                InputBarWidget(addMessage: messageAdder),
              ],
            )),
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
