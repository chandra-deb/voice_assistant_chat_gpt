import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'constants/constants.dart';
import 'models/chat_message_model.dart';
import 'providers/conversation_provider.dart';
import 'providers/messages_list_provider.dart';
import 'providers/text_to_speech_provider.dart';
import 'widgets/mini/chat_message_list_widget.dart';
import 'widgets/mini/input_bar_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final MessagesListProvider messagesListProvider;
  @override
  void initState() {
    super.initState();
    messagesListProvider = context.read<MessagesListProvider>();
  }

  Future<void> messageAdder(String text) async {
    messagesListProvider.addMessage(
      ChatMessage(
        text: text,
        chatMessageType: ChatMessageType.user,
      ),
    );

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
    } catch (e) {
      const fallbackMessage =
          'I think your internet connection is very slow or turned off. I can not answer anything without stable internet connection.';
      context.read<TextToSpeechProvider>().speak(text: fallbackMessage);
      messagesListProvider.addMessage(
        ChatMessage(
          text: fallbackMessage,
          chatMessageType: ChatMessageType.bot,
        ),
      );
      final snackBar = SnackBar(content: Text(e.toString()));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      onTapDown: (details) => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
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
          child: Column(
            children: [
              Expanded(
                child: ChatMessageListViewWidget(),
              ),
              InputBarWidget(addMessage: messageAdder),
            ],
          ),
        )),
      ),
    );
  }
}
