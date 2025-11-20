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
                      Text(
                        message.content,
                        style: AppTextStyles.bodyMedium.copyWith(
                          color: isUser
                              ? Colors.white
                              : AppColors.textDark,
                        ),
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
