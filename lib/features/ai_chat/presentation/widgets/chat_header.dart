import 'package:flutter/material.dart';
import '../../../../../core/theme/index.dart';

class ChatHeader extends StatelessWidget {
  final VoidCallback onBack;
  final int messages;
  final int topics;
  final int xp;

  const ChatHeader({
    super.key,
    required this.onBack,
    this.messages = 0,
    this.topics = 0,
    this.xp = 0,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            const Color(0xFF9333EA),
            const Color(0xFFBB86FC),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(AppSpacing.lg),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Back button and title
              Row(
                children: [
                  IconButton(
                    onPressed: onBack,
                    icon: const Icon(Icons.arrow_back),
                    color: Colors.white,
                    padding: EdgeInsets.zero,
                    constraints: BoxConstraints(
                      minWidth: AppSpacing.inputHeight,
                      minHeight: AppSpacing.inputHeight,
                    ),
                  ),
                  SizedBox(width: AppSpacing.md),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'AI Chat Partner',
                        style: AppTextStyles.labelLarge.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(height: AppSpacing.xs),
                      Text(
                        'Always ready to chat',
                        style: AppTextStyles.bodySmall.copyWith(
                          color: Colors.white.withValues(alpha: 0.8),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: AppSpacing.lg),
              // Stats
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _StatItem(
                    label: 'Messages',
                    value: messages.toString(),
                  ),
                  _StatItem(
                    label: 'Topics',
                    value: topics.toString(),
                  ),
                  _StatItem(
                    label: 'XP',
                    value: xp.toString(),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _StatItem extends StatelessWidget {
  final String label;
  final String value;

  const _StatItem({
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          value,
          style: AppTextStyles.heading2.copyWith(
            color: Colors.white,
          ),
        ),
        SizedBox(height: AppSpacing.xs),
        Text(
          label,
          style: AppTextStyles.bodySmall.copyWith(
            color: Colors.white.withValues(alpha: 0.8),
          ),
        ),
      ],
    );
  }
}
