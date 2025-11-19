import 'package:flutter/material.dart';
import '../../../../../core/utils/index.dart';

class OnboardingPageThree extends StatelessWidget {
  const OnboardingPageThree({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F7FD),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.topRight,
                child: TextButton(
                  onPressed: () => _skipOnboarding(context),
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    foregroundColor: const Color(0xFF6B7A99),
                    textStyle: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  child: const Text('Skip'),
                ),
              ),
              const SizedBox(height: 24),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 28,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(32),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFF1D2A44).withValues(alpha: 0.08),
                            blurRadius: 32,
                            offset: const Offset(0, 18),
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // Chat Bubble Container
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 12,
                            ),
                            decoration: BoxDecoration(
                              color: const Color(0xFFF0F4F8),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: const Text(
                              "Hi! I'm your AI tutor. Let's chat!",
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w400,
                                color: Color(0xFF0F172A),
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),
                          // Chat Bubble Container 2
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 12,
                            ),
                            decoration: BoxDecoration(
                              color: const Color(0xFF2F6BFF),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: const Text(
                              "How can I improve my accent?",
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w400,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),
                          // Chat Bubble Container 3
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 12,
                            ),
                            decoration: BoxDecoration(
                              color: const Color(0xFFF0F4F8),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: const Text(
                              "Practice with me! Try saying: 'Where is the library?'",
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w400,
                                color: Color(0xFF0F172A),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 40),
                    const Text(
                      'Practice Conversations\nwith AI',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF0F172A),
                        height: 1.25,
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'Chat with our AI tutor anytime, anywhere.\nGet real-time corrections and improve your\nEnglish through natural conversations.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                        color: Color(0xFF7C89A2),
                        height: 1.5,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 32, top: 24),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        _ProgressDot(),
                        _ProgressDot(),
                        _ProgressDot(isActive: true),
                      ],
                    ),
                    const SizedBox(height: 24),
                    SizedBox(
                      width: double.infinity,
                      height: 56,
                      child: ElevatedButton(
                        onPressed: () => _completeOnboarding(context),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF2F6BFF),
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18),
                          ),
                          elevation: 0,
                          textStyle: const TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        child: const Text('Get Started'),
                      ),
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

  void _completeOnboarding(BuildContext context) {
    Logger.info('Completing onboarding from page 3', tag: 'Onboarding');
    Navigator.pushNamedAndRemoveUntil(
      context,
      '/login',
      (route) => false,
    );
  }

  void _skipOnboarding(BuildContext context) {
    Logger.info('Skipping onboarding from page 3', tag: 'Onboarding');
    Navigator.pushNamedAndRemoveUntil(
      context,
      '/login',
      (route) => false,
    );
  }
}

class _ProgressDot extends StatelessWidget {
  const _ProgressDot({this.isActive = false});

  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: isActive ? 24 : 8,
      height: 8,
      margin: const EdgeInsets.symmetric(horizontal: 4),
      decoration: BoxDecoration(
        color: isActive ? const Color(0xFF2F6BFF) : const Color(0xFFD6DBE8),
        borderRadius: BorderRadius.circular(8),
      ),
    );
  }
}
