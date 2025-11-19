enum MessageRole { user, assistant }

class ChatMessage {
  final String id;
  final String content;
  final MessageRole role;
  final DateTime timestamp;
  final String? audioUrl;

  const ChatMessage({
    required this.id,
    required this.content,
    required this.role,
    required this.timestamp,
    this.audioUrl,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ChatMessage &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;
}
