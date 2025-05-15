import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iqra/features/quran/domain/repositories/quran_repository.dart';
import 'package:iqra/features/quran/presentation/cubit/quran_state.dart';

import '../../data/repositories/quran_repository_impl.dart';

class QuranCubit extends Cubit<QuranState> {
  final QuranRepository _repository;

  QuranCubit({QuranRepository? repository})
      : _repository = repository ?? QuranRepositoryImpl(),
        super(QuranInitial());

  Future<void> loadSurahs() async {
    try {
      emit(QuranLoading());
      final surahs = await _repository.getAllSurahs();
      emit(QuranLoaded(surahs: surahs));
    } catch (e) {
      emit(QuranError(e.toString()));
    }
  }

  Future<void> loadSurah(int number) async {
    try {
      final currentState = state;
      if (currentState is QuranLoaded) {
        emit(QuranLoading());
        final surah = await _repository.getSurahByNumber(number);
        emit(currentState.copyWith(selectedSurah: surah));
      }
    } catch (e) {
      emit(QuranError(e.toString()));
    }
  }

  Future<void> loadTafseer(int surahNumber, int ayahNumber) async {
    try {
      final currentState = state;
      if (currentState is QuranLoaded) {
        emit(QuranLoading());
        final tafseer = await _repository.getTafseer(surahNumber, ayahNumber);
        emit(currentState.copyWith(tafseer: tafseer));
      }
    } catch (e) {
      emit(QuranError(e.toString()));
    }
  }
} 