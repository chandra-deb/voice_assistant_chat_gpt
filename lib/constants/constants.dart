// Colors
import 'dart:ui';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hive/hive.dart';
import 'package:voice_chat_gpt/models/chat_message_model.dart';

const backgroundColor = Color(0xff343541);
const botBackgroundColor = Color(0xff444654);

// ApiKey
final apiKey = dotenv.env['apiKey'];

// HiveDB
final messagesBox = Hive.box<ChatMessage>('messagesBox');
final conversationBox = Hive.box<String>('conversation');
