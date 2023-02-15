// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

// import 'package:http/http.dart' as http;
import 'package:cancellation_token_http/http.dart' as http;
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
    required http.CancellationToken cancellationToken,
  }) async {
    var uri = Uri.https("api.openai.com", "/v1/completions");

    // Uri.https("api.openai.com", "/v1/engines/text-davinci-003/completions");
    try {
      http.Response request = await http
          .post(
        uri,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $_apiKey"
        },
        body: json.encode(
          {
            "model": "text-davinci-003",
            "prompt": message,
            "temperature": 0.3,
            "max_tokens": 1000,
            "top_p": 1,
            "frequency_penalty": 0,
            "presence_penalty": 0.6,
          },
        ),
        cancellationToken: cancellationToken,
      )
          .timeout(
        const Duration(minutes: 1),
        onTimeout: () {
          throw Exception('Your internet is too slow to generate response!');
        },
      );
      if (request.statusCode != 200) {
        print(request.reasonPhrase);
        throw Exception("Failed to generate response");
      }
      var data = json.decode(request.body)['choices'][0]['text'];
      return ChatResponse(message: data);
    } on http.CancelledException {
      rethrow;
    } catch (e) {
      print(e);
      rethrow;
    }
  }
}
