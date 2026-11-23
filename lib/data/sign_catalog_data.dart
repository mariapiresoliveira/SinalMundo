import '../models/sign_entry.dart';
import '../models/topic.dart';
import 'demo_data.dart';

/// Catálogo de 90 termos transcritos do Guia Completo de Libras enviado pelo
/// usuário (páginas impressas 3–10). Os parâmetros são mantidos como no manual;
/// todos os registros ficam pendentes de revisão antes de uso como instrução.
class SignCatalogData {
  static final List<SignEntry> entries = List.unmodifiable(_buildEntries());

  static List<SignEntry> _buildEntries() {
    final topics = {for (final topic in DemoData.topics) topic.id: topic};
    return [
      for (var i = 0; i < _rows.length; i++)
        _makeEntry(i + 1, _rows[i], topics),
    ];
  }

  static SignEntry _makeEntry(
    int number,
    List<String> row,
    Map<String, Topic> topics,
  ) {
    final categoryId = row[0];
    final topic = topics[categoryId]!;
    final page = int.parse(row[7]);
    return SignEntry(
      id: '${categoryId}_${_slug(row[1])}',
      catalogNumber: number,
      term: row[1],
      categoryId: categoryId,
      categoryTitle: topic.title,
      categoryEmoji: topic.emoji,
      categoryColor: topic.color,
      handConfiguration: row[2],
      location: row[3],
      movement: row[4],
      palmOrientation: row[5],
      nonManualMarkers: row[6],
      sourcePage: page,
      contextText: 'Termo da categoria ${topic.title}. O manual fornecido não apresenta uma frase contextual para este item.',
      reviewNote: 'Parâmetros transcritos do Guia Completo de Libras fornecido (página $page). Conteúdo ainda pendente de conferência por pessoa surda/fluente em Libras e educador bilíngue, incluindo variantes regionais.' + (row[1] == 'Almoçar' ? " Atenção: o texto de movimento foi mantido como aparece no PDF ('Lavar comida à boca + Meio-dia'); conferir possível erro de digitação na fonte." : ''),
    );
  }

  static String _slug(String value) => value
      .toLowerCase()
      .replaceAll('á', 'a')
      .replaceAll('ã', 'a')
      .replaceAll('â', 'a')
      .replaceAll('à', 'a')
      .replaceAll('é', 'e')
      .replaceAll('ê', 'e')
      .replaceAll('í', 'i')
      .replaceAll('ó', 'o')
      .replaceAll('ô', 'o')
      .replaceAll('õ', 'o')
      .replaceAll('ú', 'u')
      .replaceAll('ç', 'c')
      .replaceAll(' ', '_');

