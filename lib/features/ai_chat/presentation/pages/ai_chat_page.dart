import 'package:flutter/material.dart';
import 'package:katadia_fe/core/theme/index.dart';
import 'package:katadia_fe/core/utils/index.dart';
import 'package:katadia_fe/core/utils/network_test.dart';
import 'package:katadia_fe/core/services/gemini_service.dart';
import 'package:katadia_fe/core/services/english_learning_prompt.dart';
import '../../data/repositories/chat_repository.dart';
import '../../domain/entities/chat_message_entity.dart';
import '../widgets/index.dart';

class AIChatPage extends StatefulWidget {
  const AIChatPage({super.key});

  @override
  State<AIChatPage> createState() => _AIChatPageState();
}

class _AIChatPageState extends State<AIChatPage> {
  late List<ChatMessage> _messages;
  late ChatRepository _chatRepository;
  bool _isLoading = false;

  final List<String> _suggestedTopics = const [
    'Daily routine',
    'Hobbies',
    'Travel',
    'Food',
    'Work',
    'Shopping',
    'Weather',
    'Family',
  ];

  // Constants for better maintainability
  static const int _maxRetryAttempts = 3;
  static const Duration _retryDelay = Duration(seconds: 1);
  static const String _defaultErrorMessage = 'Sorry, I could not generate a response. Please try again.';

  @override
  void initState() {
    super.initState();
    _messages = [];
    _initializeChatRepository();
    _initializeChat();
  }

  void _initializeChatRepository() {
    final geminiService = GeminiService();
    _chatRepository = ChatRepository(geminiService: geminiService);
  }

  void _initializeChat() {
    final initialMessage = ChatMessage(
      id: '0',
      content: EnglishLearningPrompt.initialGreeting,
      role: MessageRole.assistant,
      timestamp: DateTime.now(),
    );

    setState(() {
      _messages.add(initialMessage);
    });

    Logger.info('AI Chat initialized with English Learning Prompt', tag: 'AiChat');
  }

  /// Processes AI response text to clean up formatting while preserving asterisks
  String _processAIResponse(String response) {
    if (response.startsWith('Error:')) {
      return response; // Don't process error messages
    }

    // Clean up formatting but preserve asterisks as they are
    String processed = response
        .replaceAll(RegExp(r'\s+'), ' ') // Replace multiple spaces with single space
        .trim(); // Remove leading and trailing whitespace

    return processed;
  }

  /// Creates and adds a user message to the chat
  void _addUserMessage(String content) {
    final userMessage = ChatMessage(
      id: DateTime.now().toIso8601String(),
      content: content,
      role: MessageRole.user,
      timestamp: DateTime.now(),
    );

    setState(() {
      _messages.add(userMessage);
    });
  }

  /// Creates and adds an AI message to the chat
  void _addAIMessage(String content) {
    final processedContent = _processAIResponse(content);
    
    final aiMessage = ChatMessage(
      id: DateTime.now().toIso8601String(),
      content: processedContent.isNotEmpty ? processedContent : _defaultErrorMessage,
      role: MessageRole.assistant,
      timestamp: DateTime.now(),
    );

    setState(() {
      _messages.add(aiMessage);
      _isLoading = false;
    });
  }

