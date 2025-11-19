import 'package:flutter/material.dart';
import '../../../../../core/theme/index.dart';
import '../widgets/index.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgLight,
      body: SingleChildScrollView(
        child: Column(
          children: [
            ProfileHeader(onBack: () => Navigator.pop(context)),
            Padding(
              padding: const EdgeInsets.all(AppSpacing.lg),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AccountSection(),
                  SizedBox(height: AppSpacing.lg),
                  PreferencesSection(),
                  SizedBox(height: AppSpacing.lg),
                  GeneralSection(),
                  SizedBox(height: AppSpacing.lg),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
