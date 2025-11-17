import 'package:flutter/material.dart';

import 'onboarding_page_two.dart';

class OnboardingPageOne extends StatelessWidget {
  const OnboardingPageOne({super.key});

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
                  onPressed: () => _navigateToHome(context),
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
                      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 36),
                      decoration: BoxDecoration(
                        color: const Color(0xFFE3EBFF),
                        borderRadius: BorderRadius.circular(32),
                      ),
                      child: Stack(
                        clipBehavior: Clip.none,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(24),
                              boxShadow: [
                                BoxShadow(
                                  color: const Color(0xFF1D2A44).withValues(alpha: 0.08),
                                  blurRadius: 24,
                                  offset: const Offset(0, 16),
                                ),
                              ],
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _lineDot(),
                                const SizedBox(height: 12),
                                _lineDot(widthFactor: 0.75, isPrimary: false),
                                const SizedBox(height: 12),
                                _lineDot(widthFactor: 0.55, isPrimary: false),
                              ],
                            ),
                          ),
                          Positioned(
                            right: -12,
                            top: -12,
                            child: _iconBubble(
                              color: const Color(0xFFFFC94A),
                              icon: Icons.volume_up_rounded,
                              iconColor: const Color(0xFF0E1A34),
                            ),
                          ),
                          Positioned(
                            left: -12,
                            bottom: -12,
                            child: _iconBubble(
                              color: const Color(0xFF2F6BFF),
                              icon: Icons.mic,
                              iconColor: Colors.white,
                              size: 48,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 40),
                    const Text(
                      'Master Pronunciation\nwith AI',
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
                      'Get instant feedback on your pronunciation\nusing advanced AI technology. Sound like a\nnative speaker in no time.',
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
                      children: [
                        _buildDot(isActive: true),
                        _buildDot(),
                        _buildDot(),
                      ],
                    ),
                    const SizedBox(height: 24),
                    SizedBox(
                      width: double.infinity,
                      height: 56,
                      child: ElevatedButton(
                        onPressed: () => _navigateToNextPage(context),
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
                        child: const Text('Next'),
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

  Widget _lineDot({double widthFactor = 1, bool isPrimary = true}) {
    return Row(
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            color: isPrimary ? const Color(0xFF2F6BFF) : const Color(0xFFCBD5F5),
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Align(
            alignment: Alignment.centerLeft,
            child: FractionallySizedBox(
              widthFactor: widthFactor.clamp(0.0, 1.0),
              child: Container(
                height: 10,
                decoration: BoxDecoration(
                  color: const Color(0xFFE8ECF7),
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _iconBubble({
    required Color color,
    required IconData icon,
    required Color iconColor,
    double size = 56,
  }) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: color.withValues(alpha: 0.25),
            blurRadius: 16,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Icon(icon, color: iconColor, size: size * 0.45),
    );
  }

  Widget _buildDot({bool isActive = false}) {
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

  void _navigateToNextPage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const OnboardingPageTwo()),
    );
  }

  void _navigateToHome(BuildContext context) {
    // TODO: Navigate to Login (skip onboarding)
    // Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_) => HomePage()), (route) => false);
  }
}