  /// Shows error snackbar with proper styling
  void _showErrorSnackBar(String error) {
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error: $error'),
          backgroundColor: Colors.red[400],
          duration: const Duration(seconds: 5),
        ),
      );
    }
  }

  /// Handles loading state changes
  void _setLoadingState(bool isLoading) {
    if (mounted) {
      setState(() {
        _isLoading = isLoading;
      });
    }
  }

  void _sendMessage(String message) async {
    if (message.isEmpty) return;

    _addUserMessage(message);
    _setLoadingState(true);

    Logger.info('User message: $message', tag: 'AiChat');

    try {
      // Get response from Gemini AI with retry logic
      String aiResponse = '';
      int attempts = 0;
      
      while (attempts < _maxRetryAttempts && aiResponse.isEmpty) {
        attempts++;
        aiResponse = await _chatRepository.getAIResponse(message);
        
        // If we got an error response, don't retry immediately
        if (aiResponse.startsWith('Error:')) {
          break;
        }
        
        // If empty, retry once more
        if (aiResponse.isEmpty && attempts < _maxRetryAttempts) {
          await Future.delayed(_retryDelay);
          continue;
        }
      }

      if (!mounted) return;

      _addAIMessage(aiResponse);

      if (!aiResponse.startsWith('Error:')) {
        Logger.success('AI response received from Gemini', tag: 'AiChat');
      } else {
        Logger.warning('AI response contains error: $aiResponse', tag: 'AiChat');
      }
    } catch (e) {
      if (!mounted) return;

      _setLoadingState(false);
      Logger.error('Error getting AI response: $e', tag: 'AiChat');
      _showErrorSnackBar(e.toString());
    }
  }

  void _selectTopic(String topic) async {
    if (topic.isEmpty) return;

    final topicMessage = 'I want to practice talking about $topic. Can you help me with vocabulary and conversation examples?';
    _addUserMessage(topicMessage);
    _setLoadingState(true);

    Logger.info('User selected topic: $topic', tag: 'AiChat');

    try {
      // Get response from Gemini AI with topic-specific prompt
      String aiResponse = await _chatRepository.getAIResponseWithTopic(topicMessage, topic);

      if (!mounted) return;

      _addAIMessage(aiResponse);
      Logger.success('AI response received for topic: $topic', tag: 'AiChat');
    } catch (e) {
      if (!mounted) return;

      _setLoadingState(false);
      Logger.error('Error getting AI response for topic: $e', tag: 'AiChat');
      _showErrorSnackBar(e.toString());
    }
  }

  void _playAudio() {
    Logger.info('Playing audio message', tag: 'AiChat');
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Playing audio...')),
    );
  }

  void _handleMic() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Voice input coming soon!')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgLight,
      body: Column(
        children: [
          ChatHeader(
            onBack: () => Navigator.pop(context),
            onInfo: () async {
              // Run network diagnostics
              final results = await NetworkTest.runDiagnostics();
              
              String message = 'AI chat powered by Gemini helps you practice conversations.\n\n';
              message += 'Network Status:\n';
              message += '• Internet: ${results['internet'] == true ? '✅ Connected' : '❌ No connection'}\n';
              message += '• Gemini API: ${results['gemini_api'] == true ? '✅ Accessible' : '❌ Not accessible'}';
              
              if (results['internet'] != true) {
                message += '\n\n💡 Tip: If using emulator, check Android Studio → Extended Controls → Network settings';
              }
              
              if (mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(message),
                  duration: const Duration(seconds: 8),
                  backgroundColor: results['internet'] == true ? Colors.green[400] : Colors.red[400],
                ),
                );
              }
            },
          ),
          Expanded(
            child: _messages.isEmpty
                ? Center(
                    child: Text(
                      'No messages yet',
                      style: AppTextStyles.bodyMedium.copyWith(
                        color: AppColors.textLight,
                      ),
                    ),
                  )
                : ListView.builder(
                    padding: EdgeInsets.only(top: AppSpacing.lg),
                    itemCount: _messages.length,
                    reverse: true,
                    itemBuilder: (context, index) {
                      final message = _messages[_messages.length - 1 - index];
                      return ChatBubble(
                        message: message,
                        onPlayAudio: _playAudio,
                      );
                    },
                  ),
          ),
          if (!_isLoading)
            SuggestedTopics(
              topics: _suggestedTopics,
              onTopicSelect: _selectTopic,
            ),
          ChatInput(
            onSend: _sendMessage,
            isLoading: _isLoading,
            onMicPressed: _handleMic,
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _chatRepository.resetSession();
    super.dispose();
  }
}
