import 'package:flutter/material.dart';
import 'package:iqra/features/quran/domain/models/surah.dart';

class SurahListItem extends StatelessWidget {
  final Surah surah;
  final VoidCallback onTap;

  const SurahListItem({
    super.key,
    required this.surah,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ListTile(
        onTap: onTap,
        leading: CircleAvatar(
          backgroundColor: Theme.of(context).colorScheme.primary,
          child: Text(
            surah.number.toString(),
            style: TextStyle(
              color: Theme.of(context).colorScheme.onPrimary,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        title: Text(
          surah.name,
          style: Theme.of(context).textTheme.titleLarge,
        ),
        subtitle: Text(
          '${surah.englishName} - ${surah.englishNameTranslation}',
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '${surah.numberOfAyahs} آيات',
              style: Theme.of(context).textTheme.bodySmall,
            ),
            Text(
              surah.revelationType,
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ),
      ),
    );
  }
} 