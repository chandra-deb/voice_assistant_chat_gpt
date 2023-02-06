import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'models/chat_message_model.dart';
import 'providers/conversation_provider.dart';
import 'providers/messages_provider.dart';
import 'providers/text_to_speech_provider.dart';
import 'widgets/mini/bottom_actions_widget.dart';
import 'widgets/mini/chat_message_list_widget.dart';
import 'widgets/mini/sp_indicator.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final MessagesProvider messagesListProvider;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    messagesListProvider = context.read<MessagesProvider>();

    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        if (_scrollController.hasClients) {
          _scrollController.animateTo(
              _scrollController.position.maxScrollExtent,
              duration: const Duration(milliseconds: 500),
              curve: Curves.fastOutSlowIn);
        }
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

  Future<void> messageAdder(String text) async {
    messagesListProvider.addMessage(
      ChatMessage(
        text: text,
        chatMessageType: ChatMessageType.user,
      ),
    );
    Future.delayed(const Duration(milliseconds: 50)).then((_) => _scrollDown());

    try {
      await context.read<ConversationProvider>().generateResponse(prompt: text);
      final repliedMessage =
          // ignore: use_build_context_synchronously
          context.read<ConversationProvider>().latestResponse;
      // ignore: use_build_context_synchronously
      await context.read<TextToSpeechProvider>().speak(
            // ignore: use_build_context_synchronously
            text: repliedMessage,
          );
      // ignore: use_build_context_synchronously

      messagesListProvider.addMessage(
        ChatMessage(
          text: repliedMessage,
          chatMessageType: ChatMessageType.bot,
        ),
      );
      Future.delayed(const Duration(milliseconds: 50))
          .then((_) => _scrollDown());
    } catch (e) {
      const fallbackMessage =
          'I think your internet connection is very slow or turned off. I can not answer anything without stable internet connection.';
      context.read<TextToSpeechProvider>().speak(
            text: fallbackMessage,
          );
      messagesListProvider.addMessage(
        ChatMessage(
          text: fallbackMessage,
          chatMessageType: ChatMessageType.bot,
        ),
      );
      Future.delayed(const Duration(milliseconds: 50))
          .then((_) => _scrollDown());

      final snackBar = SnackBar(content: Text(e.toString()));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        toolbarHeight: 100,
        title: const Padding(
          padding: EdgeInsets.all(8.0),
          child: SpeakingIndicatorWidget(),
        ),
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      body: SafeArea(
          child: Container(
        // padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            Expanded(
              child: ChatMessageListViewWidget(
                scrollController: _scrollController,
              ),
            ),
            BottomActionsWidget(
              messageAdder: messageAdder,
            )
          ],
        ),
      )),
    );
  }
}
