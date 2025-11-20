import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:katadia_fe/core/theme/index.dart';
import 'package:katadia_fe/features/authentication/domain/entities/user_entity.dart';
import 'package:katadia_fe/features/profile/presentation/pages/profile_page.dart';
import 'package:katadia_fe/features/ai_chat/presentation/pages/ai_chat_page.dart';
import 'package:katadia_fe/features/lessons/presentation/pages/lesson_categories_page.dart';

import 'home/widgets/index.dart';

class HomePage extends StatefulWidget {
  final User? user;

  const HomePage({super.key, this.user});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedTab = 0;
  late final String _userName;
  late final String _cefrLevel;
  late final String _cefrDescription;
  late final int _xp;
  late final int _streak;
  late final int _lessonsCompleted;

  final int _notificationCount = 1;
  final int _dailyTasksCompleted = 1;
  final int _dailyTasksTotal = 4;
  final int _xpEarnedToday = 30;

  @override
  void initState() {
    super.initState();
    final user = widget.user;
    _userName = user?.name ?? 'Sarah Anderson';
    _cefrLevel = user?.cefrLevel.toUpperCase() ?? 'B1';
    _cefrDescription = _getCefrDescription(_cefrLevel);
    _xp = user?.xp ?? 1250;
    _streak = user?.streak ?? 7;
    _lessonsCompleted = 12;
  }

  String _getCefrDescription(String level) {
    switch (level.toUpperCase()) {
      case 'A1':
        return 'Beginner - Breakthrough';
      case 'A2':
        return 'Elementary - Waystage';
      case 'B1':
        return 'Intermediate - Independent User';
      case 'B2':
        return 'Upper Intermediate - Vantage';
      case 'C1':
        return 'Advanced - Effective Proficiency';
      case 'C2':
        return 'Proficient - Mastery';
      default:
        return 'Intermediate - Independent User';
    }
  }

  List<HomeFeatureItem> _buildFeatures(BuildContext context) {
    return [
      HomeFeatureItem(
        icon: Icons.menu_book_rounded,
        title: 'Lessons',
        subtitle: 'Browse all lessons',
        iconColor: AppColors.primary,
        backgroundColor: AppColors.primary.withValues(alpha: 0.12),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => LessonCategoriesPage(),
            ),
          );
        },
      ),
      HomeFeatureItem(
        icon: Icons.chat_bubble_rounded,
        title: 'AI Chat',
        subtitle: 'Practice conversation',
        iconColor: AppColors.accentPurple,
        backgroundColor: AppColors.accentPurple.withValues(alpha: 0.12),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => const AIChatPage(),
            ),
          );
        },
      ),
    ];
  }

  void _showComingSoon(String featureName) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text('$featureName akan segera hadir'),
        ),
      );
  }

  Widget _buildHomeContent() {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light.copyWith(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.dark,
      ),
      child: Container(
        color: AppColors.bgLight,
        child: SafeArea(
          top: false,
          bottom: false,
          child: SingleChildScrollView(
            padding: EdgeInsets.only(bottom: AppSpacing.xxxl),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                HomeHeader(
                  userName: _userName,
                  notificationCount: _notificationCount,
                  onNotificationTap: () => _showComingSoon('Notifikasi'),
                ),
                SizedBox(height: AppSpacing.xxxl),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: AppSpacing.xxl),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      UserInfoCard(
                        cefrBadge: _cefrLevel,
                        cefrTitle: 'CEFR Level $_cefrLevel',
                        cefrDescription: _cefrDescription,
                        totalXp: _xp,
                        lessonsCompleted: _lessonsCompleted,
                        streakDays: _streak,
                      ),
                      SizedBox(height: AppSpacing.xxxl),
                      DailyTasksCard(
                        completedTasks: _dailyTasksCompleted,
                        totalTasks: _dailyTasksTotal,
                        xpEarned: _xpEarnedToday,
                        onTap: () => _showComingSoon('Daily Tasks'),
                      ),
                      SizedBox(height: AppSpacing.xxxl),
                      FeatureGrid(features: _buildFeatures(context)),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPageForTab(int index) {
    switch (index) {
      case 0:
        return _buildHomeContent();
      case 4:
        return ProfilePage(user: widget.user);
      default:
        return Center(
          child: Padding(
            padding: const EdgeInsets.only(top: 200),
            child: Text(
              'Halaman belum tersedia',
              style: AppTextStyles.bodyMedium,
            ),
          ),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgLight,
      body: _buildPageForTab(_selectedTab),
      bottomNavigationBar: HomeBottomNavbar(
        selectedIndex: _selectedTab,
        onTap: (index) {
          setState(() {
            _selectedTab = index;
          });
        },
      ),
    );
  }
}
