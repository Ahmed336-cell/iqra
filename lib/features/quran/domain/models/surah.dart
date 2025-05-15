import 'package:equatable/equatable.dart';

class Surah extends Equatable {
  final int number;
  final String name;
  final String englishName;
  final String englishNameTranslation;
  final int numberOfAyahs;
  final String revelationType;
  final List<Ayah> ayahs;

  const Surah({
    required this.number,
    required this.name,
    required this.englishName,
    required this.englishNameTranslation,
    required this.numberOfAyahs,
    required this.revelationType,
    required this.ayahs,
  });

  factory Surah.fromJson(Map<String, dynamic> json) {
    return Surah(
      number: json['number'],
      name: json['name'],
      englishName: json['englishName'],
      englishNameTranslation: json['englishNameTranslation'],
      numberOfAyahs: json['numberOfAyahs'],
      revelationType: json['revelationType'],
      ayahs: (json['ayahs'] as List)
          .map((ayah) => Ayah.fromJson(ayah))
          .toList(),
    );
  }

  @override
  List<Object?> get props => [
        number,
        name,
        englishName,
        englishNameTranslation,
        numberOfAyahs,
        revelationType,
        ayahs,
      ];
}

class Ayah extends Equatable {
  final int number;
  final String text;
  final int numberInSurah;
  final int juz;
  final int hizbQuarter;
  final String? tafseer;

  const Ayah({
    required this.number,
    required this.text,
    required this.numberInSurah,
    required this.juz,
    required this.hizbQuarter,
    this.tafseer,
  });

  factory Ayah.fromJson(Map<String, dynamic> json) {
    return Ayah(
      number: json['number'],
      text: json['text'],
      numberInSurah: json['numberInSurah'],
      juz: json['juz'],
      hizbQuarter: json['hizbQuarter'],
      tafseer: json['tafseer'],
    );
  }

  @override
  List<Object?> get props => [
        number,
        text,
        numberInSurah,
        juz,
        hizbQuarter,
        tafseer,
      ];
} 