import 'package:flutter/material.dart';
import 'package:iqra/features/quran/domain/models/surah.dart';

class AyahItem extends StatelessWidget {
  final Ayah ayah;
  final VoidCallback onTafseerTap;

  const AyahItem({
    super.key,
    required this.ayah,
    required this.onTafseerTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primaryContainer,
                    shape: BoxShape.circle,
                  ),
                  child: Text(
                    ayah.numberInSurah.toString(),
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onPrimaryContainer,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Row(
                  children: [
                    Text(
                      'Juz ${ayah.juz}',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'Hizb ${ayah.hizbQuarter}',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              ayah.text,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    height: 1.8,
                    fontSize: 24,
                  ),
              textAlign: TextAlign.right,
              textDirection: TextDirection.rtl,
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton.icon(
                  onPressed: onTafseerTap,
                  icon: const Icon(Icons.menu_book),
                  label: const Text('Tafseer'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
} 