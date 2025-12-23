import 'package:flutter/material.dart';
import 'stat_card.dart';

class StatItem {
  final String title;
  final String value;
  final IconData icon;
  final Color color;

  const StatItem({
    required this.title,
    required this.value,
    required this.icon,
    required this.color,
  });
}

class QuickStats extends StatelessWidget {
  final List<StatItem> items;

  const QuickStats({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          Expanded(
            child: StatCard(
              title: items[0].title,
              value: items[0].value,
              icon: items[0].icon,
              color: items[0].color,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: StatCard(
              title: items[1].title,
              value: items[1].value,
              icon: items[1].icon,
              color: items[1].color,
            ),
          ),
        ],
      ),
    );
  }
}

