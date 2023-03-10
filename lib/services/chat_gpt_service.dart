// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:voice_chat_gpt/constants/constants.dart';

class ChatResponse {
  String message;

  ChatResponse({
    required this.message,
  });
}

class ChatGptService {
  final String _apiKey = apiKey!;

  Future<ChatResponse> generateResponse({
    required String message,
  }) async {
    var uri =
        Uri.https("api.openai.com", "/v1/engines/text-davinci-003/completions");
    var request = await http
        .post(uri,
            headers: {
              "Content-Type": "application/json",
              "Authorization": "Bearer $_apiKey"
            },
            body: json.encode({
              "prompt": message,
              "temperature": 0.9,
              "max_tokens": 1000,
              "top_p": 1,
              "frequency_penalty": 0,
              "presence_penalty": 0.6,
            }))
        .timeout(
      const Duration(seconds: 45),
      onTimeout: () {
        throw Exception('Your internet is too slow to generate response!');
      },
    );
    if (request.statusCode != 200) {
      throw Exception("Failed to generate response");
    }
    var data = json.decode(request.body)['choices'][0]['text'];
    return ChatResponse(message: data);
  }
}
