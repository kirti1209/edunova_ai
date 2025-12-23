import 'package:flutter/material.dart';
import '../../../constants/app_colors.dart';

class HighlightItem {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color color;

  const HighlightItem({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.color,
  });
}

class ProgressHighlight {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color color;
  final double progress;

  const ProgressHighlight({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.color,
    required this.progress,
  });
}

class HighlightsSection extends StatelessWidget {
  final List<HighlightItem> highlights;
  final ProgressHighlight progressHighlight;

  const HighlightsSection({
    super.key,
    required this.highlights,
    required this.progressHighlight,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          ...highlights.map(
            (item) => Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: _HighlightCard(item: item),
            ),
          ),
          _ProgressHighlightCard(item: progressHighlight),
        ],
      ),
    );
  }
}

class _HighlightCard extends StatelessWidget {
  final HighlightItem item;

  const _HighlightCard({required this.item});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: item.color.withOpacity(0.12),
          child: Icon(item.icon, color: item.color),
        ),
        title: Text(
          item.title,
          style: const TextStyle(
            fontWeight: FontWeight.w700,
            color: AppColors.dark,
          ),
        ),
        subtitle: Text(
          item.subtitle,
          style: const TextStyle(color: AppColors.dark),
        ),
        trailing: const Icon(Icons.chevron_right, color: AppColors.dark),
        onTap: () {},
      ),
    );
  }
}

class _ProgressHighlightCard extends StatelessWidget {
  final ProgressHighlight item;

  const _ProgressHighlightCard({required this.item});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: item.color.withOpacity(0.12),
              child: Icon(item.icon, color: item.color),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.title,
                    style: const TextStyle(
                      fontWeight: FontWeight.w700,
                      color: AppColors.dark,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    item.subtitle,
                    style: const TextStyle(color: AppColors.dark),
                  ),
                  const SizedBox(height: 8),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: LinearProgressIndicator(
                      value: item.progress,
                      minHeight: 8,
                      backgroundColor: AppColors.primary.withOpacity(0.12),
                      valueColor: AlwaysStoppedAnimation<Color>(item.color),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 12),
            Text(
              '${(item.progress * 100).round()}%',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: item.color,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

