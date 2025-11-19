import 'package:flutter/material.dart';
import '../../../../../core/theme/index.dart';

class ChatInput extends StatefulWidget {
  final Function(String) onSend;
  final bool isLoading;

  const ChatInput({
    super.key,
    required this.onSend,
    this.isLoading = false,
  });

  @override
  State<ChatInput> createState() => _ChatInputState();
}

class _ChatInputState extends State<ChatInput> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _sendMessage() {
    final message = _controller.text.trim();
    if (message.isNotEmpty) {
      widget.onSend(message);
      _controller.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: AppColors.surface,
        border: Border(
          top: BorderSide(
            color: AppColors.borderLight,
            width: 1,
          ),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _controller,
              enabled: !widget.isLoading,
              decoration: InputDecoration(
                hintText: 'Type your message...',
                hintStyle: AppTextStyles.bodyMedium.copyWith(
                  color: AppColors.textLight,
                ),
                border: OutlineInputBorder(
                  borderRadius:
                      BorderRadius.circular(AppSpacing.radiusMedium),
                  borderSide: BorderSide(
                    color: AppColors.borderLight,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius:
                      BorderRadius.circular(AppSpacing.radiusMedium),
                  borderSide: BorderSide(
                    color: AppColors.borderLight,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius:
                      BorderRadius.circular(AppSpacing.radiusMedium),
                  borderSide: BorderSide(
                    color: const Color(0xFF9333EA),
                    width: 2,
                  ),
                ),
                contentPadding: EdgeInsets.symmetric(
                  horizontal: AppSpacing.lg,
                  vertical: AppSpacing.md,
                ),
              ),
              style: AppTextStyles.bodyMedium,
              minLines: 1,
              maxLines: 3,
            ),
          ),
          SizedBox(width: AppSpacing.md),
          GestureDetector(
            onTap: widget.isLoading ? null : _sendMessage,
            child: Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: const Color(0xFF9333EA),
                shape: BoxShape.circle,
              ),
              child: widget.isLoading
                  ? Padding(
                      padding: EdgeInsets.all(AppSpacing.md),
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor:
                            AlwaysStoppedAnimation<Color>(Colors.white),
                      ),
                    )
                  : Icon(
                      Icons.send,
                      color: Colors.white,
                      size: 20,
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
