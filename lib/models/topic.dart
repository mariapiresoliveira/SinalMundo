import 'package:flutter/material.dart';

class Topic {
  const Topic({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.emoji,
    required this.color,
    required this.words,
  });

  final String id;
  final String title;
  final String subtitle;
  final String emoji;
  final Color color;
  final List<String> words;
}
