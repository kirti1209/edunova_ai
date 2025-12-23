import 'package:flutter/material.dart';
import '../../../constants/app_colors.dart';
import '../../../constants/app_strings.dart';
import '../widgets/dashboard_card.dart';
import '../widgets/app_drawer.dart';
import '../../login/services/auth_service.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  String? userEmail;

  @override
  void initState() {
    super.initState();
    _loadUserEmail();
  }

  Future<void> _loadUserEmail() async {
    final authService = AuthService();
    final email = await authService.getUserEmail();
    setState(() {
      userEmail = email;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.dashboard),
      ),
      drawer: AppDrawer(
        userEmail: userEmail,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [AppColors.white, Color(0xFFF5F5F5)],
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Welcome Section
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(24),
                decoration: const BoxDecoration(
                  color: AppColors.dark,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                  ),
                ),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Welcome back!',
                      style: TextStyle(
                        color: AppColors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    
                  ],
                ),
              ),
              const SizedBox(height: 24),
              
              // Quick Stats
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    Expanded(
                      child: _StatCard(
                        title: 'Courses',
                        value: '12',
                        icon: Icons.book,
                        color: AppColors.primary,
                      ),
                    ),
                    SizedBox(width: 12),
                    Expanded(
                      child: _StatCard(
                        title: 'Progress',
                        value: '85%',
                        icon: Icons.trending_up,
                        color: Colors.green,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              // Today's Focus (quick micro-goals)
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  "Today's focus",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: AppColors.dark,
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: const [
                    _FocusChip(label: 'Finish Flutter module'),
                    _FocusChip(label: 'Review UI/UX notes'),
                    _FocusChip(label: 'Attempt quiz'),
                    _FocusChip(label: 'Watch live Q&A'),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              
              // My Courses Section
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  AppStrings.myCourses,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: AppColors.dark,
                  ),
                ),
              ),
              const SizedBox(height: 12),
              
              DashboardCard(
                title: 'Flutter Development',
                subtitle: 'Advanced mobile app development',
                icon: Icons.code,
                iconColor: AppColors.primary,
                onTap: () {},
              ),
              DashboardCard(
                title: 'UI/UX Design',
                subtitle: 'Master design principles',
                icon: Icons.design_services,
                iconColor: Colors.purple,
                onTap: () {},
              ),
              DashboardCard(
                title: 'Data Science',
                subtitle: 'Python and machine learning',
                icon: Icons.analytics,
                iconColor: Colors.orange,
                onTap: () {},
              ),
              
              const SizedBox(height: 24),

              // LMS Highlights
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  'LMS highlights',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: AppColors.dark,
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: const [
                    _HighlightCard(
                      title: 'Assignment due',
                      subtitle: 'UI/UX Wireframes • due in 6h',
                      icon: Icons.timer,
                      color: Colors.orange,
                    ),
                    SizedBox(height: 10),
                    _HighlightCard(
                      title: 'Live mentor note',
                      subtitle: 'Join the AMA at 5:30 PM',
                      icon: Icons.chat,
                      color: AppColors.primary,
                    ),
                    SizedBox(height: 10),
                    _ProgressHighlightCard(
                      title: 'Certificate progress',
                      subtitle: 'Mobile Dev Track • 60% complete',
                      icon: Icons.workspace_premium,
                      color: Colors.green,
                      progress: 0.6,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              
              // Upcoming Classes
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  AppStrings.upcomingClasses,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: AppColors.dark,
                  ),
                ),
              ),
              const SizedBox(height: 12),
              
              DashboardCard(
                title: 'Live Session: Flutter',
                subtitle: 'Today at 3:00 PM',
                icon: Icons.video_call,
                iconColor: Colors.red,
                onTap: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color color;

  const _StatCard({
    required this.title,
    required this.value,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: color, size: 28),
            const SizedBox(height: 12),
            Text(
              value,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              title,
              style: const TextStyle(
                fontSize: 14,
                color: AppColors.dark,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _FocusChip extends StatelessWidget {
  final String label;
  const _FocusChip({required this.label});

  @override
  Widget build(BuildContext context) {
    return Chip(
      backgroundColor: AppColors.primary.withOpacity(0.12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      label: Text(
        label,
        style: const TextStyle(
          color: AppColors.dark,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

class _HighlightCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color color;

  const _HighlightCard({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: color.withOpacity(0.12),
          child: Icon(icon, color: color),
        ),
        title: Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.w700,
            color: AppColors.dark,
          ),
        ),
        subtitle: Text(
          subtitle,
          style: const TextStyle(color: AppColors.dark),
        ),
        trailing: const Icon(Icons.chevron_right, color: AppColors.dark),
        onTap: () {},
      ),
    );
  }
}

class _ProgressHighlightCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color color;
  final double progress;

  const _ProgressHighlightCard({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.color,
    required this.progress,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: color.withOpacity(0.12),
              child: Icon(icon, color: color),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontWeight: FontWeight.w700,
                      color: AppColors.dark,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: const TextStyle(color: AppColors.dark),
                  ),
                  const SizedBox(height: 8),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: LinearProgressIndicator(
                      value: progress,
                      minHeight: 8,
                      backgroundColor: AppColors.primary.withOpacity(0.12),
                      valueColor: AlwaysStoppedAnimation<Color>(color),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 12),
            Text(
              '${(progress * 100).round()}%',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

