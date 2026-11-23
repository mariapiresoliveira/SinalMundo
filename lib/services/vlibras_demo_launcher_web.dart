import 'dart:html' as html;

import '../models/sign_entry.dart';

/// Abre a página oficial do Widget com um termo individual do catálogo.
bool openVlibrasDemo(SignEntry entry) {
  return _openVlibrasPage(
    entry.term,
    category: entry.categoryTitle,
    parameters: <String, String>{
      'cm': entry.handShapeDescription,
      'pa': entry.handPositionDescription,
      'movement': entry.movementNote,
      'orientation': entry.palmOrientation,
      'enm': entry.nonManualMarkers,
    },
    isStoryText: false,
  );
}

/// Abre texto livre (uma frase ou trecho da história) para tradução pelo
/// Widget. A criança inicia a tradução pela seleção do texto na página oficial.
bool openVlibrasTextDemo(String text, {String category = 'História criada'}) {
  return _openVlibrasPage(
    text,
    category: category,
    parameters: const <String, String>{},
    isStoryText: true,
  );
}

bool _openVlibrasPage(
  String text, {
  required String category,
  required Map<String, String> parameters,
  required bool isStoryText,
}) {
  final cleanText = text.trim();
  if (cleanText.isEmpty) return false;

  final query = <String, String>{
    'term': cleanText,
    'category': category,
    if (isStoryText) 'mode': 'story',
    ...parameters,
  };
  final uri = Uri.base.resolve('vlibras_demo.html').replace(queryParameters: query);
  try {
    final opened = html.window.open(uri.toString(), '_blank');
    return opened != null;
  } catch (_) {
    return false;
  }
}
