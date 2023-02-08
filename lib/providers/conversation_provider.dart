import '../constants/constants.dart';
import '../services/chat_gpt_service.dart';

class ConversationProvider {
  String _lastResponse = '';
  String _lastPrompt = '';

  String get latestResponse => _lastResponse;

  Future<void> generateResponse({
    required String prompt,
    void Function()? onResponseCompletion,
  }) async {
    _lastPrompt = prompt;
    final oldConversation =
        conversationBox.get('conversation', defaultValue: '');
    String newConversation = "$oldConversation${'Human'}: $prompt\nAI:";

    await conversationBox.put('conversation', newConversation);
    try {
      final response = await ChatGptService().generateResponse(
        message: newConversation,
      );
      _lastResponse = response.message;
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
