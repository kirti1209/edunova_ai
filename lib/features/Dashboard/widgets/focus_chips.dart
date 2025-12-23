import 'package:flutter/material.dart';
import '../../../constants/app_colors.dart';

class FocusChips extends StatelessWidget {
  final List<String> items;

  const FocusChips({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Wrap(
        spacing: 8,
        runSpacing: 8,
        children: items
            .map(
              (item) => Chip(
                backgroundColor: AppColors.primary.withOpacity(0.12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                label: Text(
                  item,
                  style: const TextStyle(
                    color: AppColors.dark,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}

