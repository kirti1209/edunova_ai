import 'package:flutter/material.dart';
import '../../../constants/app_colors.dart';

class ProfileOptionTile extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback onTap;
  final Color? iconColor;
  final bool isDestructive;

  const ProfileOptionTile({
    super.key,
    required this.title,
    required this.icon,
    required this.onTap,
    this.iconColor,
    this.isDestructive = false,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        icon,
        color: isDestructive ? Colors.red : (iconColor ?? AppColors.primary),
      ),
      title: Text(
        title,
        style: TextStyle(
          color: isDestructive ? Colors.red : AppColors.dark,
          fontWeight: FontWeight.w500,
        ),
      ),
      trailing: const Icon(
        Icons.chevron_right,
        color: AppColors.dark,
      ),
      onTap: onTap,
    );
  }
}

