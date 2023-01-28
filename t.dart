import 'dart:convert';

import 'package:dio/dio.dart';

String apiKey = "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";
void main(List<String> args) {
  generateResponse("What is git");
}

Dio dio = Dio();

Future<String> generateResponse(String message) async {
  String url = "https://api.openai.com/v1/engines/text-davinci-003/completions";
  Map<String, String> headers = {
    "Content-Type": "application/json",
    "Authorization": "Bearer $apiKey"
  };
  String body = json.encode({
    "prompt": message,
    "temperature": 0,
    "max_tokens": 100,
    "top_p": 1,
    "frequency_penalty": 0,
    "presence_penalty": 0
  });

  try {
    Response response =
        await dio.post(url, data: body, options: Options(headers: headers));
    return response.data['choices'][0]['text'];
  } on DioError catch (error) {
    throw Exception(error.message);
    print(error);
  }
}
