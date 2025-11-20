import 'package:flutter/material.dart';
import 'package:katadia_fe/core/theme/index.dart';

import 'feature_card.dart';

class FeatureGrid extends StatelessWidget {
  final List<HomeFeatureItem> features;

  const FeatureGrid({
    super.key,
    required this.features,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Fitur Pembelajaran',
          style: AppTextStyles.bodyLarge.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: AppSpacing.md),
        LayoutBuilder(
          builder: (context, constraints) {
            const crossAxisCount = 2;
            final spacing = AppSpacing.lg;
            final totalSpacing = spacing * (crossAxisCount - 1);
            final availableWidth = constraints.maxWidth - totalSpacing;
            final itemWidth = availableWidth / crossAxisCount;
            const minItemHeight = 150.0;
            final desiredHeight = itemWidth * 0.8;
            final itemHeight = desiredHeight.clamp(minItemHeight, double.infinity);
            final aspectRatio = itemWidth / itemHeight;

            return GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: EdgeInsets.zero,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: crossAxisCount,
                crossAxisSpacing: spacing,
                mainAxisSpacing: spacing,
                childAspectRatio: aspectRatio,
              ),
              itemCount: features.length,
              itemBuilder: (context, index) {
                final feature = features[index];
                return FeatureCard(
                  icon: feature.icon,
                  title: feature.title,
                  subtitle: feature.subtitle,
                  iconColor: feature.iconColor,
                  backgroundColor: feature.backgroundColor,
                  onTap: feature.onTap,
                );
              },
            );
          },
        ),
      ],
    );
  }
}

class HomeFeatureItem {
  final IconData icon;
  final String title;
  final String subtitle;
  final Color iconColor;
  final Color backgroundColor;
  final VoidCallback? onTap;

  const HomeFeatureItem({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.iconColor,
    required this.backgroundColor,
    this.onTap,
  });
}
