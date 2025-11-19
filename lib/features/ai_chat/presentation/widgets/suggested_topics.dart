import 'package:flutter/material.dart';
import '../../../../../core/theme/index.dart';

class SuggestedTopics extends StatelessWidget {
  final List<String> topics;
  final Function(String) onTopicSelect;

  const SuggestedTopics({
    super.key,
    required this.topics,
    required this.onTopicSelect,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: AppSpacing.lg),
          child: Text(
            'Suggested topics:',
            style: AppTextStyles.bodySmall.copyWith(
              color: AppColors.textMedium,
            ),
          ),
        ),
        SizedBox(height: AppSpacing.md),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              SizedBox(width: AppSpacing.lg),
              ...topics.map((topic) {
                return Padding(
                  padding: EdgeInsets.only(right: AppSpacing.md),
                  child: GestureDetector(
                    onTap: () => onTopicSelect(topic),
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: AppSpacing.md,
                        vertical: AppSpacing.sm,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFF9333EA).withValues(alpha: 0.15),
                        borderRadius:
                            BorderRadius.circular(AppSpacing.radiusSmall),
                        border: Border.all(
                          color: const Color(0xFF9333EA).withValues(alpha: 0.3),
                        ),
                      ),
                      child: Text(
                        topic,
                        style: AppTextStyles.labelSmall.copyWith(
                          color: const Color(0xFF9333EA),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                );
              }),
              SizedBox(width: AppSpacing.lg),
            ],
          ),
        ),
      ],
    );
  }
}
