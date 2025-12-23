import 'package:flutter/material.dart';
import '../../../constants/app_colors.dart';
import '../../../constants/app_strings.dart';
import '../../profile/screens/profile_screen.dart';
import '../../login/services/auth_service.dart';
import '../../login/screens/login_screen.dart';

class AppDrawer extends StatelessWidget {
  final String? userEmail;
  final VoidCallback? onHomeTap;
  final VoidCallback? onCoursesTap;
  final VoidCallback? onAssignmentsTap;
  final VoidCallback? onSettingsTap;

  const AppDrawer({
    super.key,
    this.userEmail,
    this.onHomeTap,
    this.onCoursesTap,
    this.onAssignmentsTap,
    this.onSettingsTap,
  });

  Future<void> _handleLogout(BuildContext context) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Logout'),
        content: const Text(AppStrings.logoutConfirmation),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text(AppStrings.no),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text(AppStrings.yes),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      final authService = AuthService();
      await authService.logout();
      if (context.mounted) {
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (context) => const LoginScreen(),
          ),
          (route) => false,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(
              color: AppColors.dark,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const CircleAvatar(
                  radius: 30,
                  backgroundColor: AppColors.primary,
                  child: Icon(
                    Icons.person,
                    size: 40,
                    color: AppColors.white,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  userEmail ?? 'User',
                  style: const TextStyle(
                    color: AppColors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home, color: AppColors.primary),
            title: const Text(AppStrings.home),
            onTap: () {
              Navigator.pop(context);
              onHomeTap?.call();
            },
          ),
          ListTile(
            leading: const Icon(Icons.book, color: AppColors.primary),
            title: const Text(AppStrings.courses),
            onTap: () {
              Navigator.pop(context);
              onCoursesTap?.call();
            },
          ),
          ListTile(
            leading: const Icon(Icons.assignment, color: AppColors.primary),
            title: const Text(AppStrings.assignments),
            onTap: () {
              Navigator.pop(context);
              onAssignmentsTap?.call();
            },
          ),
          ListTile(
            leading: const Icon(Icons.person, color: AppColors.primary),
            title: const Text(AppStrings.profile),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ProfileScreen(),
                ),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.settings, color: AppColors.primary),
            title: const Text(AppStrings.settings),
            onTap: () {
              Navigator.pop(context);
              onSettingsTap?.call();
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.logout, color: Colors.red),
            title: const Text(
              AppStrings.logout,
              style: TextStyle(color: Colors.red),
            ),
            onTap: () {
              Navigator.pop(context);
              _handleLogout(context);
            },
          ),
        ],
      ),
    );
  }
}

