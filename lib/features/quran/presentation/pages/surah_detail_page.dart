import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iqra/features/quran/domain/models/surah.dart';
import 'package:iqra/features/quran/presentation/cubit/quran_cubit.dart';
import 'package:iqra/features/quran/presentation/cubit/quran_state.dart';
import 'package:iqra/features/quran/presentation/widgets/ayah_item.dart';

class SurahDetailPage extends StatelessWidget {
  final Surah surah;

  const SurahDetailPage({
    super.key,
    required this.surah,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(surah.name),
      ),
      body: BlocBuilder<QuranCubit, QuranState>(
        builder: (context, state) {
          if (state is QuranLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is QuranError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Error: ${state.message}',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      context.read<QuranCubit>().loadSurah(surah.number);
                    },
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          }

          return Column(
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                color: Theme.of(context).colorScheme.primaryContainer,
                child: Column(
                  children: [
                    Text(
                      surah.name,
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '${surah.englishName} - ${surah.englishNameTranslation}',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '${surah.numberOfAyahs} Verses • ${surah.revelationType}',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: surah.ayahs.length,
                  itemBuilder: (context, index) {
                    final ayah = surah.ayahs[index];
                    return AyahItem(
                      ayah: ayah,
                      onTafseerTap: () {
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: Text('Tafseer - Ayah ${ayah.numberInSurah}'),
                            content: SingleChildScrollView(
                              child: Text(
                                state is QuranLoaded && state.tafseer != null
                                    ? state.tafseer!
                                    : 'Loading tafseer...',
                              ),
                            ),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(context),
                                child: const Text('Close'),
                              ),
                            ],
                          ),
                        );
                        context
                            .read<QuranCubit>()
                            .loadTafseer(surah.number, ayah.numberInSurah);
                      },
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
} 