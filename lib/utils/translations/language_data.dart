// language_data.dart
import 'package:flutter/material.dart';

class Language {
  final String code;
  final String name;
  final String flag;

  Language({required this.code, required this.name, required this.flag});
}

List<Language> languages = [
  Language(code: 'en', name: 'English', flag: 'assets/svg/us.svg'),
  Language(code: 'bn', name: 'বাংলা', flag: 'assets/svg/bd.svg'),
  Language(code: 'ar', name: 'Saudi Arabia', flag: 'assets/svg/saudi-arab.svg'),
  // Add more languages and flags as needed
];


