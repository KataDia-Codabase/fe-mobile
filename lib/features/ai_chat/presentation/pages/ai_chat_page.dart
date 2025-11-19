import 'package:flutter/material.dart';
import '../../../../../core/theme/index.dart';
import '../../../../../core/utils/index.dart';
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

  final List<String> _suggestedTopics = [
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
    // Initial AI message
    final initialMessage = ChatMessage(
      id: '0',
      content:
          "Hello! I'm your AI conversation partner. Let's practice English together! What would you like to talk about today?",
      role: MessageRole.assistant,
      timestamp: DateTime.now(),
      audioUrl: '', // In real app, this would be an actual audio URL
    );

    setState(() {
      _messages.add(initialMessage);
    });

    Logger.info('AI Chat initialized', tag: 'AiChat');
  }

  void _sendMessage(String message) {
    if (message.isEmpty) return;

    // Add user message
    final userMessage = ChatMessage(
      id: DateTime.now().toString(),
      content: message,
      role: MessageRole.user,
      timestamp: DateTime.now(),
    );

    setState(() {
      _messages.add(userMessage);
      _isLoading = true;
    });

    Logger.info('User message: $message', tag: 'AiChat');

    // Simulate AI response delay
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        final aiMessage = ChatMessage(
          id: DateTime.now().toString(),
          content:
              'That\'s great! Tell me more about that. I\'d love to hear your thoughts on this topic.',
          role: MessageRole.assistant,
          timestamp: DateTime.now(),
          audioUrl: '', // In real app, this would be real audio
        );

        setState(() {
          _messages.add(aiMessage);
          _isLoading = false;
        });

        Logger.success('AI response received', tag: 'AiChat');
      }
    });
  }

  void _selectTopic(String topic) {
    final message = 'Let\'s talk about $topic';
    _sendMessage(message);
  }

  void _playAudio() {
    Logger.info('Playing audio message', tag: 'AiChat');
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Playing audio...')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgLight,
      body: Column(
        children: [
          // Header
          ChatHeader(
            onBack: () => Navigator.pop(context),
            messages: _messages.length,
            topics: 3,
            xp: 120,
          ),
          // Chat messages
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
                    reverse: true,
                    itemCount: _messages.length,
                    itemBuilder: (context, index) {
                      final message = _messages[_messages.length - 1 - index];
                      return ChatBubble(
                        message: message,
                        onPlayAudio: _playAudio,
                      );
                    },
                  ),
          ),
          // Suggested topics (if no user messages yet)
          if (_messages.length <= 1)
            SuggestedTopics(
              topics: _suggestedTopics,
              onTopicSelect: _selectTopic,
            ),
          // Chat input
          ChatInput(
            onSend: _sendMessage,
            isLoading: _isLoading,
          ),
        ],
      ),
    );
  }
}
