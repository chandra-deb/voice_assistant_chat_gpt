// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:voice_chat_gpt/providers/messages_provider.dart';

import '../../models/chat_message_model.dart';
import '../../providers/text_to_speech_provider.dart';
import 'raw_individual_message_widget.dart';

class IndividualMessage extends StatefulWidget {
  const IndividualMessage({
    Key? key,
    required this.chatMessage,
  }) : super(key: key);

  final ChatMessage chatMessage;

  @override
  State<IndividualMessage> createState() => _IndividualMessageState();
}

class _IndividualMessageState extends State<IndividualMessage> {
  late final TextToSpeechProvider ttsProvider;
  @override
  void initState() {
    ttsProvider = context.read<TextToSpeechProvider>();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final selectedMessage = context.select<MessagesProvider, ChatMessage?>(
        (msgProvider) => msgProvider.selectedMessage);
    if (widget.chatMessage.chatMessageType == ChatMessageType.bot) {
      return Container(
        decoration: BoxDecoration(
          // color: Colors.pink,
          color: selectedMessage != null &&
                  selectedMessage.id == widget.chatMessage.id
              ? Colors.pinkAccent
              : Colors.pink,
          borderRadius: const BorderRadius.only(
            topRight: Radius.circular(30.0),
            bottomLeft: Radius.circular(30.0),
            bottomRight: Radius.circular(30.0),
          ),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 3),
        child: RawIndividualMessageWidget(text: widget.chatMessage.text),
      );
    } else {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 3),
        decoration: BoxDecoration(
          color: selectedMessage != null &&
                  selectedMessage.id == widget.chatMessage.id
              ? Colors.blueAccent
              : Colors.blue,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(30.0),
            bottomLeft: Radius.circular(30.0),
            bottomRight: Radius.circular(30.0),
          ),
        ),
        child: RawIndividualMessageWidget(text: widget.chatMessage.text),
      );
    }
  }
}
