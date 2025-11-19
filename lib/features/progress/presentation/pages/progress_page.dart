import 'package:flutter/material.dart';
import '../../../../../core/theme/index.dart';
import '../widgets/index.dart';

class ProgressPage extends StatefulWidget {
  const ProgressPage({super.key});

  @override
  State<ProgressPage> createState() => _ProgressPageState();
}

class _ProgressPageState extends State<ProgressPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgLight,
      body: SingleChildScrollView(
        child: Column(
          children: [
            ProgressHeader(onBack: () => Navigator.pop(context)),
            Padding(
              padding: const EdgeInsets.all(AppSpacing.lg),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  StreakGoalSection(),
                  SizedBox(height: AppSpacing.lg),
                  WeeklyActivitySection(),
                  SizedBox(height: AppSpacing.lg),
                  SkillProgressSection(),
                  SizedBox(height: AppSpacing.lg),
                  RecentActivitySection(),
                  SizedBox(height: AppSpacing.lg),
                  AchievementsSection(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
