import 'package:flutter/material.dart';

class OnboardingPageTwo extends StatelessWidget {
  const OnboardingPageTwo({super.key});

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
                      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 36),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(36),
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
                          Stack(
                            clipBehavior: Clip.none,
                            children: [
                              Container(
                                width: 96,
                                height: 96,
                                decoration: BoxDecoration(
                                  color: const Color(0xFFE8F0FF),
                                  borderRadius: BorderRadius.circular(28),
                                ),
                                child: const Center(
                                  child: Icon(
                                    Icons.emoji_events,
                                    size: 48,
                                    color: Color(0xFF2F6BFF),
                                  ),
                                ),
                              ),
                              Positioned(
                                top: -8,
                                right: -8,
                                child: Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFFFC94A),
                                    borderRadius: BorderRadius.circular(20),
                                    boxShadow: [
                                      BoxShadow(
                                        color: const Color(0xFFFFC94A).withValues(alpha: 0.4),
                                        blurRadius: 16,
                                        offset: const Offset(0, 10),
                                      ),
                                    ],
                                  ),
                                  child: const Text(
                                    'B1',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      color: Color(0xFF2E2E2E),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 32),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              _AchievementIcon(color: Color(0xFFFFE8B1), icon: Icons.star),
                              SizedBox(width: 16),
                              _AchievementIcon(color: Color(0xFFE4F1FF), icon: Icons.local_fire_department),
                              SizedBox(width: 16),
                              _AchievementIcon(color: Color(0xFFDDF5E2), icon: Icons.emoji_events_outlined),
                            ],
                          ),
                          const SizedBox(height: 28),
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
                            decoration: BoxDecoration(
                              color: const Color(0xFFF1F4FB),
                              borderRadius: BorderRadius.circular(24),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Your Progress',
                                  style: TextStyle(
                                    color: Color(0xFF8792AC),
                                    fontSize: 14,
                                  ),
                                ),
                                const SizedBox(height: 12),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: const [
                                    Text('A1', style: TextStyle(color: Color(0xFF2F6BFF), fontWeight: FontWeight.w600)),
                                    Text('C2', style: TextStyle(color: Color(0xFFB1B7C8))),
                                  ],
                                ),
                                const SizedBox(height: 10),
                                LayoutBuilder(
                                  builder: (context, constraints) {
                                    final width = constraints.maxWidth;
                                    return Stack(
                                      children: [
                                        Container(
                                          width: width,
                                          height: 10,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.circular(6),
                                          ),
                                        ),
                                        Container(
                                          width: width * 0.45,
                                          height: 10,
                                          decoration: BoxDecoration(
                                            color: const Color(0xFF2F6BFF),
                                            borderRadius: BorderRadius.circular(6),
                                          ),
                                        ),
                                      ],
                                    );
                                  },
                                ),
                                const SizedBox(height: 12),
                                const Text(
                                  '+1,240 XP',
                                  style: TextStyle(
                                    color: Color(0xFF2F6BFF),
                                    fontSize: 18,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 40),
                    const Text(
                      'Your Personalized\nLearning Journey',
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
                      "We'll assess your CEFR level and track your\nprogress with XP, badges, and achievements.\nLevel up as you learn!",
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
                        _ProgressDot(isActive: true),
                        _ProgressDot(),
                      ],
                    ),
                    const SizedBox(height: 24),
                    SizedBox(
                      width: double.infinity,
                      height: 56,
                      child: ElevatedButton(
                        onPressed: () => _goToNext(context),
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

  void _goToNext(BuildContext context) {
    // TODO: Navigate to onboarding page 3
  }

  void _skipOnboarding(BuildContext context) {
    // TODO: Navigate to Login (skip onboarding)
  }
}

class _AchievementIcon extends StatelessWidget {
  const _AchievementIcon({required this.color, required this.icon});

  final Color color;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 48,
      height: 48,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Icon(
        icon,
        color: const Color(0xFF0F172A),
      ),
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
