import 'package:flutter/material.dart';

import '../data/sign_parameter_descriptions.dart';

/// Registro editorial de um termo e dos cinco parâmetros transcritos do manual
/// enviado pelo usuário. O status permanece pendente até validação especializada.
class SignEntry {
  const SignEntry({
    required this.id,
    required this.catalogNumber,
    required this.term,
    required this.categoryId,
    required this.categoryTitle,
    required this.categoryEmoji,
    required this.categoryColor,
    required this.handConfiguration,
    required this.location,
    required this.movement,
    required this.palmOrientation,
    required this.nonManualMarkers,
    required this.sourcePage,
    required this.contextText,
    this.regionalVariation,
    this.videoAsset,
    this.animationAsset,
    this.reviewStatus = SignReviewStatus.pending,
    this.reviewNote = 'Transcrito do manual fornecido; aguarda revisão linguística e pedagógica.',
  });

  final String id;
  final int catalogNumber;
  final String term;
  final String categoryId;
  final String categoryTitle;
  final String categoryEmoji;
  final Color categoryColor;

  /// Cinco parâmetros exatamente conforme o catálogo de origem.
  final String handConfiguration; // CM
  final String location; // PA
  final String movement; // M
  final String palmOrientation; // O
  final String nonManualMarkers; // ENM

  /// Página impressa do Guia Completo de Libras enviado pelo usuário.
  final int sourcePage;
  final String contextText;
  final String? regionalVariation;

  /// Mídia específica só poderá ser vinculada após produção/licença e revisão.
  final String? videoAsset;
  final String? animationAsset;
  final SignReviewStatus reviewStatus;
  final String reviewNote;

  String get handShapeDescription => SignParameterDescriptions.handShape(handConfiguration);
  String get handPositionDescription => SignParameterDescriptions.handPosition(location);
  String get movementNote => SignParameterDescriptions.movementNote(movement);

  bool get hasReviewedContent => reviewStatus == SignReviewStatus.approved;
}

enum SignReviewStatus { pending, inReview, approved }

extension SignReviewStatusLabel on SignReviewStatus {
  String get label => switch (this) {
        SignReviewStatus.pending => 'Aguardando validação',
        SignReviewStatus.inReview => 'Em revisão',
        SignReviewStatus.approved => 'Validado',
      };
}
