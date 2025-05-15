import 'package:equatable/equatable.dart';
import 'package:iqra/features/quran/domain/models/surah.dart';

abstract class QuranState extends Equatable {
  const QuranState();

  @override
  List<Object?> get props => [];
}

class QuranInitial extends QuranState {}

class QuranLoading extends QuranState {}

class QuranLoaded extends QuranState {
  final List<Surah> surahs;
  final Surah? selectedSurah;
  final String? tafseer;

  const QuranLoaded({
    required this.surahs,
    this.selectedSurah,
    this.tafseer,
  });

  @override
  List<Object?> get props => [surahs, selectedSurah, tafseer];

  QuranLoaded copyWith({
    List<Surah>? surahs,
    Surah? selectedSurah,
    String? tafseer,
  }) {
    return QuranLoaded(
      surahs: surahs ?? this.surahs,
      selectedSurah: selectedSurah ?? this.selectedSurah,
      tafseer: tafseer ?? this.tafseer,
    );
  }
}

class QuranError extends QuranState {
  final String message;

  const QuranError(this.message);

  @override
  List<Object?> get props => [message];
} 