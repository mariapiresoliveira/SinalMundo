import 'package:flutter_test/flutter_test.dart';
import 'package:sinalmundo_mvp/services/story_sign_matcher.dart';

void main() {
  group('StorySignMatcher', () {
    test('reconhece termos com acentos e caixa diferentes', () {
      final matches = StorySignMatcher.findInText('A ÁRVORE tem uma FLOR e um CACHORRO.');
      final terms = matches.map((match) => match.entry.term).toSet();

      expect(terms, contains('Árvore'));
      expect(terms, contains('Flor'));
      expect(terms, contains('Cachorro'));
    });

    test('reconhece plurais comuns e expressão composta', () {
      final matches = StorySignMatcher.findInText('Os cachorros viram árvores e foram escovar os dentes.');
      final terms = matches.map((match) => match.entry.term).toSet();

      expect(terms, contains('Cachorro'));
      expect(terms, contains('Árvore'));
      expect(terms, contains('Escovar Dentes'));
    });

    test('não reconhece uma palavra apenas por estar dentro de outra', () {
      final matches = StorySignMatcher.findInText('O casamento foi alegre.');
      expect(matches.any((match) => match.entry.term == 'Casa'), isFalse);
    });

    test('separa uma narrativa em trechos e mantém a pontuação', () {
      final pages = StorySignMatcher.splitIntoPages('Milo viu o sol. Depois encontrou uma flor!');
      expect(pages, ['Milo viu o sol.', 'Depois encontrou uma flor!']);
    });

    test('divide textos longos sem quebrar caracteres emoji', () {
      final text = List<String>.filled(481, '🙂').join();
      final pages = StorySignMatcher.splitIntoPages(text);

      expect(pages, hasLength(2));
      expect(pages.first.runes.length, 480);
      expect(pages.last, '🙂');
    });
  });
}
