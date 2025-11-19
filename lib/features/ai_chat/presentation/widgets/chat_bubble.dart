import 'package:flutter/material.dart';
import '../../../../../core/theme/index.dart';
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

    return Align(
      alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Column(
        crossAxisAlignment:
            isUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: AppSpacing.lg),
            padding: EdgeInsets.symmetric(
              horizontal: AppSpacing.lg,
              vertical: AppSpacing.md,
            ),
            decoration: BoxDecoration(
              color: isUser
                  ? AppColors.primary
                  : AppColors.primary.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(AppSpacing.radiusMedium),
            ),
            child: Column(
              crossAxisAlignment: isUser
                  ? CrossAxisAlignment.end
                  : CrossAxisAlignment.start,
              children: [
                Text(
                  message.content,
                  style: AppTextStyles.bodyMedium.copyWith(
                    color: isUser ? Colors.white : AppColors.textDark,
                  ),
                ),
                if (message.audioUrl != null && !isUser) ...[
                  SizedBox(height: AppSpacing.sm),
                  GestureDetector(
                    onTap: onPlayAudio,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.play_circle_outline,
                          size: 16,
                          color: AppColors.primary,
                        ),
                        SizedBox(width: AppSpacing.xs),
                        Text(
                          'Play Audio',
                          style: AppTextStyles.labelSmall.copyWith(
                            color: AppColors.primary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ],
            ),
          ),
          SizedBox(height: AppSpacing.xs),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: AppSpacing.lg),
            child: Text(
              _formatTime(message.timestamp),
              style: AppTextStyles.bodySmall.copyWith(
                color: AppColors.textLight,
              ),
            ),
          ),
          SizedBox(height: AppSpacing.lg),
        ],
      ),
    );
  }

  String _formatTime(DateTime time) {
    return '${time.hour}:${time.minute.toString().padLeft(2, '0')}';
  }
}
