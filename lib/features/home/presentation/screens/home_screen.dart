import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:katadia_app/features/authentication/presentation/providers/auth_provider.dart';
import 'package:katadia_app/core/routing/app_router.dart';
import 'package:katadia_app/shared/theme/app_colors.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authStateProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('KataDia'),
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () => context.goToSettings(),
          ),
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: () => context.goToProfile(),
          ),
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              // Logout with deferred navigation
              ref.read(authProvider.notifier).logout();
              // Use addPostFrameCallback to defer navigation
              WidgetsBinding.instance.addPostFrameCallback((_) {
                if (context.mounted) {
                  context.goToLogin();
                }
              });
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Welcome section
              authState.maybeWhen(
                authenticated: (user) => Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Selamat datang, ${user.name}!',
                      style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      'Lanjutkan belajar bahasa Indonesia dan Inggris',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: Colors.grey[600],
                          ),
                    ),
                    SizedBox(height: 24.h),
                  ],
                ),
                orElse: () => SizedBox.shrink(),
              ),

              // Menu cards
              Text(
                'Pilih aktivitas',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
              ),
              SizedBox(height: 16.h),

              // Lessons card
              _MenuCard(
                title: 'Pelajaran',
                description: 'Belajar vocabulary, grammar, dan pronunciation',
                icon: Icons.book,
                color: AppColors.primary,
                onTap: () => context.goToLessons(),
              ),
              SizedBox(height: 12.h),

              // Pronunciation practice card
              _MenuCard(
                title: 'Latihan Pronunciation',
                description: 'Praktikkan pronunciation dengan AI feedback',
                icon: Icons.mic,
                color: Colors.purple,
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Pilih pelajaran terlebih dahulu')),
                  );
                },
              ),
              SizedBox(height: 12.h),

              // Gamification card
              _MenuCard(
                title: 'Gamifikasi',
                description: 'Kumpulkan poin dan naik level',
                icon: Icons.stars,
                color: Colors.amber,
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Fitur gamifikasi segera hadir')),
                  );
                },
              ),
              SizedBox(height: 24.h),

              // Stats section
              Text(
                'Statistik Anda',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
              ),
              SizedBox(height: 16.h),

              Row(
                children: [
                  Expanded(
                    child: _StatCard(
                      label: 'Streak',
                      value: '5 Hari',
                      icon: Icons.local_fire_department,
                      color: Colors.red,
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: _StatCard(
                      label: 'XP',
                      value: '250',
                      icon: Icons.flash_on,
                      color: Colors.orange,
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: _StatCard(
                      label: 'Level',
                      value: '5',
                      icon: Icons.trending_up,
                      color: Colors.blue,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _MenuCard extends StatefulWidget {
  final String title;
  final String description;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  const _MenuCard({
    required this.title,
    required this.description,
    required this.icon,
    required this.color,
    required this.onTap,
  });

  @override
  State<_MenuCard> createState() => _MenuCardState();
}

class _MenuCardState extends State<_MenuCard> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: Tween<double>(begin: 1.0, end: 0.98).animate(
        CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTapDown: (_) => _animationController.forward(),
          onTapUp: (_) => _animationController.reverse(),
          onTapCancel: () => _animationController.reverse(),
          onTap: widget.onTap,
          borderRadius: BorderRadius.circular(12),
          child: Card(
            elevation: 2,
            child: ListTile(
              leading: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: widget.color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(widget.icon, color: widget.color),
              ),
              title: Text(
                widget.title,
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),
              subtitle: Text(
                widget.description,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              trailing: const Icon(Icons.chevron_right),
            ),
          ),
        ),
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;
  final Color color;

  const _StatCard({
    required this.label,
    required this.value,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(12.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: color, size: 28),
            SizedBox(height: 8.h),
            Text(
              value,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            SizedBox(height: 4.h),
            Text(
              label,
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ),
      ),
    );
  }
}
