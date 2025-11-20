import 'package:flutter/material.dart';
import 'package:katadia_fe/core/theme/index.dart';
import 'package:katadia_fe/core/utils/index.dart';
import '../../domain/entities/chat_message_entity.dart';
import '../widgets/index.dart';

class AIChatPage extends StatefulWidget {
  const AIChatPage({super.key});

  @override
  State<AIChatPage> createState() => _AIChatPageState();
}

class _AIChatPageState extends State<AIChatPage> {
  late List<ChatMessage> _messages;
  bool _isLoading = false;

  final List<String> _suggestedTopics = const [
    'Daily routine',
    'Hobbies',
    'Travel',
    'Food',
  ];

  @override
  void initState() {
    super.initState();
    _messages = [];
    _initializeChat();
  }

  void _initializeChat() {
    final initialMessage = ChatMessage(
      id: '0',
      content:
          "Hi! I'm your AI assistant. How can I help you learn today?",
      role: MessageRole.assistant,
      timestamp: DateTime.now(),
    );

    setState(() {
      _messages.add(initialMessage);
    });

    Logger.info('AI Chat initialized', tag: 'AiChat');
  }

  void _sendMessage(String message) {
    if (message.isEmpty) return;

    final userMessage = ChatMessage(
      id: DateTime.now().toIso8601String(),
      content: message,
      role: MessageRole.user,
      timestamp: DateTime.now(),
    );

    setState(() {
      _messages.add(userMessage);
      _isLoading = true;
    });

    Logger.info('User message: $message', tag: 'AiChat');

    Future.delayed(const Duration(seconds: 2), () {
      if (!mounted) return;
      final aiMessage = ChatMessage(
        id: DateTime.now().toIso8601String(),
        content:
            'Great! Let’s keep going. Would you like to continue with daily activities vocabulary?',
        role: MessageRole.assistant,
        timestamp: DateTime.now(),
      );

      setState(() {
        _messages.add(aiMessage);
        _isLoading = false;
      });

      Logger.success('AI response received', tag: 'AiChat');
    });
  }

  void _selectTopic(String topic) {
    _sendMessage('I want to practice talking about $topic.');
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
            onInfo: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('AI chat helps you practice conversations.')),
              );
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
                    itemBuilder: (context, index) {
                      final message = _messages[index];
                      return ChatBubble(
                        message: message,
                        onPlayAudio: _playAudio,
                      );
                    },
                  ),
          ),
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
}
