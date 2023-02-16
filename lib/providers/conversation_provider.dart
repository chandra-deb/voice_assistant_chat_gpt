// import 'package:cancellation_token_http/http.dart';

// import '../constants/constants.dart';
// import '../services/chat_gpt_service.dart';

// class ConversationProvider {
//   String _lastResponse = '';
//   String _lastQuestion = '';
//   CancellationToken? _cancellationToken;

//   String get latestResponse => _lastResponse;

//   void cancelResponseRequest() {
//     _cancellationToken!.cancel();
//   }

//   Future<void> generateResponse({
//     required String prompt,
//     void Function()? onResponseCompletion,
//   }) async {
//     _cancellationToken = CancellationToken();
//     _lastQuestion = prompt;
//     final oldConversation =
//         conversationBox.get('conversation', defaultValue: '');
//     String newConversation = "$oldConversation${'Human'}: $prompt\nAI:";

//     await conversationBox.put('conversation', newConversation);
//     try {
//       final response = await ChatGptService().generateResponse(
//         message: newConversation,
//         cancellationToken: _cancellationToken!,
//       );
//       _lastResponse = response.message.trim();
//       if (onResponseCompletion != null) {
//         onResponseCompletion();
//       }
//       newConversation = "$newConversation${response.message}\n";
//       await conversationBox.put('conversation', newConversation);
//     } catch (e) {
//       rethrow;
//     }
//   }

//   final dst = DialogueStateTracking();
// }

import 'package:cancellation_token_http/http.dart';

import '../constants/constants.dart';
import '../services/chat_gpt_service.dart';

class ConversationProvider {
  String _lastResponse = '';
  String _lastQuestion = '';
  CancellationToken? _cancellationToken;

  final dst = DialogueStateTracker();

  String get latestResponse => _lastResponse;

  void cancelResponseRequest() {
    _cancellationToken!.cancel();
  }

  Future<void> generateResponse({
    required String prompt,
    void Function()? onResponseCompletion,
  }) async {
    _cancellationToken = CancellationToken();
    _lastQuestion = prompt;
    final oldConversation =
        conversationBox.get('conversation', defaultValue: '');

    // String newConversation = "$oldConversation${'Human'}: $prompt\nAI:";
    dst.setLastQuestion(prompt);
    String newConversation = "$oldConversation${'Me'}:$prompt\nAI:";
    print(newConversation);

    // String newConversation =
    //     await conversationBox.put('conversation', newConversation);
    try {
      final response = await ChatGptService().generateResponse(
        message: newConversation,
        cancellationToken: _cancellationToken!,
      );
      _lastResponse = response.message.trim();
      if (onResponseCompletion != null) {
        onResponseCompletion();
      }
      // newConversation = "$newConversation${response.message}\n";
      dst.setLastAnswer(response.message);
      if (dst.lastQuestion.isEmpty) {
        newConversation = "AI:${dst.lastAnswer}\n";
      } else {
        newConversation = "Me:${dst.lastQuestion}\nAI:${dst.lastAnswer}\n";
      }
      print("""\n$newConversation\n""");
      await conversationBox.put('conversation', newConversation);
    } catch (e) {
      rethrow;
    }
  }
}

class DialogueStateTracker {
  String _lastQuestion = '';
  String _lastAnswer = '';

  String get lastQuestion => _lastQuestion;
  String get lastAnswer => _lastAnswer;

  void setLastQuestion(String lastPrompt) {
    bool promptIsQuestion = _lastQuestion.toLowerCase().startsWith('wh') ||
        _lastQuestion.toLowerCase().startsWith('how') ||
        _lastQuestion.toLowerCase().split(' ')[0] == 'do' ||
        _lastQuestion.toLowerCase().split(' ')[0] == 'does';
    if (promptIsQuestion) {
      _lastQuestion = lastPrompt;
    }
  }

  void setLastAnswer(String generatedAnswer) {
    if (generatedAnswer.split(' ').length <= 6) {
      _lastAnswer = generatedAnswer;
    } else {
      _lastAnswer = 'Said';
    }
  }
}
