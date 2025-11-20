import 'package:flutter/material.dart';
import 'package:katadia_fe/core/theme/index.dart';

import 'cefr_assessment_result_page.dart';

class CEFRAssessmentProcessingPage extends StatefulWidget {
  const CEFRAssessmentProcessingPage({super.key});

  @override
  State<CEFRAssessmentProcessingPage> createState() => _CEFRAssessmentProcessingPageState();
}

class _CEFRAssessmentProcessingPageState extends State<CEFRAssessmentProcessingPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _progressAnimation;
  int _currentStep = 0;

  final List<String> _steps = const [
    'Analyzing your responses',
    'Calculating comprehension score',
    'Evaluating grammar proficiency',
    'Determining CEFR level',
  ];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 12),
    );
    _progressAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    _controller.addListener(() {
      final totalSteps = _steps.length;
      final progressPerStep = 1 / totalSteps;
      final newStep = (_controller.value / progressPerStep).floor().clamp(0, totalSteps - 1);
      if (newStep != _currentStep) {
        setState(() => _currentStep = newStep);
      }
      if (_controller.isCompleted) {
        _goToResults();
      }
    });

    _controller.forward();
  }

  void _goToResults() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => const CEFRAssessmentResultPage(),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgLight,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: AppSpacing.xxl),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _AnimatedBrainIcon(controller: _controller),
                SizedBox(height: AppSpacing.xxxl),
                Text(
                  'Analyzing Your Results',
                  style: AppTextStyles.heading3.copyWith(color: AppColors.textDark),
                ),
                SizedBox(height: AppSpacing.sm),
                Text(
                  'Please wait while we evaluate your performance...',
                  textAlign: TextAlign.center,
                  style: AppTextStyles.bodyMedium.copyWith(color: AppColors.textMedium),
                ),
                SizedBox(height: AppSpacing.xxxl),
                ..._steps.asMap().entries.map(
                  (entry) => _StepItem(
                    label: entry.value,
                    isCompleted: entry.key < _currentStep,
                    isActive: entry.key == _currentStep,
                  ),
                ),
                SizedBox(height: AppSpacing.xxxl),
                AnimatedBuilder(
                  animation: _progressAnimation,
                  builder: (context, child) {
                    return ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: LinearProgressIndicator(
                        value: _progressAnimation.value,
                        minHeight: 8,
                        backgroundColor: AppColors.borderLight,
                        valueColor: const AlwaysStoppedAnimation(AppColors.primary),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _AnimatedBrainIcon extends StatelessWidget {
  final AnimationController controller;

  const _AnimatedBrainIcon({required this.controller});

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) {
        final scale = 1 + (controller.value * 0.05);
        return Transform.scale(
          scale: scale,
          child: Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.circular(AppSpacing.radiusXL),
              boxShadow: AppShadows.medium,
            ),
            child: const Icon(
              Icons.psychology_rounded,
              color: Colors.white,
              size: 48,
            ),
          ),
        );
      },
    );
  }
}

class _StepItem extends StatelessWidget {
  final String label;
  final bool isCompleted;
  final bool isActive;

  const _StepItem({
    required this.label,
    required this.isCompleted,
    required this.isActive,
  });

  @override
  Widget build(BuildContext context) {
    Color iconColor;
    IconData icon;

    if (isCompleted) {
      iconColor = AppColors.accentGreen;
      icon = Icons.check_circle;
    } else if (isActive) {
      iconColor = AppColors.primary;
      icon = Icons.radio_button_checked;
    } else {
      iconColor = AppColors.borderLight;
      icon = Icons.radio_button_unchecked;
    }

    return Padding(
      padding: EdgeInsets.only(bottom: AppSpacing.md),
      child: Row(
        children: [
          Icon(icon, color: iconColor),
          SizedBox(width: AppSpacing.md),
          Expanded(
            child: Text(
              label,
              style: AppTextStyles.bodyMedium.copyWith(
                color: isCompleted || isActive ? AppColors.textDark : AppColors.textLight,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
