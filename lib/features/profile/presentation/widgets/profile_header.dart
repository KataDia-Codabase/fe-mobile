import 'dart:io';
import 'package:flutter/material.dart';
import 'package:katadia_fe/core/theme/index.dart';
import 'package:katadia_fe/core/utils/index.dart';

class ProfileHeader extends StatelessWidget {
  final String title;
  final String subtitle;

  const ProfileHeader({
    super.key,
    this.title = 'Profile & Settings',
    this.subtitle = 'Manage your account',
  });

  @override
  Widget build(BuildContext context) {
    final paddingTop = MediaQuery.of(context).padding.top;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(
        AppSpacing.xxl,
        paddingTop + AppSpacing.md,
        AppSpacing.xxl,
        AppSpacing.xl,
      ),
      decoration: BoxDecoration(
        gradient: AppColors.primaryGradient,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(AppSpacing.radiusFull),
          bottomRight: Radius.circular(AppSpacing.radiusFull),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: AppTextStyles.heading3.copyWith(color: Colors.white),
          ),
          SizedBox(height: AppSpacing.xs),
          Text(
            subtitle,
            style: AppTextStyles.bodySmall.copyWith(
              color: Colors.white.withValues(alpha: 0.9),
            ),
          ),
        ],
      ),
    );
  }
}

class ProfileOverviewCard extends StatelessWidget {
  final String userName;
  final String email;
  final String levelLabel;
  final String cefrLabel;
  final int totalXp;
  final int streakDays;
  final int lessonsCompleted;
  final String? avatarPath;

  const ProfileOverviewCard({
    super.key,
    required this.userName,
    required this.email,
    required this.levelLabel,
    required this.cefrLabel,
    required this.totalXp,
    required this.streakDays,
    required this.lessonsCompleted,
    this.avatarPath,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(AppSpacing.xl),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppSpacing.radiusXL),
        boxShadow: AppShadows.medium,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildAvatarContainer(),
              SizedBox(width: AppSpacing.lg),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      userName,
                      style: AppTextStyles.heading3,
                    ),
                    SizedBox(height: AppSpacing.xs),
                    Text(
                      email,
                      style: AppTextStyles.bodySmall.copyWith(
                        color: AppColors.textMedium,
                      ),
                    ),
                    SizedBox(height: AppSpacing.sm),
                    Wrap(
                      spacing: AppSpacing.sm,
                      runSpacing: AppSpacing.sm,
                      children: [
                        _Badge(label: levelLabel, backgroundColor: AppColors.accentYellow.withValues(alpha: 0.2), textColor: AppColors.accentYellow),
                        _Badge(label: cefrLabel, backgroundColor: AppColors.bgDisabled, textColor: AppColors.textDark),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: AppSpacing.xl),
          Row(
            children: [
              _ProfileStatTile(
                value: StringFormatter.formatNumber(totalXp),
                label: 'Total XP',
              ),
              SizedBox(width: AppSpacing.md),
              _ProfileStatTile(
                value: streakDays.toString(),
                label: 'Day Streak',
              ),
              SizedBox(width: AppSpacing.md),
              _ProfileStatTile(
                value: lessonsCompleted.toString(),
                label: 'Lessons',
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAvatarContent() {
    if (avatarPath != null && avatarPath!.isNotEmpty) {
      // Try to load image from file path
      try {
        final imageFile = File(avatarPath!);
        if (imageFile.existsSync()) {
          return ClipOval(
            child: Image.file(
              imageFile,
              fit: BoxFit.cover,
              width: 64,
              height: 64,
              errorBuilder: (context, error, stackTrace) {
                return const Text(
                  '🧑‍🎓',
                  style: TextStyle(fontSize: 32),
                );
              },
            ),
          );
        } else {
          return const Text(
            '🧑‍🎓',
            style: TextStyle(fontSize: 32),
          );
        }
      } catch (e) {
        return const Text(
          '🧑‍🎓',
          style: TextStyle(fontSize: 32),
        );
      }
    }
    // Default emoji
    return const Text(
      '🧑‍🎓',
      style: TextStyle(fontSize: 32),
    );
  }

  Widget _buildAvatarContainer() {
    return Container(
      width: 64,
      height: 64,
      decoration: BoxDecoration(
        color: AppColors.bgLight,
        shape: BoxShape.circle,
        border: Border.all(
          color: AppColors.borderLight,
          width: 2,
        ),
      ),
      alignment: Alignment.center,
      child: _buildAvatarContent(),
    );
  }
}

class _ProfileStatTile extends StatelessWidget {
  final String value;
  final String label;

  const _ProfileStatTile({
    required this.value,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.symmetric(
          vertical: AppSpacing.md,
        ),
        decoration: BoxDecoration(
          color: AppColors.bgLight,
          borderRadius: BorderRadius.circular(AppSpacing.radiusLarge),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              value,
              style: AppTextStyles.statValue,
            ),
            SizedBox(height: AppSpacing.xs),
            Text(
              label,
              style: AppTextStyles.labelSmall.copyWith(
                color: AppColors.textMedium,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Badge extends StatelessWidget {
  final String label;
  final Color backgroundColor;
  final Color textColor;

  const _Badge({
    required this.label,
    required this.backgroundColor,
    required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.xs,
      ),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(AppSpacing.radiusMedium),
      ),
      child: Text(
        label,
        style: AppTextStyles.labelSmall.copyWith(
          color: textColor,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
