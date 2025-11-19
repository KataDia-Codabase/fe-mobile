import 'package:flutter/material.dart';
import '../../../../../core/theme/index.dart';
import '../../../../../core/utils/index.dart';
import '../../data/sample_questions.dart';
import 'cefr_question_page.dart';
import '../widgets/index.dart';

class CEFRAssessmentPage extends StatelessWidget {
  const CEFRAssessmentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgLight,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: AppSpacing.xxl),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: AppSpacing.xxl),
                // Header
                Text(
                  'CEFR Level\nAssessment',
                  style: AppTextStyles.heading1,
                ),
                SizedBox(height: AppSpacing.xs),
                Text(
                  'Discover your English proficiency level',
                  style: AppTextStyles.bodyLarge.copyWith(
                    color: AppColors.textMedium,
                  ),
                ),
                SizedBox(height: AppSpacing.xxxl + AppSpacing.lg),
                // Icon and Badge
                Center(
                  child: CEFRIconBadge(),
                ),
                SizedBox(height: AppSpacing.xxxl + AppSpacing.lg),
                // What is CEFR Section
                Container(
                  padding: EdgeInsets.all(AppSpacing.lg),
                  decoration: BoxDecoration(
                    color: AppColors.surface,
                    borderRadius: BorderRadius.circular(AppSpacing.radiusLarge),
                    boxShadow: AppShadows.light,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'What is CEFR?',
                        style: AppTextStyles.labelLarge.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: AppSpacing.md),
                      Text(
                        'The Common European Framework of Reference for Languages assesses your English abilities from A1 (Beginner) to C2 (Mastery).',
                        style: AppTextStyles.bodySmall.copyWith(
                          color: AppColors.textMedium,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: AppSpacing.xxl),
                // Features Section
                Text(
                  'What You\'ll Get',
                  style: AppTextStyles.labelLarge.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: AppSpacing.lg),
                CEFRFeatureItem(
                  icon: Icons.timer,
                  title: '15 Minutes',
                  subtitle: 'Quick assessment',
                  iconColor: AppColors.primary,
                ),
                SizedBox(height: AppSpacing.md),
                CEFRFeatureItem(
                  icon: Icons.headphones,
                  title: 'Listening & Reading',
                  subtitle: 'Test your comprehension abilities',
                  iconColor: AppColors.accentGreen,
                ),
                SizedBox(height: AppSpacing.md),
                CEFRFeatureItem(
                  icon: Icons.flash_on,
                  title: 'Instant Results',
                  subtitle: 'Get your CEFR level immediately',
                  iconColor: AppColors.accentYellow,
                ),
                SizedBox(height: AppSpacing.xxxl),
                // CEFR Levels Section
                Text(
                  'CEFR Levels',
                  style: AppTextStyles.labelLarge.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: AppSpacing.lg),
                CEFRLevelCard(level: 'A1', title: 'Beginner'),
                SizedBox(height: AppSpacing.md),
                CEFRLevelCard(level: 'A2', title: 'Elementary'),
                SizedBox(height: AppSpacing.md),
                CEFRLevelCard(level: 'B1', title: 'Intermediate'),
                SizedBox(height: AppSpacing.md),
                CEFRLevelCard(level: 'B2', title: 'Upper Intermediate'),
                SizedBox(height: AppSpacing.md),
                CEFRLevelCard(level: 'C1', title: 'Advanced'),
                SizedBox(height: AppSpacing.md),
                CEFRLevelCard(level: 'C2', title: 'Mastery'),
                SizedBox(height: AppSpacing.xxxl),
                // Start Assessment Button
                SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: ElevatedButton(
                    onPressed: () => _startAssessment(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(AppSpacing.radiusLarge),
                      ),
                      elevation: 0,
                      textStyle: AppTextStyles.button,
                    ),
                    child: const Text('Start Assessment'),
                  ),
                ),
                SizedBox(height: AppSpacing.md),
                // Disclaimer
                Text(
                  'Your results will help personalize your learning journey',
                  textAlign: TextAlign.center,
                  style: AppTextStyles.bodySmall.copyWith(
                    color: AppColors.textLight,
                  ),
                ),
                SizedBox(height: AppSpacing.xxxl),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _startAssessment(BuildContext context) {
    Logger.info('Starting CEFR Assessment with ${sampleQuestions.length} questions', tag: 'CEFRAssessment');
    
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => CEFRQuestionPage(
          questions: sampleQuestions,
          onComplete: () {
            Logger.success('CEFR Assessment completed', tag: 'CEFRAssessment');
          },
        ),
      ),
    );
  }
}
