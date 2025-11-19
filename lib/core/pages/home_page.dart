import 'package:flutter/material.dart';
import '../../../core/theme/index.dart';
import 'home/widgets/index.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedTab = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgLight,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const HomeHeader(),
            SizedBox(height: AppSpacing.xxl),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: AppSpacing.xxl),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const UserInfoCard(),
                  SizedBox(height: AppSpacing.xxl),
                  const DailyTasksCard(),
                  SizedBox(height: AppSpacing.xxl),
                  const FeatureGrid(),
                  SizedBox(height: AppSpacing.md),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: HomeBottomNavbar(
        selectedIndex: _selectedTab,
        onTap: (index) {
          if (index == 2) {
            Navigator.pushNamed(context, '/progress');
          } else if (index == 3) {
            Navigator.pushNamed(context, '/leaderboard');
          } else if (index == 4) {
            Navigator.pushNamed(context, '/profile');
          } else {
            setState(() {
              _selectedTab = index;
            });
          }
        },
      ),
    );
  }
}
