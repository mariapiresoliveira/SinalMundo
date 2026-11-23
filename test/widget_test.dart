import 'package:flutter_test/flutter_test.dart';
import 'package:sinalmundo_mvp/app.dart';
import 'package:sinalmundo_mvp/state/sinalmundo_controller.dart';

void main() {
  testWidgets('apresenta a tela inicial sem módulo de atividades interativas', (tester) async {
    await tester.pumpWidget(SinalMundoApp(controller: SinalMundoController()));

    expect(find.text('SINALMUNDO'), findsOneWidget);
    expect(find.text('Mundo Vivo'), findsWidgets);
    expect(find.text('Biblioteca de Histórias'), findsOneWidget);
    expect(find.text('Atividades Interativas'), findsNothing);
  });
}
