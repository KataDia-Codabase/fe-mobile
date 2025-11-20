import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:katadia_fe/core/theme/index.dart';
import 'package:katadia_fe/features/authentication/domain/entities/user_entity.dart';

import '../widgets/index.dart';

class ProfilePage extends StatelessWidget {
  final User? user;

  const ProfilePage({super.key, this.user});

  int _calculateLevel(int xp) => (xp / 100).floor().clamp(1, 60);

  @override
  Widget build(BuildContext context) {
    final userName = user?.name ?? 'Sarah Anderson';
    final email = user?.email ?? 'sarah.anderson@email.com';
    final totalXp = user?.xp ?? 1250;
    final streakDays = user?.streak ?? 6;
    final lessonsCompleted = 12;
    final cefr = user?.cefrLevel ?? 'B1';
    final cefrLabel = '${cefr.toUpperCase()} CEFR';
    final levelLabel = 'Level ${_calculateLevel(totalXp)}';

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light.copyWith(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.dark,
      ),
      child: SafeArea(
        top: false,
        bottom: false,
        child: SingleChildScrollView(
          padding: EdgeInsets.only(bottom: AppSpacing.xxxl + AppSpacing.lg),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const ProfileHeader(),
              SizedBox(height: AppSpacing.xxxl),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: AppSpacing.xxl),
                child: ProfileOverviewCard(
                  userName: userName,
                  email: email,
                  levelLabel: levelLabel,
                  cefrLabel: cefrLabel,
                  totalXp: totalXp,
                  streakDays: streakDays,
                  lessonsCompleted: lessonsCompleted,
                ),
              ),
              SizedBox(height: AppSpacing.xxxl),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: AppSpacing.xxl),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AccountSection(
                      userName: userName,
                      email: email,
                    ),
                    SizedBox(height: AppSpacing.xxxl),
                    const PreferencesSection(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
