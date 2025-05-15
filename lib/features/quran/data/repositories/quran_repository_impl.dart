import 'package:dio/dio.dart';
import 'package:iqra/features/quran/domain/models/surah.dart';
import 'package:iqra/features/quran/domain/repositories/quran_repository.dart';

class QuranRepositoryImpl implements QuranRepository {
  final Dio _dio;
  final String _baseUrl = 'YOUR_API_BASE_URL'; // Replace with your API base URL

  QuranRepositoryImpl() : _dio = Dio();

  @override
  Future<List<Surah>> getAllSurahs() async {
    try {
      final response = await _dio.get('$_baseUrl/surah');
      final List<dynamic> data = response.data['data'];
      return data.map((json) => Surah.fromJson(json)).toList();
    } catch (e) {
      throw Exception('Failed to fetch surahs: $e');
    }
  }

  @override
  Future<Surah> getSurahByNumber(int number) async {
    try {
      final response = await _dio.get('$_baseUrl/surah/$number');
      return Surah.fromJson(response.data['data']);
    } catch (e) {
      throw Exception('Failed to fetch surah: $e');
    }
  }

  @override
  Future<String> getTafseer(int surahNumber, int ayahNumber) async {
    try {
      final response = await _dio.get('$_baseUrl/tafseer/$surahNumber/$ayahNumber');
      return response.data['data']['text'];
    } catch (e) {
      throw Exception('Failed to fetch tafseer: $e');
    }
  }
} 