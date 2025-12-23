import 'package:flutter/material.dart';
import '../../../constants/app_colors.dart';

class DashboardHeader extends StatelessWidget {
  final String? userEmail;

  const DashboardHeader({super.key, this.userEmail});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: const BoxDecoration(
        color: AppColors.dark,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Welcome back!',
            style: TextStyle(
              color: AppColors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            userEmail ?? 'Let’s keep learning',
            style: const TextStyle(
              color: AppColors.white,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}

