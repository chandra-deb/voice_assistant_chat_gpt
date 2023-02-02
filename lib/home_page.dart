import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';

import 'constants/constants.dart';
import 'models/chat_message_model.dart';
import 'providers/conversation_provider.dart';
import 'providers/messages_list_provider.dart';
import 'providers/text_to_speech_provider.dart';
import 'widgets/mini/chat_message_list_widget.dart';
import 'widgets/mini/input_bar_widget.dart';
import 'widgets/mini/speaking_indicator_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _scrollController = ScrollController();
  late final MessagesListProvider messagesListProvider;
  late final OverlayState overlay;
  late OverlayEntry _overlayEntry;

  @override
  void initState() {
    super.initState();
    messagesListProvider = context.read<MessagesListProvider>();
    overlay = Overlay.of(context)!;
    _overlayEntry = OverlayEntry(
      builder: (ctx) {
        return Positioned(
          bottom: MediaQuery.of(ctx).size.height / 6,
          left: (MediaQuery.of(ctx).size.width -
                  (MediaQuery.of(ctx).size.width / 2.5)) /
              2,
          child: SpeakingIndicatorWidget(
            onClose: () {
              context.read<TextToSpeechProvider>().stopSpeaking();
              closeOverLay();
            },
          ),
        ).animate().fadeIn();
      },
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
            setOnSpeakingCompletion: closeOverLay,
          );
      showOverlay();
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
      final snackBar = SnackBar(content: Text(e.toString()));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  showOverlay() {
    overlay.insert(_overlayEntry);
  }

  void closeOverLay() {
    _overlayEntry.remove();
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
                    scrollController: _scrollController,
                  ),
                ),
              ),
              InputBarWidget(addMessage: messageAdder),
            ],
          ),
        ),
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
