import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iqra/features/quran/presentation/cubit/quran_cubit.dart';
import 'package:iqra/features/quran/presentation/cubit/quran_state.dart';
import 'package:iqra/features/quran/presentation/pages/surah_detail_page.dart';
import 'package:iqra/features/quran/presentation/widgets/surah_list_item.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Iqra - القرآن الكريم'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              // TODO: Implement search functionality
            },
          ),
        ],
      ),
      body: BlocBuilder<QuranCubit, QuranState>(
        builder: (context, state) {
          if (state is QuranInitial) {
            context.read<QuranCubit>().loadSurahs();
            return const Center(child: CircularProgressIndicator());
          }

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
                      context.read<QuranCubit>().loadSurahs();
                    },
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          }

          if (state is QuranLoaded) {
            return ListView.builder(
              itemCount: state.surahs.length,
              itemBuilder: (context, index) {
                final surah = state.surahs[index];
                return SurahListItem(
                  surah: surah,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SurahDetailPage(surah: surah),
                      ),
                    );
                  },
                );
              },
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
} 