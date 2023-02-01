import '../services/chat_gpt_service.dart';

class ConversationProvider {
  String _conversation = '';
  String _lastResponse = '';
  String _lastPrompt = '';

  String get latestResponse => _lastResponse;

  Future<void> generateResponse({
    required String prompt,
    void Function()? onResponseCompletion,
  }) async {
    _lastPrompt = prompt;
    _conversation = "$_conversation${'Human'}: $prompt\nAI:";
    try {
      final response = await ChatGptService().generateResponse(
        message: _conversation,
      );
      _lastResponse = response.message;
      if (onResponseCompletion != null) {
        onResponseCompletion();
      }
      _conversation = "$_conversation${response.message}\n";
    } catch (e) {
      rethrow;
    }
  }
}
