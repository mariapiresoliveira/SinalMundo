import '../data/sign_catalog_data.dart';
import '../models/sign_entry.dart';

/// Encontra termos do catálogo de 90 sinais dentro de uma história livre.
/// A busca ignora maiúsculas, acentos e pontuação. Também reconhece algumas
/// formas plurais comuns. Não tenta inferir sinais que não estejam no catálogo.
class StorySignMatcher {
  const StorySignMatcher._();

  static List<StorySignMatch> findInText(String text) {
    final normalizedText = normalize(text);
    if (normalizedText.trim().isEmpty) return const [];

    final results = <StorySignMatch>[];
    for (final entry in SignCatalogData.entries) {
      final matchedPositions = <int>{};
      var firstPosition = normalizedText.length;

      for (final variant in _variantsFor(entry.term)) {
        var from = 0;
        while (from < normalizedText.length) {
          final position = normalizedText.indexOf(variant, from);
          if (position < 0) break;
          final end = position + variant.length;
          final leftBoundary = position == 0 || !_isWordCharacter(normalizedText[position - 1]);
          final rightBoundary = end == normalizedText.length || !_isWordCharacter(normalizedText[end]);
          if (leftBoundary && rightBoundary) {
            matchedPositions.add(position);
            if (position < firstPosition) firstPosition = position;
          }
          from = position + variant.length;
        }
      }

      if (matchedPositions.isNotEmpty) {
        results.add(StorySignMatch(
          entry: entry,
          occurrences: matchedPositions.length,
          firstPosition: firstPosition,
        ));
      }
    }

    results.sort((a, b) => a.firstPosition.compareTo(b.firstPosition));
    return List.unmodifiable(results);
  }

  static List<String> splitIntoPages(String text) {
    final parts = <String>[];
    for (final paragraph in text.trim().split(RegExp(r'\n+'))) {
      for (final match in RegExp(r'[^.!?]+[.!?]*').allMatches(paragraph)) {
        final sentence = (match.group(0) ?? '').trim();
        if (sentence.isEmpty) continue;
        var remaining = sentence;
        // Conta pontos de código Unicode, não unidades UTF-16. Assim, um emoji
        // não é cortado ao meio caso uma frase muito longa precise ser dividida.
        while (remaining.runes.length > 480) {
          final runes = remaining.runes.toList();
          var cutAt = runes.lastIndexOf(0x20, 480);
          if (cutAt < 200) cutAt = 480;
          parts.add(String.fromCharCodes(runes.take(cutAt)).trim());
          remaining = String.fromCharCodes(runes.skip(cutAt)).trim();
        }
        if (remaining.isNotEmpty) parts.add(remaining);
      }
    }
    return parts.isEmpty && text.trim().isNotEmpty ? [text.trim()] : parts;
  }

  static String normalize(String value) {
    return value
        .toLowerCase()
        .replaceAll(RegExp(r'[áàâãä]'), 'a')
        .replaceAll(RegExp(r'[éèêë]'), 'e')
        .replaceAll(RegExp(r'[íìîï]'), 'i')
        .replaceAll(RegExp(r'[óòôõö]'), 'o')
        .replaceAll(RegExp(r'[úùûü]'), 'u')
        .replaceAll('ç', 'c');
  }

  static bool _isWordCharacter(String value) =>
      RegExp(r'[a-z0-9]').hasMatch(value);

  static Set<String> _variantsFor(String term) {
    final base = normalize(term).trim();
    final variants = <String>{base};

    // Expressões compostas frequentes no catálogo.
    if (base == 'escovar dentes') variants.add('escovar os dentes');

    // Plurais transparentes em português para facilitar a escrita espontânea.
    const irregular = <String, List<String>>{
      'irmao': ['irmaos'],
      'irma': ['irmas'],
      'pao': ['paes'],
      'mao': ['maos'],
      'animal': ['animais'],
      'papel': ['papeis'],
      'flor': ['flores'],
      'arvore': ['arvores'],
      'lapis': ['lapis'],
      'onibus': ['onibus'],
    };
    if (irregular.containsKey(base)) variants.addAll(irregular[base]!);

    if (base.endsWith('r') || base.endsWith('z')) {
      variants.add('${base}es');
    } else if (base.endsWith('l')) {
      variants.add('${base.substring(0, base.length - 1)}is');
    } else if (base.endsWith('m')) {
      variants.add('${base.substring(0, base.length - 1)}ns');
    } else if (RegExp(r'[aeiou]$').hasMatch(base) && base != 'avo') {
      variants.add('${base}s');
    }

    return variants;
  }
}

class StorySignMatch {
  const StorySignMatch({
    required this.entry,
    required this.occurrences,
    required this.firstPosition,
  });

  final SignEntry entry;
  final int occurrences;
  final int firstPosition;
}
