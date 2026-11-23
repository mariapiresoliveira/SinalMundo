import 'package:flutter_test/flutter_test.dart';
import 'package:sinalmundo_mvp/state/sinalmundo_controller.dart';

void main() {
  group('SinalMundoController', () {
    test('concede XP apenas na primeira conclusão da mesma história', () {
      final controller = SinalMundoController();
      final initialXp = controller.xp;

      expect(controller.completeStory('historia-1'), isTrue);
      expect(controller.xp, initialXp + 30);
      expect(controller.completedStories, 1);

      expect(controller.completeStory('historia-1'), isFalse);
      expect(controller.xp, initialXp + 30);
      expect(controller.completedStories, 1);
    });

    test('avança de nível ao alcançar a meta de XP', () {
      final controller = SinalMundoController()..xp = 2990;

      expect(controller.completeStory('historia-2'), isTrue);
      expect(controller.level, 4);
      expect(controller.xp, 20);
    });

    test('concede XP de tema e sinal apenas uma vez', () {
      final controller = SinalMundoController();
      final initialXp = controller.xp;

      controller.markTopicExplored('animals');
      controller.markTopicExplored('animals');
      controller.markSignViewed('animals-cachorro');
      controller.markSignViewed('animals-cachorro');

      expect(controller.xp, initialXp + 55);
      expect(controller.completedTopics, 1);
      expect(controller.signsViewed, 1);
      expect(controller.hasExploredTopic('animals'), isTrue);
      expect(controller.hasViewedSign('animals-cachorro'), isTrue);
    });
  });
}
