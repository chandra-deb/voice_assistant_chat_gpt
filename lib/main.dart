// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:voice_chat_gpt/home_page.dart';
import 'package:voice_chat_gpt/models/chat_message_model.dart';
import 'package:voice_chat_gpt/providers/settings_provider.dart';
import 'package:voice_chat_gpt/utils/app_theme.dart';

import 'providers/conversation_provider.dart';
import 'providers/dynamic_island_provider.dart';
import 'providers/input_button_provider.dart';
import 'providers/messages_provider.dart';
import 'providers/text_to_speech_provider.dart';

void main() async {
  await dotenv.load();
  WidgetsFlutterBinding.ensureInitialized();
  var devices = ["BAE690AF4B29951E161C582A8B4E77FC"];
  await MobileAds.instance.initialize();
  var requestConfig = RequestConfiguration(testDeviceIds: devices);
  MobileAds.instance.updateRequestConfiguration(requestConfig);

  var directory = await getApplicationDocumentsDirectory();
  Hive.init(directory.path);
  Hive.registerAdapter(ChatMessageAdapter());
  Hive.registerAdapter(ChatMessageTypeAdapter());
  // await Hive.deleteBoxFromDisk('messagesBox');
  // await Hive.deleteBoxFromDisk('conversation');
  await Hive.openBox('settings');
  await Hive.openBox<ChatMessage>('messagesBox');
  await Hive.openBox<String>('conversation');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
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
        ),
        ChangeNotifierProvider<SettingsProvider>(
          create: (context) => SettingsProvider(),
        )
      ],
      child: Builder(builder: (context) {
        final appTheme = context.watch<SettingsProvider>().appTheme;
        final isDark = appTheme == AppTheme.dark;
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          // theme: ThemeData.light(),
          // darkTheme: ThemeData.dark(),
          theme: Styles.themeData(isDark, context),
          home: const HomePage(),
        );
      }),
    );
  }
}
