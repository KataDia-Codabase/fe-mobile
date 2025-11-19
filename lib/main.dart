import 'package:flutter/material.dart';
import 'core/theme/index.dart';
import 'core/pages/home_page.dart';
import 'features/authentication/presentation/pages/login_page.dart';
import 'features/onboarding/presentation/pages/onboarding_container.dart';
import 'features/ai_chat/presentation/pages/ai_chat_page.dart';
import 'features/rewards/presentation/pages/rewards_page.dart';
import 'features/progress/presentation/pages/progress_page.dart';
import 'features/profile/presentation/pages/profile_page.dart';
import 'features/leaderboard/presentation/pages/leaderboard_page.dart';
// import 'features/cefr_assessment/presentation/pages/cefr_assessment_page.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      home: const OnboardingContainer(),
      routes: {
        '/home': (context) => const HomePage(),
        '/login': (context) => const LoginPage(),
        '/onboarding': (context) => const OnboardingContainer(),
        '/ai-chat': (context) => const AIChatPage(),
        '/rewards': (context) => const RewardsPage(),
        '/progress': (context) => const ProgressPage(),
        '/profile': (context) => const ProfilePage(),
        '/leaderboard': (context) => const LeaderboardPage(),
      },
    );
  }
}
