import 'package:iqra/features/quran/domain/models/surah.dart';

abstract class QuranRepository {
  Future<List<Surah>> getAllSurahs();
  Future<Surah> getSurahByNumber(int number);
  Future<String> getTafseer(int surahNumber, int ayahNumber);
} 