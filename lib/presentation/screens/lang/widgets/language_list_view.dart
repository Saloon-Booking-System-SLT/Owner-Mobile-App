import 'package:flutter/material.dart';
import 'language_button.dart';

class LanguageListView extends StatelessWidget {
  final String selectedLanguage;
  final Map<String, String> languages;
  final ValueChanged<String> onLanguageSelected;

  const LanguageListView({
    super.key,
    required this.selectedLanguage,
    required this.languages,
    required this.onLanguageSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: languages.entries.map((entry) => Padding(
        padding: const EdgeInsets.only(bottom: 16),
        child: LanguageButton(
          language: entry.key,
          text: entry.value,
          isSelected: selectedLanguage == entry.key,
          onTap: () => onLanguageSelected(entry.key),
        ),
      )).toList(),
    );
  }
}
