// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:voice_chat_gpt/widgets/mini/message_long_tap_actions_widget.dart';

import '../../models/chat_message_model.dart';
import '../../providers/messages_provider.dart';
import '../../providers/text_to_speech_provider.dart';
import 'input_bar_widget.dart';

class BottomActionsWidget extends StatelessWidget {
  final Future<void> Function(String text) messageAdder;
  const BottomActionsWidget({
    Key? key,
    required this.messageAdder,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isSpeaking =
        context.select<TextToSpeechProvider, bool>((tts) => tts.isSpeaking);
    final selectedMessage = context
        .select<MessagesProvider, ChatMessage?>((msg) => msg.selectedMessage);
    return AnimatedSwitcher(
      key: ValueKey(selectedMessage?.id),
      duration: const Duration(milliseconds: 350),
      transitionBuilder: (Widget child, Animation<double> animation) {
        return FadeTransition(
          opacity: animation,
          child: child,
        );

        // return ScaleTransition(scale: animation, child: child);
      },
      child: isSpeaking
          ? GestureDetector(
              onTap: () {
                HapticFeedback.lightImpact();
                context.read<TextToSpeechProvider>().stopSpeaking();
                context.read<MessagesProvider>().clearSelectedMessage();
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.pink,
                  border: Border.all(width: 0.1, color: Colors.grey),
                  borderRadius: const BorderRadius.all(Radius.circular(20)),
                ),
                margin: const EdgeInsets.symmetric(vertical: 10),
                height: 50,
                width: 70,
                child: const Icon(
                  Icons.close,
                  color: Colors.white,
                ),
              ),
            )
          : selectedMessage != null
              ? const MessageLongTapActionsWidget()
              : InputBarWidget(addMessage: messageAdder),
    );
  }
}
