import 'package:cancellation_token_http/http.dart';

import '../constants/constants.dart';
import '../services/chat_gpt_service.dart';

class ConversationProvider {
  String _lastResponse = '';
  String _lastPrompt = '';
  CancellationToken? _cancellationToken;

  String get latestResponse => _lastResponse;

  void cancelResponseRequest() {
    _cancellationToken!.cancel();
  }

  Future<void> generateResponse({
    required String prompt,
    void Function()? onResponseCompletion,
  }) async {
    _cancellationToken = CancellationToken();
    _lastPrompt = prompt;
    final oldConversation =
        conversationBox.get('conversation', defaultValue: '');
    String newConversation = "$oldConversation${'Human'}: $prompt\nAI:";

    await conversationBox.put('conversation', newConversation);
    try {
      final response = await ChatGptService().generateResponse(
        message: newConversation,
        cancellationToken: _cancellationToken!,
      );
      _lastResponse = response.message.trim();
      if (onResponseCompletion != null) {
        onResponseCompletion();
      }
      newConversation = "$newConversation${response.message}\n";
      await conversationBox.put('conversation', newConversation);
    } catch (e) {
      rethrow;
    }
  }
}
