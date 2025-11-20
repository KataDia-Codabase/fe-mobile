import 'package:katadia_fe/core/services/gemini_service.dart';

class ChatRepository {
  final GeminiService geminiService;

  ChatRepository({required this.geminiService});

  /// Get AI response using Gemini with English learning context
  Future<String> getAIResponse(String userMessage) async {
    return await geminiService.sendMessage(userMessage);
  }

  /// Get AI response with custom context
  Future<String> getAIResponseWithContext(
    String userMessage, {
    String? context,
  }) async {
    return await geminiService.sendMessageWithContext(
      userMessage,
      systemContext: context,
    );
  }

  /// Get AI response with specific topic for English learning
  Future<String> getAIResponseWithTopic(
    String userMessage,
    String topic, {
    String? userLevel,
  }) async {
    return await geminiService.sendMessageWithTopic(
      userMessage,
      topic,
      userLevel: userLevel,
    );
  }

  /// Reset the chat session
  void resetSession() {
    geminiService.resetChat();
  }
}
