// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import 'package:voice_chat_gpt/home_page.dart';
import 'package:voice_chat_gpt/providers/conversation_provider.dart';
import 'package:voice_chat_gpt/providers/input_button_provider.dart';
import 'package:voice_chat_gpt/providers/messages_provider.dart';

import 'providers/text_to_speech_provider.dart';

void main() async {
  await dotenv.load();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Friendly',
      home: MultiProvider(
        providers: [
          ChangeNotifierProvider<TextToSpeechProvider>(
            create: (context) => TextToSpeechProvider(),
          ),
          Provider<ConversationProvider>(
            create: (context) => ConversationProvider(),
          ),
          ChangeNotifierProvider<MessagesProvider>(
            create: (context) => MessagesProvider(),
          ),
          ChangeNotifierProvider<InputButtonProvider>(
            create: (context) => InputButtonProvider(),
          ),
          ChangeNotifierProvider<DynamicIslandProvider>(
            create: (context) => DynamicIslandProvider(),
          )
        ],
        child: const HomePage(),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
