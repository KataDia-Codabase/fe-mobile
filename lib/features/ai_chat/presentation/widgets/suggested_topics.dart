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
    return Padding(
      padding: EdgeInsets.only(
        top: AppSpacing.md,
        left: AppSpacing.xxl,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(
                Icons.lightbulb_outline,
                color: AppColors.accentYellow,
                size: 16,
              ),
              SizedBox(width: AppSpacing.sm),
              Text(
                'Suggested topics:',
                style: AppTextStyles.bodySmall.copyWith(
                  color: AppColors.textMedium,
                ),
              ),
            ],
          ),
          SizedBox(height: AppSpacing.md),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
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
                          color: AppColors.surface,
                          borderRadius:
                              BorderRadius.circular(AppSpacing.radiusLarge),
                          boxShadow: AppShadows.light,
                        ),
                        child: Text(
                          topic,
                          style: AppTextStyles.labelSmall.copyWith(
                            color: AppColors.primary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  );
                }),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