  /// Cada linha: categoria, termo, CM, PA, M, O, ENM, página impressa.
  static const List<List<String>> _rows = [
    ["animals", "Cachorro", "CM 45 (Garra)", "Queixo / Boca", "Tocar repetidamente", "Para trás", "Expressão neutra.", '3'],
    ["animals", "Gato", "CM Pinça (Indicador/Polegar)", "Bochecha", "Abrir dedos movendo lateralmente", "Para fora", "Olhar atento.", '3'],
    ["animals", "Pássaro", "CM Pinça", "Junto ao nariz / boca", "Simular abertura do bico", "Para frente", "Expressão neutra.", '3'],
    ["animals", "Peixe", "CM 64 (Espalmada)", "Espaço neutro", "Ondulatório contínuo", "Para frente", "Movimento suave.", '3'],
    ["animals", "Cavalo", "CM 27 ('U' c/ Polegar)", "Ao lado da testa", "Semicircular repetido", "Para frente", "Expressão neutra.", '3'],
    ["animals", "Borboleta", "CM Espalmada cruzada", "Peito / Espaço neutro", "Balanço simétrico das palmas", "Para dentro", "Expressão leve.", '3'],
    ["animals", "Coelho", "CM 27 ('U' c/ Polegar)", "Ao lado da testa", "Semicircular repetido", "Para trás", "Expressão atenta.", '3'],
    ["animals", "Sapo", "CM 45 (Garra)", "Abaixo do queixo", "Abrir e fechar dedos", "Para baixo", "Inchar bochechas.", '3'],
    ["animals", "Macaco", "CM 45 (Garra)", "Laterais do tronco", "Alternado ascendente/descendente", "Para o corpo", "Coçar o tronco.", '3'],
    ["animals", "Vaca", "CM 'Y'", "Lateral da testa", "Giro de pulso (chifres)", "Para trás", "Expressão neutra.", '3'],
    ["school", "Livro", "CM 'B' (Espalmadas)", "Espaço neutro", "Abertura simétrica de palmas", "Para cima", "Atitude de leitura.", '4'],
    ["school", "Lápis", "CM Pinça cruzada", "À frente da boca", "Esfregar indicador/polegar", "Para trás", "Atenção visual.", '4'],
    ["school", "Mesa", "CM 'B'", "Espaço neutro (abdômen)", "Formar superfície plana e descer", "Para baixo", "Expressão neutra.", '4'],
    ["school", "Professor", "CM 'V' / 'L'", "Espaço neutro / Ombro", "Meia-lua com pequeno salto", "Para frente", "Postura ereta.", '4'],
    ["school", "Escola", "Sinal Composto", "Espaço neutro", "Telhado (Casa) + Estudar", "Para baixo", "Expressão neutra.", '4'],
    ["school", "Aluno", "CM 1 ('A')", "Antebraço passivo", "Tocar / arrastar no braço", "Para baixo", "Expressão neutra.", '4'],
    ["school", "Caderno", "CM Espalmada (folha)", "Espaço neutro", "Virar páginas com mão ativa", "Para cima", "Acompanhamento.", '4'],
    ["school", "Borracha", "CM 'S' / 'A'", "Palma da mão passiva", "Esfregar repetidamente", "Para baixo", "Ação de apagar.", '4'],
    ["school", "Caneta", "CM Pinça fina", "Espaço neutro", "Movimento de escrita no ar", "Para fora", "Atenção ao traço.", '4'],
    ["school", "Lousa", "CM Espalmada", "Espaço neutro alto plano", "Desenhar retângulo", "Para frente", "Olhar elevado.", '4'],
    ["family", "Mãe", "Mulher + Bênção", "Queixo e Bochecha", "Passar no queixo + beijo/bênção", "Para o corpo", "Expressão afetuosa.", '5'],
    ["family", "Pai", "Homem + Bênção", "Queixo e Lábios", "Passar no queixo + tocar lábio", "Para o corpo", "Expressão de respeito.", '5'],
    ["family", "Irmão", "CM Indicador estendido", "Espaço neutro", "Unir indicadores paralelamente", "Para dentro", "Expressão neutra.", '5'],
    ["family", "Irmã", "Mulher + Irmão", "Queixo + Espaço neutro", "Sinal de mulher seguido de irmão", "Para dentro", "Expressão neutra.", '5'],
    ["family", "Avó", "Mulher + Velha", "Queixo", "Mulher + tremer mão no queixo", "Para o corpo", "Expressão carinhosa.", '5'],
    ["family", "Avô", "Homem + Velho", "Queixo", "Homem + tremer mão no queixo", "Para o corpo", "Expressão carinhosa.", '5'],
    ["family", "Filho", "CM Espalmada", "Região central do peito", "Retilíneo para frente fechando", "Para fora", "Expressão neutra.", '5'],
    ["family", "Filha", "Mulher + Filho", "Queixo + Peito", "Sinal de mulher seguido de filho", "Para fora", "Expressão neutra.", '5'],
    ["family", "Tio", "CM 'C'", "Testa (centro)", "Circular curto na testa", "Para trás", "Expressão neutra.", '5'],
    ["family", "Tia", "Mulher + Tio", "Queixo + Testa", "Sinal de mulher seguido de tio", "Para trás", "Expressão neutra.", '5'],
    ["food", "Maçã", "CM 'S'", "Bochecha", "Rotação de pulso na bochecha", "Para trás", "Expressão agradável.", '6'],
    ["food", "Banana", "CM 'L' (Ativa)", "Mão passiva", "Simular descascar a fruta", "Para baixo", "Acompanhamento visual.", '6'],
    ["food", "Arroz", "CM 'A'", "Espaço neutro", "Esfregar mãos alternadamente", "Para dentro", "Expressão neutra.", '6'],
    ["food", "Leite", "CM 'C' para 'S'", "Peito até abdômen", "Descendente mudando CM", "Para baixo", "Ação de ordenhar.", '6'],
    ["food", "Pão", "CM 'S'", "Dorso da mão passiva", "Cortar repetidamente", "Para baixo", "Expressão neutra.", '6'],
    ["food", "Água", "CM 'L'", "Lábios / Boca", "Polegar na boca + indicador balança", "Para dentro", "Sopro/expressão leve.", '6'],
    ["food", "Carne", "CM Pinça", "Bochecha / Mão passiva", "Pinçar levemente a pele", "Para dentro", "Expressão neutra.", '6'],
    ["food", "Ovo", "CM Garra suave", "Espaço neutro", "Descendente simétrico (quebrar)", "Para baixo", "Atenção ao gesto.", '6'],
    ["food", "Café", "CM Pinça pequena", "Ao lado da boca", "Girar levemente o pulso", "Para dentro", "Aroma / saborear.", '6'],
    ["food", "Suco", "CM 'Y'", "Boca", "Rotação de pulso junto aos lábios", "Para dentro", "Expressão de bebê-lo.", '6'],
    ["emotions", "Feliz", "CM 'F' / Espalmada", "Peito", "Ondulado ascendente no peito", "Para dentro", "Obrigatório: Sorriso amplo.", '7'],
    ["emotions", "Triste", "CM 'Y'", "Rosto / Queixo", "Descendente lento no rosto", "Para o corpo", "Cabeça baixa, olhos caídos.", '7'],
    ["emotions", "Bravo", "CM Garra", "Rosto", "Movimento tenso para frente", "Para trás", "Sobrancelhas franzidas.", '7'],
    ["emotions", "Surpreso", "CM Fechada para Aberta", "Próximo aos olhos", "Abertura súbita de dedos", "Para fora", "Boca aberta, olhos arregalados.", '7'],
    ["emotions", "Cansado", "CM Garra", "Peito", "Descendente soltando o tronco", "Para baixo", "Ombros caídos, exaustão.", '7'],
    ["emotions", "Assustado", "CM Fechada para Aberta", "Peito", "Abertura rápida com sobressalto", "Para trás", "Sobressalto corporal.", '7'],
    ["emotions", "Amor", "CM Cruzada no peito", "Peito", "Pressionar braços no peito", "Para o corpo", "Expressão afetuosa e suave.", '7'],
    ["emotions", "Preocupado", "CM 'V' / '3'", "Testa", "Movimento alternado na testa", "Para trás", "Sobrancelhas franzidas.", '7'],
    ["emotions", "Calmo", "CM Espalmada", "Espaço neutro", "Descendente suave e lento", "Para baixo", "Sopro lento, semblante sereno.", '7'],
    ["emotions", "Animado", "CM Espalmada em balanço", "Peito", "Balanço rápido e vibrante", "Para dentro", "Entusiasmo expansivo.", '7'],
    ["nature", "Árvore", "CM Espalmada (Galanho)", "Espaço neutro (Antebraço)", "Balanço leve do pulso", "Para frente", "Olhar direcionado.", '8'],
    ["nature", "Flor", "CM 'F' / Pinça", "Ponta do nariz", "Tocar e cheirar delicadamente", "Para dentro", "Expressão de inalar aroma.", '8'],
    ["nature", "Sol", "CM Fechada para Aberta", "Espaço neutro alto", "Abrir raios no alto", "Para fora", "Olhar elevado e radiante.", '8'],
    ["nature", "Lua", "CM 'C'", "Ao lado do olho / testa", "Desenhar o arco da meia-lua", "Para fora", "Olhar atento ao arco.", '8'],
    ["nature", "Chuva", "CM Dedos soltos", "Espaço neutro alto", "Descendente tamborilando dedos", "Para baixo", "Expressão de chuva.", '8'],
    ["nature", "Nuvem", "CM Garra", "Espaço neutro alto", "Desenhar contornos arredondados", "Para fora", "Acompanhamento visual.", '8'],
    ["nature", "Mar", "CM Espalmada", "Espaço neutro", "Ondulação horizontal suave", "Para baixo", "Semblante sereno.", '8'],
    ["nature", "Montanha", "CM Espalmada", "Espaço neutro", "Subir unindo no pico", "Para dentro", "Acompanhar a subida.", '8'],
    ["city", "Casa", "CM 'B' (Telhado)", "Espaço neutro", "Unir pontas formando ângulo", "Para baixo", "Expressão neutra.", '8'],
    ["city", "Rua", "CM 'B' paralelas", "Espaço neutro", "Retilíneo para frente", "Para frente", "Acompanhamento visual.", '8'],
    ["city", "Carro", "CM 'S' (Volante)", "Espaço neutro", "Simular girar um volante", "Para frente", "Atitude de motorista.", '8'],
    ["city", "Ônibus", "CM 'S' c/ polegar", "Espaço neutro", "Mover mãos paralelas", "Para frente", "Expressão neutra.", '8'],
    ["city", "Hospital", "CM Indicador", "Braço / Testa", "Desenhar cruz na pele", "Para dentro", "Expressão neutra.", '8'],
    ["city", "Loja", "CM 'L' / 'F'", "Peito / Espaço neutro", "Balanço alternado", "Para fora", "Acompanhamento.", '8'],
    ["city", "Praça", "CM Indicador", "Espaço neutro", "Desenhar perímetro quadrado/circular", "Para baixo", "Olhar no contorno.", '8'],
    ["city", "Ponte", "CM 'V' (Ativa)", "Antebraço passivo", "Pousar sobre o braço", "Para baixo", "Expressão neutra.", '8'],
    ["sports", "Futebol", "CM 'S' / Aberta", "Espaço neutro", "Simular chute de bola", "Para frente", "Acompanhamento rápido.", '9'],
    ["sports", "Basquete", "CM Concha", "Espaço neutro alto", "Arremesso simétrico acima", "Para cima", "Olhar na cesta.", '9'],
    ["sports", "Natação", "CM Espalmada", "Espaço neutro", "Braçadas alternadas de nado", "Para fora", "Respiração lateral.", '9'],
    ["sports", "Correr", "CM 'L' enganchado", "Espaço neutro", "Movimento rápido alternado", "Para trás", "Expressão de esforço.", '9'],
    ["sports", "Bicicleta", "CM 'S'", "Espaço neutro", "Pedalar circular alternado", "Para frente", "Postura ereta.", '9'],
    ["sports", "Pular", "CM 'V' (Pernas)", "Palma passiva", "Saltar repetidamente", "Para baixo", "Mover a cabeça.", '9'],
    ["sports", "Vôlei", "CM Espalmada", "Espaço neutro alto", "Empurrar ar para cima", "Para cima", "Olhar elevado.", '9'],
    ["sports", "Dançar", "CM V invertido", "Palma passiva", "Balanço gracioso sobre a palma", "Para baixo", "Expressão ritmada.", '9'],
    ["art", "Pintar", "CM Espalmada", "Palma passiva", "Deslizar como pinceladas", "Para baixo", "Acompanhamento visual.", '9'],
    ["art", "Desenhar", "CM 27 ('U' c/ Polegar)", "Palma passiva", "Traçar círculos e linhas", "Para baixo", "Atenção ao traço.", '9'],
    ["art", "Música", "CM '5' / 'B'", "Ouvido e Ombro", "Ondulação rítmica e fluida", "Para o corpo", "Expressão melodiosa.", '9'],
    ["art", "Cantar", "CM Aberta", "Boca", "Ondas saindo da boca", "Para fora", "Expressão lírica.", '9'],
    ["art", "Tocar", "CM Variada", "Espaço neutro", "Simular instrumento específico", "Para o instrumento", "Sincronia ritmada.", '9'],
    ["art", "Cor", "CM Garra", "Queixo", "Tamborilar dedos no queixo", "Para o corpo", "Expressão neutra.", '9'],
    ["art", "Teatro", "CM Dedos médios dobrados", "Bochechas", "Giro semicircular curto", "Para trás", "Expressão dramática.", '9'],
    ["art", "Fotografia", "CM 'L' / Pinça", "Olhos", "Clique de disparador na câmera", "Para o rosto", "Picar os olhos (foco).", '9'],
    ["routine", "Dormir", "CM Aberta para Fechada", "Rosto", "Descendente fechando os olhos", "Para o rosto", "Fechar olhos e pender cabeça.", '10'],
    ["routine", "Acordar", "CM Pinça para Aberta", "Olhos", "Abertura rápida junto aos olhos", "Para fora", "Abrir olhos amplamente.", '10'],
    ["routine", "Escovar Dentes", "CM Indicador", "Dentes", "Horizontal de um lado a outro", "Para trás", "Boca levemente aberta.", '10'],
    ["routine", "Banho", "CM Garra / 'S'", "Peito e Tronco", "Esfregar em sentido descendente", "Para o corpo", "Expressão de higiene.", '10'],
    ["routine", "Almoçar", "Comer + Meio-dia", "Boca + Testa", "Lavar comida à boca + Meio-dia", "Para dentro", "Expressão agradável.", '10'],
    ["routine", "Estudar", "CM Espalmada", "Mão passiva", "Tocar repetidamente o dorso", "Para baixo", "Atenção focada.", '10'],
    ["routine", "Trabalhar", "CM 'L' virado", "Espaço neutro", "Movimento alternado frente/trás", "Para baixo", "Semblante sério.", '10'],
    ["routine", "Brincar", "CM 'Y'", "Espaço neutro", "Rotação rápida dos pulsos", "Para fora", "Expressão alegre e descontraída.", '10'],
  ];
}
