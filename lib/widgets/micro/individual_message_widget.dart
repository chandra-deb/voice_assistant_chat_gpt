// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/chat_message_model.dart';
import '../../providers/text_to_speech_provider.dart';
import 'raw_individual_message_widget.dart';

class IndividualMessage extends StatefulWidget {
  const IndividualMessage({
    Key? key,
    required this.text,
    required this.type,
  }) : super(key: key);

  final String text;
  final ChatMessageType type;

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
    if (widget.type == ChatMessageType.bot) {
      return Container(
        decoration: const BoxDecoration(
          color: Colors.pink,
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(30.0),
            bottomLeft: Radius.circular(30.0),
            bottomRight: Radius.circular(30.0),
          ),
        ),
        padding: const EdgeInsets.all(2),
        child: RawIndividualMessageWidget(text: widget.text),
      );
    } else {
      return Container(
        padding: const EdgeInsets.all(2),
        decoration: const BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30.0),
            bottomLeft: Radius.circular(30.0),
            bottomRight: Radius.circular(30.0),
          ),
        ),
        child: RawIndividualMessageWidget(text: widget.text),
      );
    }
  }
}
