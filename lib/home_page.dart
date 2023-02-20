import 'package:cancellation_token_http/http.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'models/chat_message_model.dart';
import 'providers/conversation_provider.dart';
import 'providers/dynamic_island_provider.dart';
import 'providers/input_button_provider.dart';
import 'providers/messages_provider.dart';
import 'providers/settings_provider.dart';
import 'providers/text_to_speech_provider.dart';
import 'settings_page.dart';
import 'widgets/mini/bottom_actions_widget.dart';
import 'widgets/mini/chat_message_list_widget.dart';
import 'widgets/mini/dynamic_island_indicator_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final MessagesProvider _messagesListProvider;
  late final SettingsProvider _settingsProvider;
  late final InputButtonProvider _inputButtonProvider;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _messagesListProvider = context.read<MessagesProvider>();
    _inputButtonProvider = context.read<InputButtonProvider>();
    _settingsProvider = context.read<SettingsProvider>();

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
    // final settings = context.read<SettingsProvider>();
    _messagesListProvider.addMessage(
      ChatMessage(
        text: text,
        chatMessageType: ChatMessageType.user,
      ),
    );
    Future.delayed(const Duration(milliseconds: 50)).then((_) => _scrollDown());

    try {
      _inputButtonProvider.setShowLoadingResponseTrue();
      context.read<DynamicIslandProvider>().setIslandValue(Island.loading);

      await context.read<ConversationProvider>().generateResponse(prompt: text);

      // ignore: use_build_context_synchronously
      context.read<DynamicIslandProvider>().setLoadingDone();

      final repliedMessage =
          // ignore: use_build_context_synchronously
          context.read<ConversationProvider>().latestResponse;
      // ignore: use_build_context_synchronously
      if (_settingsProvider.isAutoReadAloud) {
        await context.read<TextToSpeechProvider>().speak(
              // ignore: use_build_context_synchronously
              text: repliedMessage,
            );
        // ignore: use_build_context_synchronously
      }

      _messagesListProvider.addMessage(
        ChatMessage(
          text: repliedMessage,
          chatMessageType: ChatMessageType.bot,
        ),
      );
      _inputButtonProvider.setShowMicTrue();

      Future.delayed(const Duration(milliseconds: 50))
          .then((_) => _scrollDown());
    } on CancelledException {
      context.read<DynamicIslandProvider>().setLoadingDone();
      context.read<DynamicIslandProvider>().setIslandValue(Island.cancelling);
    } on Exception {
      context.read<DynamicIslandProvider>().setLoadingDone();
      const fallbackMessage =
          'I think your internet connection is very slow or turned off. I can not answer anything without stable internet connection.';
      if (_settingsProvider.isAutoReadAloud) {
        context.read<TextToSpeechProvider>().speak(
              text: fallbackMessage,
            );
      }
      _messagesListProvider.addMessage(
        ChatMessage(
          text: fallbackMessage,
          chatMessageType: ChatMessageType.bot,
        ),
      );
      Future.delayed(const Duration(milliseconds: 50))
          .then((_) => _scrollDown());
    }
    _inputButtonProvider.setShowMicTrue();
  }

  @override
  Widget build(BuildContext context) {
    final appTheme = context.watch<SettingsProvider>().appTheme;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        centerTitle: true,
        toolbarHeight: 80,
        backgroundColor:
            appTheme == AppTheme.dark ? Colors.black : Colors.white,
        // title: const DynamicIslandIndicatorWidget(),
        title:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          const Icon(Icons.share, color: Colors.pink, size: 40),
          const DynamicIslandIndicatorWidget(),
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return const SettingsPage();
                  },
                ),
              );
            },
            icon: const Icon(
              Icons.settings,
              color: Colors.pink,
              size: 40,
            ),
          ),
        ]),
        elevation: 0,
      ),
      body: SafeArea(
        child: Flex(
          direction: Axis.vertical,
          children: [
            Flexible(
              child: ChatMessageListViewWidget(
                scrollController: _scrollController,
              ),
            ),
            BottomActionsWidget(
              messageAdder: messageAdder,
            )
          ],
        ),
      ),
    );
  }
}
