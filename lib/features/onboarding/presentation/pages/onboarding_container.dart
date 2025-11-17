import 'package:flutter/material.dart';
import '../../../../../core/theme/index.dart';
import '../../../authentication/presentation/pages/login_page.dart';
import '../widgets/index.dart';
import 'onboarding_content_one.dart';
import 'onboarding_content_three.dart';
import 'onboarding_content_two.dart';

class OnboardingContainer extends StatefulWidget {
  const OnboardingContainer({super.key});

  @override
  State<OnboardingContainer> createState() => _OnboardingContainerState();
}

class _OnboardingContainerState extends State<OnboardingContainer> {
  int _currentPage = 0;
  final int _totalPages = 3;

  void _nextPage() {
    if (_currentPage < _totalPages - 1) {
      setState(() {
        _currentPage++;
      });
    } else {
      _completeOnboarding();
    }
  }

  void _completeOnboarding() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const LoginPage()),
    );
  }

  void _skipOnboarding() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const LoginPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgLight,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: AppSpacing.xxl),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: AppSpacing.xxl),
              // Content area
              Expanded(
                child: AnimatedSwitcher(
                  duration: AppSpacing.animationSlow,
                  transitionBuilder: (child, animation) {
                    return FadeTransition(
                      opacity: animation,
                      child: ScaleTransition(
                        scale: Tween<double>(begin: 0.95, end: 1.0).animate(animation),
                        child: child,
                      ),
                    );
                  },
                  child: _buildContent(),
                ),
              ),
              // Bottom navigation
              Padding(
                padding: EdgeInsets.only(
                  bottom: AppSpacing.xxl,
                  top: AppSpacing.xxl,
                ),
                child: Column(
                  children: [
                    OnboardingPagination(
                      currentPage: _currentPage,
                      totalPages: _totalPages,
                    ),
                    SizedBox(height: AppSpacing.xxl),
                    OnboardingButtons(
                      onSkip: _skipOnboarding,
                      onNext: _nextPage,
                      nextLabel: _currentPage == _totalPages - 1 ? 'Get Started' : 'Lanjut',
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildContent() {
    switch (_currentPage) {
      case 0:
        return const OnboardingContentOne(key: ValueKey(0));
      case 1:
        return const OnboardingContentTwo(key: ValueKey(1));
      case 2:
        return const OnboardingContentThree(key: ValueKey(2));
      default:
        return const OnboardingContentOne(key: ValueKey(0));
    }
  }
}
