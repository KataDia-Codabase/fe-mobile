import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'english_learning_prompt.dart';
import '../utils/logger.dart';

class GeminiService {
  // API Configuration
  static const String _apiEndpoint = 'https://generativelanguage.googleapis.com/v1beta/models/gemini-2.0-flash:generateContent';
  
  /// Get API key from environment variables
  String? get _apiKey {
    try {
      return dotenv.env['GEMINI_API_KEY'];
    } catch (e) {
      Logger.error('Failed to load API key from .env file: $e');
      return null;
    }
  }
  
  final List<Map<String, String>> _conversationHistory = [];

  GeminiService() {
    // Initialize service
  }

  /// Send a message to Gemini using REST API (more reliable)
  Future<String> sendMessage(String userMessage) async {
    return sendMessageWithContext(userMessage, systemContext: EnglishLearningPrompt.systemPrompt);
  }

  /// Send a message to Gemini with system context
  Future<String> sendMessageWithContext(
    String userMessage, {
    String? systemContext,
  }) async {
    try {
      // Add to conversation history
      _conversationHistory.add({'role': 'user', 'content': userMessage});

      // Build the request body with conversation context
      List<Map<String, dynamic>> contents = [];
      
      // Add system context if provided
      if (systemContext != null) {
        contents.add({
          'role': 'user',
          'parts': [
            {'text': systemContext}
          ]
        });
        contents.add({
          'role': 'model',
          'parts': [
            {'text': 'I understand. I\'m ready to help with English learning!'}
          ]
        });
      }
      
      // Add current user message
      contents.add({
        'role': 'user',
        'parts': [
          {'text': userMessage}
        ]
      });

      final requestBody = {
        'contents': contents,
        'generationConfig': {
          'temperature': 0.7,
          'topK': 40,
          'topP': 0.95,
          'maxOutputTokens': 1024,
        },
        'safetySettings': [
          {
            'category': 'HARM_CATEGORY_HARASSMENT',
            'threshold': 'BLOCK_MEDIUM_AND_ABOVE'
          },
          {
            'category': 'HARM_CATEGORY_HATE_SPEECH',
            'threshold': 'BLOCK_MEDIUM_AND_ABOVE'
          },
          {
            'category': 'HARM_CATEGORY_SEXUALLY_EXPLICIT',
            'threshold': 'BLOCK_MEDIUM_AND_ABOVE'
          },
          {
            'category': 'HARM_CATEGORY_DANGEROUS_CONTENT',
            'threshold': 'BLOCK_MEDIUM_AND_ABOVE'
          }
        ]
      };

      // Check if API key is available
      final apiKey = _apiKey;
      if (apiKey == null || apiKey.isEmpty) {
        return 'Error: API key not found. Please ensure GEMINI_API_KEY is set in your .env file.';
      }

      final response = await http
          .post(
            Uri.parse('$_apiEndpoint?key=$apiKey'),
            headers: {
              'Content-Type': 'application/json',
            },
            body: jsonEncode(requestBody),
          )
          .timeout(const Duration(seconds: 30));

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        
        if (jsonResponse['candidates'] != null && 
            jsonResponse['candidates'].isNotEmpty) {
          final content = jsonResponse['candidates'][0]['content'];
          if (content['parts'] != null && content['parts'].isNotEmpty) {
            final aiResponse = content['parts'][0]['text'] ?? 'No response generated';
            
            // Add to conversation history
            _conversationHistory.add({'role': 'assistant', 'content': aiResponse});
            
            return aiResponse;
          }
        }
        return 'Sorry, I could not generate a response.';
      } else if (response.statusCode == 400) {
        final errorBody = jsonDecode(response.body);
        final errorMessage = errorBody['error']?['message'] ?? 'Bad request';
        
        if (errorMessage.contains('API key')) {
          return 'Error: Invalid or expired API key. Please check your API key configuration.';
        } else if (errorMessage.contains('quota')) {
          return 'Error: API quota exceeded. Please check your usage limits.';
        }
        return 'Error: $errorMessage';
      } else if (response.statusCode == 401) {
        return 'Error: Unauthorized. Please verify your API key.';
      } else if (response.statusCode == 429) {
        return 'Error: Rate limit exceeded. Please try again later.';
      } else {
        return 'Error: Server error (${response.statusCode}). Please try again.';
      }
    } on http.ClientException catch (e) {
      Logger.error('Network error details: ${e.toString()}');
      
      if (e.message.contains('Failed host lookup') ||
          e.message.contains('No address associated') ||
          e.message.contains('Network is unreachable')) {
        return 'Error: No internet connection. Please check your network and try again.\n\nTip: If using emulator, ensure it has internet access in Android Studio → Extended Controls → Network settings.';
      }
      if (e.message.contains('Connection refused') ||
          e.message.contains('Connection reset')) {
        return 'Error: Connection to server failed. Please check your internet connection and try again.';
      }
      if (e.message.contains('Certificate')) {
        return 'Error: SSL certificate error. Please check your device date and time settings.';
      }
      return 'Error: Network connection failed. ${e.message}\n\nPlease check your internet connection and try again.';
    } on TimeoutException catch (_) {
      return 'Error: Request timeout. The server took too long to respond.\n\nPlease check your internet connection and try again.';
    } catch (e) {
      Logger.error('Unexpected error: $e');
      return 'Error: An unexpected error occurred. Please try again.\n\nDetails: ${e.toString()}';
    }
  }

  /// Send a message with a specific topic prompt
  Future<String> sendMessageWithTopic(
    String userMessage,
    String topic, {
    String? userLevel,
  }) async {
    String systemContext = EnglishLearningPrompt.systemPrompt;
    
    // Add topic-specific prompt
    String topicPrompt = EnglishLearningPrompt.getTopicPrompt(topic);
    systemContext += '\n\n$topicPrompt';
    
    // Add level adaptation if provided
    if (userLevel != null) {
      String levelAdaptation = EnglishLearningPrompt.getLevelAdaptedPrompt(userLevel);
      systemContext += '\n\n$levelAdaptation';
    }
    
    return sendMessageWithContext(userMessage, systemContext: systemContext);
  }

  /// Reset the chat session
  void resetChat() {
    _conversationHistory.clear();
  }

  /// Get conversation history
  List<Map<String, String>> getConversationHistory() {
    return List.from(_conversationHistory);
  }

  /// Clear conversation history
  void clearHistory() {
    _conversationHistory.clear();
  }
}

class TimeoutException implements Exception {
  final String message;
  TimeoutException(this.message);
  
  @override
  String toString() => 'TimeoutException: $message';
}
