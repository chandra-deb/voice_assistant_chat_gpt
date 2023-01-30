// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'chat_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
