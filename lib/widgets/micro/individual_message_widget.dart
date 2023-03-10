// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';

import '../../models/chat_message_model.dart';
import '../../providers/text_to_speech_provider.dart';
import 'raw_individual_message_widget.dart';

class IndividualMessage extends StatefulWidget {
  final void Function() showOverlay;
  final void Function() closeOverLay;
  const IndividualMessage({
    Key? key,
    required this.showOverlay,
    required this.closeOverLay,
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
      return GestureDetector(
        onLongPress: () {
          showBtSheet();
        },
        child: Container(
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
        ),
      );
    } else {
      return GestureDetector(
        onLongPress: showBtSheet,
        child: Container(
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
        ),
      );
    }
  }

  void showBtSheet() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          height: 200,
          color: Colors.blueAccent,
          child: Column(
            children: [
              ElevatedButton(
                onPressed: ttsProvider.isSpeaking
                    ? null
                    : () async {
                        Navigator.of(context).pop();

                        await ttsProvider.speak(
                          text: widget.text,
                          setOnSpeakingCompletion: widget.closeOverLay,
                        );
                        widget.showOverlay();
                      },
                child: const Text('Play with voice'),
              ),
              ElevatedButton(
                onPressed: () async {
                  Navigator.pop(context);
                  Clipboard.setData(ClipboardData(text: widget.text)).then(
                    (value) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Copied to your clipboard !'),
                        ),
                      );
                    },
                  );
                },
                child: const Text('Copy Message'),
              ),
              ElevatedButton(
                onPressed: () async {
                  Navigator.pop(context);
                  await Share.share(widget.text);
                },
                child: const Text('Share Message'),
              ),
            ],
          ),
        );
      },
    );
  }
}
