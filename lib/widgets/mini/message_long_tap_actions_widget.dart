import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';

import '../../providers/dynamic_island_provider.dart';
import '../../providers/messages_provider.dart';
import '../../providers/text_to_speech_provider.dart';

class MessageLongTapActionsWidget extends StatelessWidget {
  const MessageLongTapActionsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final messageProvider = context.read<MessagesProvider>();
    final message = messageProvider.selectedMessage;
    final setIsland = context.watch<DynamicIslandProvider>().setIslandValue;
    return Container(
      // color: Colors.red,
      height: 50,
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        border: Border.all(width: 0.1, color: Colors.grey),
        borderRadius: const BorderRadius.all(Radius.circular(20)),
      ),
      // color: Colors.green,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () {
              // final messageProvider = context.read<MessagesProvider>();
              // final message = messageProvider.selectedMessage;
              HapticFeedback.lightImpact();
              context.read<TextToSpeechProvider>().speak(
                    text: message!.text,
                    setOnSpeakingCompletion:
                        messageProvider.clearSelectedMessage,
                  );
            },
            child: Container(
              padding: const EdgeInsets.all(10),
              margin: const EdgeInsets.symmetric(horizontal: 8),
              decoration: BoxDecoration(
                color: Colors.pink,
                border: Border.all(width: 0.1, color: Colors.grey),
                borderRadius: const BorderRadius.all(Radius.circular(20)),
              ),
              child: const Icon(
                Icons.surround_sound,
                size: 30,
                color: Colors.white,
              ),
            ),
          ),
          GestureDetector(
            onTap: () async {
              HapticFeedback.lightImpact();
              messageProvider.clearSelectedMessage();
              await Clipboard.setData(ClipboardData(text: message!.text));
              setIsland(Island.copying);
              // .then(
              //   (value) {
              //     ScaffoldMessenger.of(context).showSnackBar(
              //       const SnackBar(
              //         content: Text('Copied to your clipboard !'),
              //       ),
              //     );
              //   },
              // );
            },
            child: Container(
              padding: const EdgeInsets.all(10),
              margin: const EdgeInsets.symmetric(horizontal: 8),
              decoration: BoxDecoration(
                color: Colors.pink,
                border: Border.all(width: 0.1, color: Colors.grey),
                borderRadius: const BorderRadius.all(Radius.circular(20)),
              ),
              child: const Icon(
                Icons.copy,
                color: Colors.white,
                size: 30,
              ),
            ),
          ),
          GestureDetector(
            onTap: () async {
              HapticFeedback.lightImpact();
              await Share.share(message!.text).then((value) {
                messageProvider.clearSelectedMessage();
                setIsland(Island.sharing);
              });
            },
            child: Container(
              padding: const EdgeInsets.all(10),
              margin: const EdgeInsets.symmetric(horizontal: 8),
              decoration: BoxDecoration(
                color: Colors.pink,
                border: Border.all(width: 0.1, color: Colors.grey),
                borderRadius: const BorderRadius.all(Radius.circular(20)),
              ),
              child: const Icon(
                Icons.share,
                color: Colors.white,
                size: 30,
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              HapticFeedback.lightImpact();
              messageProvider.deleteMessage(message!);
              setIsland(Island.deleting);
            },
            child: Container(
              padding: const EdgeInsets.all(10),
              margin: const EdgeInsets.symmetric(horizontal: 8),
              decoration: BoxDecoration(
                color: Colors.pink,
                border: Border.all(width: 0.1, color: Colors.grey),
                borderRadius: const BorderRadius.all(Radius.circular(20)),
              ),
              child: const Icon(
                Icons.delete_outline_rounded,
                color: Colors.white,
                size: 30,
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              HapticFeedback.lightImpact();
              messageProvider.clearSelectedMessage();
            },
            child: Container(
              padding: const EdgeInsets.all(10),
              margin: const EdgeInsets.symmetric(horizontal: 8),
              decoration: BoxDecoration(
                color: Colors.pink,
                border: Border.all(width: 0.1, color: Colors.grey),
                borderRadius: const BorderRadius.all(Radius.circular(20)),
              ),
              child: const Icon(
                Icons.close,
                color: Colors.white,
                size: 30,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
