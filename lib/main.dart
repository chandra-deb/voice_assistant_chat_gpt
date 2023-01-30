// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import 'package:voice_chat_gpt/chat_page.dart';

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
          Provider<TextToSpeechProvider>(
            create: (context) => TextToSpeechProvider(),
          ),
        ],
        child: const ChatPage(),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
