import 'package:flutter/material.dart';
import '../../../constants/app_colors.dart';
import '../../../constants/app_strings.dart';
import '../widgets/dashboard_card.dart';
import '../widgets/app_drawer.dart';
import '../widgets/dashboard_header.dart';
import '../widgets/quick_stats.dart';
import '../widgets/focus_chips.dart';
import '../widgets/highlights_section.dart';
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
              const DashboardHeader(),
              const SizedBox(height: 24),
              
              // Quick Stats
              const QuickStats(
                items: [
                  StatItem(
                    title: 'Courses',
                    value: '12',
                    icon: Icons.book,
                    color: AppColors.primary,
                  ),
                  StatItem(
                    title: 'Progress',
                    value: '85%',
                    icon: Icons.trending_up,
                    color: Colors.green,
                  ),
                ],
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
              const FocusChips(
                items: [
                  'Finish Flutter module',
                  'Review UI/UX notes',
                  'Attempt quiz',
                  'Watch live Q&A',
                ],
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
              const HighlightsSection(
                highlights: [
                  HighlightItem(
                    title: 'Assignment due',
                    subtitle: 'UI/UX Wireframes • due in 6h',
                    icon: Icons.timer,
                    color: Colors.orange,
                  ),
                  HighlightItem(
                    title: 'Live mentor note',
                    subtitle: 'Join the AMA at 5:30 PM',
                    icon: Icons.chat,
                    color: AppColors.primary,
                  ),
                ],
                progressHighlight: ProgressHighlight(
                  title: 'Certificate progress',
                  subtitle: 'Mobile Dev Track • 60% complete',
                  icon: Icons.workspace_premium,
                  color: Colors.green,
                  progress: 0.6,
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
