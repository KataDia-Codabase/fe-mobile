import 'package:flutter/material.dart';
import '../../../../../core/theme/index.dart';
import '../../../../../core/utils/index.dart';
import '../../../../../core/pages/home_page.dart';

class CEFRResultsLoadingPage extends StatefulWidget {
  final int correctAnswers;
  final int totalQuestions;
  final VoidCallback? onComplete;

  const CEFRResultsLoadingPage({
    super.key,
    required this.correctAnswers,
    required this.totalQuestions,
    this.onComplete,
  });

  @override
  State<CEFRResultsLoadingPage> createState() => _CEFRResultsLoadingPageState();
}

class _CEFRResultsLoadingPageState extends State<CEFRResultsLoadingPage>
    with TickerProviderStateMixin {
  late List<bool> _completedSteps;
  late int _currentStep;
  late AnimationController _progressController;
  late double _progressValue;

  final List<String> _steps = [
    'Analyzing your responses',
    'Calculating comprehension score',
    'Evaluating grammar proficiency',
    'Determining CEFR level',
  ];

  @override
  void initState() {
    super.initState();
    _completedSteps = List.filled(_steps.length, false);
    _currentStep = 0;
    _progressValue = 0.0;

    _progressController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    _startAnalysis();
  }

  void _startAnalysis() async {
    // Step 1: Analyzing responses
    await Future.delayed(const Duration(milliseconds: 800));
    if (mounted) {
      setState(() {
        _completedSteps[0] = true;
        _currentStep = 1;
        _progressValue = 0.25;
      });
    }

    // Step 2: Calculating comprehension
    await Future.delayed(const Duration(milliseconds: 800));
    if (mounted) {
      setState(() {
        _completedSteps[1] = true;
        _currentStep = 2;
        _progressValue = 0.50;
      });
    }

    // Step 3: Evaluating grammar
    await Future.delayed(const Duration(milliseconds: 800));
    if (mounted) {
      setState(() {
        _completedSteps[2] = true;
        _currentStep = 3;
        _progressValue = 0.75;
      });
    }

    // Step 4: Determining CEFR level
    await Future.delayed(const Duration(milliseconds: 800));
    if (mounted) {
      setState(() {
        _completedSteps[3] = true;
        _currentStep = 4;
        _progressValue = 1.0;
      });
    }

    // Complete - navigate to home page
    await Future.delayed(const Duration(seconds: 1));
    if (mounted) {
      Logger.success('Assessment analysis completed', tag: 'CEFRResults');
      widget.onComplete?.call();
      
      // Navigate to home page and remove all previous routes
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (_) => const HomePage()),
        (route) => false,
      );
    }
  }

  @override
  void dispose() {
    _progressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgLight,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: AppSpacing.xxl),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Brain Icon
                  Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: BorderRadius.circular(AppSpacing.radiusXL),
                      boxShadow: AppShadows.medium,
                    ),
                    child: Icon(
                      Icons.psychology,
                      size: 50,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: AppSpacing.xxxl),
                  // Title
                  Text(
                    'Analyzing Your Results',
                    textAlign: TextAlign.center,
                    style: AppTextStyles.heading2,
                  ),
                  SizedBox(height: AppSpacing.sm),
                  // Subtitle
                  Text(
                    'Please wait while we evaluate your performance...',
                    textAlign: TextAlign.center,
                    style: AppTextStyles.bodyLarge.copyWith(
                      color: AppColors.textMedium,
                    ),
                  ),
                  SizedBox(height: AppSpacing.xxxl + AppSpacing.xl),
                  // Steps
                  ..._steps.asMap().entries.map((entry) {
                    final index = entry.key;
                    final step = entry.value;
                    final isCompleted = _completedSteps[index];
                    final isActive = _currentStep > index;

                    return Column(
                      children: [
                        Row(
                          children: [
                            Container(
                              width: 32,
                              height: 32,
                              decoration: BoxDecoration(
                                color: isCompleted
                                    ? AppColors.accentGreen
                                    : isActive
                                        ? AppColors.primary
                                        : AppColors.borderLight,
                                shape: BoxShape.circle,
                              ),
                              child: isCompleted
                                  ? Icon(
                                      Icons.check,
                                      color: Colors.white,
                                      size: 18,
                                    )
                                  : isActive
                                      ? Icon(
                                          Icons.schedule,
                                          color: Colors.white,
                                          size: 18,
                                        )
                                      : null,
                            ),
                            SizedBox(width: AppSpacing.lg),
                            Expanded(
                              child: Text(
                                step,
                                style: AppTextStyles.bodyMedium.copyWith(
                                  color: isCompleted || isActive
                                      ? AppColors.textDark
                                      : AppColors.textLight,
                                  fontWeight: isCompleted
                                      ? FontWeight.w600
                                      : FontWeight.w400,
                                ),
                              ),
                            ),
                          ],
                        ),
                        if (index < _steps.length - 1)
                          Column(
                            children: [
                              SizedBox(height: AppSpacing.md),
                            ],
                          ),
                        if (index < _steps.length - 1)
                          SizedBox(height: AppSpacing.md),
                      ],
                    );
                  }),
                  SizedBox(height: AppSpacing.xxxl + AppSpacing.xl),
                  // Progress Bar
                  ClipRRect(
                    borderRadius: BorderRadius.circular(AppSpacing.radiusSmall),
                    child: LinearProgressIndicator(
                      value: _progressValue,
                      minHeight: 6,
                      backgroundColor: AppColors.bgLight,
                      valueColor:
                          AlwaysStoppedAnimation<Color>(AppColors.primary),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
