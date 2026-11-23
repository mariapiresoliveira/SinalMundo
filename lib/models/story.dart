class Story {
  const Story({
    required this.id,
    required this.title,
    required this.summary,
    required this.emoji,
    required this.pages,
  });

  final String id;
  final String title;
  final String summary;
  final String emoji;
  final List<String> pages;
}
