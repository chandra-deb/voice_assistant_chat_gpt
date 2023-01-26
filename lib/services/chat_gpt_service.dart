// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:uuid/uuid.dart';

enum ChatMessageType { user, bot }

class ChatResponse {
  String message;
  String? conversationId;
  String? messageId;

  ChatResponse({
    required this.message,
    this.conversationId,
    this.messageId,
  }) {
    conversationId ??= const Uuid().v4();
    messageId ??= const Uuid().v4();
  }
}

class ChatGptService {
  final String _apiKey = "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";

  final Dio _dio = Dio();

  Future<ChatResponse> generateResponse({
    required String message,
    String? conversationId,
    String? parentMessageId,
  }) async {
    String url =
        "https://api.openai.com/v1/engines/text-davinci-003/completions";
    Map<String, String> headers = {
      "Content-Type": "application/json",
      "Authorization": "Bearer $_apiKey"
    };
    String body = json.encode({
      "prompt": message,
      "temperature": 0.9,
      "max_tokens": 150,
      "top_p": 1,
      "frequency_penalty": 0,
      "presence_penalty": 0.6,
      "stop": [" Human:", " AI:"]
    });

    try {
      Response response =
          await _dio.post(url, data: body, options: Options(headers: headers));
      final data = response.data['choices'][0]['text'];
      print(response.data);
      return ChatResponse(
          message: data,
          conversationId: conversationId,
          messageId: parentMessageId);
    } on DioError catch (error) {
      throw Exception(error.message);
    }
  }
}
