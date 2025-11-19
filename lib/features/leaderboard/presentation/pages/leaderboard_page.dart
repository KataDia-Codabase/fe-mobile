import 'package:flutter/material.dart';
import '../../../../../core/theme/index.dart';
import '../widgets/index.dart';

class LeaderboardPage extends StatefulWidget {
  const LeaderboardPage({super.key});

  @override
  State<LeaderboardPage> createState() => _LeaderboardPageState();
}

class _LeaderboardPageState extends State<LeaderboardPage> {
  int _selectedTab = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgLight,
      body: SingleChildScrollView(
        child: Column(
          children: [
            LeaderboardHeader(
              onBack: () => Navigator.pop(context),
              selectedTab: _selectedTab,
              onTabChange: (index) {
                setState(() {
                  _selectedTab = index;
                });
              },
            ),
            Padding(
              padding: const EdgeInsets.all(AppSpacing.lg),
              child: Column(
                children: [
                  if (_selectedTab == 0)
                    const GlobalLeaderboardView()
                  else
                    const FriendsLeaderboardView(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
