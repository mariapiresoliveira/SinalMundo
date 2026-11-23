import 'package:flutter/widgets.dart';

import '../models/story.dart';

class SinalMundoController extends ChangeNotifier {
  int xp = 1250;
  int level = 3;
  int completedStories = 0;
  int completedTopics = 0;
  int signsViewed = 0;
  final Set<String> _readStoryIds = {};
  final Set<String> _exploredTopicIds = {};
  final Set<String> _viewedSignIds = {};
  final List<Story> _createdStories = [];

  int get xpGoal => 3000;
  double get xpProgress => (xp / xpGoal).clamp(0.0, 1.0).toDouble();
  List<Story> get createdStories => List.unmodifiable(_createdStories);

  bool hasReadStory(String storyId) => _readStoryIds.contains(storyId);
  bool hasExploredTopic(String topicId) => _exploredTopicIds.contains(topicId);
  bool hasViewedSign(String signId) => _viewedSignIds.contains(signId);

  void addCustomStory(Story story) {
    _createdStories.insert(0, story);
    notifyListeners();
  }

  /// Retorna true somente quando a conclusão é inédita e concede XP.
  bool completeStory(String id) {
    if (!_readStoryIds.add(id)) return false;

    completedStories++;
    xp += 30;
    _refreshLevel();
    notifyListeners();
    return true;
  }

  void markTopicExplored(String topicId) {
    if (_exploredTopicIds.add(topicId)) {
      completedTopics = _exploredTopicIds.length;
      xp += 50;
      _refreshLevel();
      notifyListeners();
    }
  }

  void markSignViewed(String signId) {
    if (_viewedSignIds.add(signId)) {
      signsViewed = _viewedSignIds.length;
      xp += 5;
      _refreshLevel();
      notifyListeners();
    }
  }

  void _refreshLevel() {
    while (xp >= xpGoal) {
      xp -= xpGoal;
      level++;
    }
  }
}

class SinalMundoScope extends InheritedNotifier<SinalMundoController> {
  const SinalMundoScope({Key? key, required SinalMundoController controller, required Widget child})
      : super(key: key, notifier: controller, child: child);

  static SinalMundoController of(BuildContext context) {
    final scope = context.dependOnInheritedWidgetOfExactType<SinalMundoScope>();
    assert(scope != null, 'SinalMundoScope não encontrado na árvore.');
    return scope!.notifier!;
  }
}
