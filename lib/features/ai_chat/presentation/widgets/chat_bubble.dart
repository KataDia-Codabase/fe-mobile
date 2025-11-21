import 'package:flutter/material.dart';
import 'package:katadia_fe/core/theme/index.dart';
import '../../domain/entities/chat_message_entity.dart';

class ChatBubble extends StatelessWidget {
  final ChatMessage message;
  final VoidCallback? onPlayAudio;

  const ChatBubble({
    super.key,
    required this.message,
    this.onPlayAudio,
  });

  @override
  Widget build(BuildContext context) {
    final isUser = message.role == MessageRole.user;
    final bubbleColor = isUser
        ? AppColors.primary
        : AppColors.surface.withValues(alpha: 0.95);

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: AppSpacing.xxl,
        vertical: AppSpacing.sm,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment:
            isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          if (!isUser) ...[
            _ChatAvatar(isUser: false),
            SizedBox(width: AppSpacing.md),
          ],
          Flexible(
            child: Column(
              crossAxisAlignment: isUser
                  ? CrossAxisAlignment.end
                  : CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: AppSpacing.lg,
                    vertical: AppSpacing.md,
                  ),
                  decoration: BoxDecoration(
                    color: bubbleColor,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(AppSpacing.radiusLarge),
                      topRight: Radius.circular(AppSpacing.radiusLarge),
                      bottomLeft: Radius.circular(isUser
                          ? AppSpacing.radiusLarge
                          : AppSpacing.radiusSmall),
                      bottomRight: Radius.circular(isUser
                          ? AppSpacing.radiusSmall
                          : AppSpacing.radiusLarge),
                    ),
                    boxShadow: AppShadows.light,
                  ),
                  child: Column(
                    crossAxisAlignment: isUser
                        ? CrossAxisAlignment.end
                        : CrossAxisAlignment.start,
                    children: [
                      _buildMessageContent(
                        message.content,
                        isUser,
                      ),
                      if (!isUser && message.audioUrl != null)
                        Padding(
                          padding: EdgeInsets.only(top: AppSpacing.sm),
                          child: GestureDetector(
                            onTap: onPlayAudio,
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.play_circle_outline,
                                  size: 18,
                                  color: AppColors.primary,
                                ),
                                SizedBox(width: AppSpacing.xs),
                                Text(
                                  'Play audio',
                                  style: AppTextStyles.labelSmall.copyWith(
                                    color: AppColors.primary,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
                SizedBox(height: AppSpacing.xs),
                Text(
                  _formatTime(message.timestamp),
                  style: AppTextStyles.bodySmall.copyWith(
                    color: AppColors.textLight,
                  ),
                ),
              ],
            ),
          ),
          if (isUser) ...[
            SizedBox(width: AppSpacing.md),
            _ChatAvatar(isUser: true),
          ],
        ],
      ),
    );
  }

  String _formatTime(DateTime time) {
    final hour = time.hour % 12 == 0 ? 12 : time.hour % 12;
    final period = time.hour >= 12 ? 'PM' : 'AM';
    return '$hour:${time.minute.toString().padLeft(2, '0')} $period';
  }

  Widget _buildMessageContent(String content, bool isUser) {
    // Parse markdown bold syntax (**word**)
    final textSpans = _parseMarkdownBold(content, isUser);
    
    return RichText(
      text: TextSpan(
        style: AppTextStyles.bodyMedium.copyWith(
          color: isUser ? Colors.white : AppColors.textDark,
        ),
        children: textSpans,
      ),
    );
  }

  List<TextSpan> _parseMarkdownBold(String text, bool isUser) {
    final List<TextSpan> spans = [];
    final pattern = RegExp(r'\*\*(.+?)\*\*');
    int lastIndex = 0;

    for (final match in pattern.allMatches(text)) {
      // Add regular text before the match
      if (match.start > lastIndex) {
        spans.add(TextSpan(
          text: text.substring(lastIndex, match.start),
        ));
      }

      // Add bold text
      spans.add(TextSpan(
        text: match.group(1),
        style: TextStyle(
          fontWeight: FontWeight.w700,
          color: isUser ? Colors.white : AppColors.textDark,
        ),
      ));

      lastIndex = match.end;
    }

    // Add remaining text
    if (lastIndex < text.length) {
      spans.add(TextSpan(
        text: text.substring(lastIndex),
      ));
    }

    // If no bold found, return single span with original text
    if (spans.isEmpty) {
      spans.add(TextSpan(text: text));
    }

    return spans;
  }
}

class _ChatAvatar extends StatelessWidget {
  final bool isUser;

  const _ChatAvatar({required this.isUser});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 32,
      height: 32,
      decoration: BoxDecoration(
        color: isUser ? AppColors.primary : AppColors.surface,
        shape: BoxShape.circle,
        boxShadow: AppShadows.light,
      ),
      alignment: Alignment.center,
      child: Icon(
        isUser ? Icons.person : Icons.auto_awesome,
        size: 16,
        color: isUser ? Colors.white : AppColors.primary,
      ),
    );
  }
}
