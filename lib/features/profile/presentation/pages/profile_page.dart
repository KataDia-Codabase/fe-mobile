import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:katadia_fe/core/theme/index.dart';
import 'package:katadia_fe/core/services/auth_bloc_provider.dart';
import 'package:katadia_fe/features/authentication/domain/entities/user_entity.dart';
import 'package:katadia_fe/features/authentication/presentation/pages/login_page.dart';
import 'package:katadia_fe/features/authentication/presentation/bloc/auth_state.dart';
import 'package:katadia_fe/data/datasources/local/database_service.dart';

import '../widgets/index.dart';

class ProfilePage extends StatefulWidget {
  final User? user;

  const ProfilePage({super.key, this.user});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late String _displayName;
  late String _displayEmail;
  late String _currentUserEmail;
  late String _currentUserId;
  final DatabaseService _databaseService = DatabaseService();

  @override
  void initState() {
    super.initState();
    _displayName = widget.user?.name ?? 'Sarah Anderson';
    _displayEmail = widget.user?.email ?? 'sarah.anderson@email.com';
    _currentUserEmail = _displayEmail;
    _currentUserId = widget.user?.id ?? '';
    
    // Listen to AuthBLoC changes
    AuthBLocProvider.instance.addListener(_handleAuthStateChange);
  }

  @override
  void dispose() {
    AuthBLocProvider.instance.removeListener(_handleAuthStateChange);
    super.dispose();
  }

  void _handleAuthStateChange(AuthState state) {
    if (state is AuthSuccess) {
      debugPrint('🔔 AuthBLoC state changed, updating user data with email: ${state.user.email}');
      setState(() {
        _displayName = state.user.name;
        _displayEmail = state.user.email;
        _currentUserEmail = state.user.email;
        _currentUserId = state.user.id;
      });
      
      // Immediately refresh profile after state update
      _handleProfileUpdated();
    }
  }

  int _calculateLevel(int xp) => (xp / 100).floor().clamp(1, 60);

  Future<void> _handleProfileUpdated() async {
    // Refresh display name and email from database using current email
    try {
      debugPrint('🔄 Refreshing profile with id: $_currentUserId or email: $_currentUserEmail');
      final updatedUser = _currentUserId.isNotEmpty
          ? await _databaseService.getUserById(_currentUserId)
          : await _databaseService.getUser(_currentUserEmail);
      if (updatedUser != null && mounted) {
        debugPrint('✅ Profile refreshed: name=${updatedUser.name}, email=${updatedUser.email}');
        setState(() {
          _displayName = updatedUser.name;
          _displayEmail = updatedUser.email;
          _currentUserEmail = updatedUser.email; // Update tracking email
          _currentUserId = updatedUser.id;
        });
      } else {
        debugPrint('❌ User not found for id/email: $_currentUserId / $_currentUserEmail');
      }
    } catch (e) {
      debugPrint('❌ Error refreshing profile: $e');
    }
  }

  void _handleLogout() {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => const LoginPage()),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    final userName = _displayName;
    final email = _displayEmail;
    final totalXp = widget.user?.xp ?? 0;
    final streakDays = widget.user?.streak ?? 0;
    final lessonsCompleted = 0;
    final cefr = widget.user?.cefrLevel ?? 'N/A';
    final avatarPath = widget.user?.avatar;
    final cefrLabel = cefr.toUpperCase() == 'N/A' ? 'N/A CEFR' : '${cefr.toUpperCase()} CEFR';
    final levelLabel = 'Level ${_calculateLevel(totalXp)}';

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light.copyWith(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.dark,
      ),
      child: SafeArea(
        top: false,
        bottom: false,
        child: SingleChildScrollView(
          padding: EdgeInsets.only(bottom: AppSpacing.xxxl + AppSpacing.lg),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const ProfileHeader(),
              SizedBox(height: AppSpacing.xxxl),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: AppSpacing.xxl),
                child: ProfileOverviewCard(
                  userName: userName,
                  email: email,
                  levelLabel: levelLabel,
                  cefrLabel: cefrLabel,
                  totalXp: totalXp,
                  streakDays: streakDays,
                  lessonsCompleted: lessonsCompleted,
                  avatarPath: avatarPath,
                ),
              ),
              SizedBox(height: AppSpacing.xxxl),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: AppSpacing.xxl),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AccountSection(
                      userId: _currentUserId,
                      userName: userName,
                      email: email,
                      onProfileUpdated: _handleProfileUpdated,
                    ),
                    SizedBox(height: AppSpacing.xxxl),
                    const PreferencesSection(),
                    SizedBox(height: AppSpacing.xxxl),
                    LogoutButton(
                      onLogoutSuccess: _handleLogout,
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
}
