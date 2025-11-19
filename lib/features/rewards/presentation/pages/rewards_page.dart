import 'package:flutter/material.dart';
import '../../../../../core/theme/index.dart';
import '../widgets/index.dart';

class RewardsPage extends StatefulWidget {
  const RewardsPage({super.key});

  @override
  State<RewardsPage> createState() => _RewardsPageState();
}

class _RewardsPageState extends State<RewardsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgLight,
      body: SingleChildScrollView(
        child: Column(
          children: [
            RewardsHeader(onBack: () => Navigator.pop(context)),
            Padding(
              padding: const EdgeInsets.all(AppSpacing.lg),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  LevelCard(),
                  SizedBox(height: AppSpacing.lg),
                  DailyStreakCard(),
                  SizedBox(height: AppSpacing.lg),
                  BadgesSection(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
