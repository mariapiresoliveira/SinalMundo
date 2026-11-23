import 'package:flutter/material.dart';

import '../models/story.dart';
import '../models/topic.dart';

class DemoData {
  static const topics = <Topic>[
    Topic(id: "animals", title: "Animais", subtitle: "Quem vive por aqui?", emoji: "🐾", color: const Color(0xFF57A96B), words: ["Cachorro", "Gato", "Pássaro", "Peixe", "Cavalo", "Borboleta", "Coelho", "Sapo", "Macaco", "Vaca"]),
    Topic(id: "school", title: "Escola", subtitle: "Aprender e descobrir", emoji: "🎒", color: const Color(0xFF4F9DE8), words: ["Livro", "Lápis", "Mesa", "Professor", "Escola", "Aluno", "Caderno", "Borracha", "Caneta", "Lousa"]),
    Topic(id: "family", title: "Família", subtitle: "Pessoas e vínculos", emoji: "👨‍👩‍👧", color: const Color(0xFFE79A54), words: ["Mãe", "Pai", "Irmão", "Irmã", "Avó", "Avô", "Filho", "Filha", "Tio", "Tia"]),
    Topic(id: "food", title: "Comida", subtitle: "Palavras da alimentação", emoji: "🍎", color: const Color(0xFFE46C69), words: ["Maçã", "Banana", "Arroz", "Leite", "Pão", "Água", "Carne", "Ovo", "Café", "Suco"]),
    Topic(id: "emotions", title: "Emoções", subtitle: "Expressar sentimentos", emoji: "💛", color: const Color(0xFFD99A37), words: ["Feliz", "Triste", "Bravo", "Surpreso", "Cansado", "Assustado", "Amor", "Preocupado", "Calmo", "Animado"]),
    Topic(id: "nature", title: "Natureza", subtitle: "Elementos naturais", emoji: "🌿", color: const Color(0xFF5CA66A), words: ["Árvore", "Flor", "Sol", "Lua", "Chuva", "Nuvem", "Mar", "Montanha"]),
    Topic(id: "city", title: "Cidade", subtitle: "Lugares e transportes", emoji: "🏙️", color: const Color(0xFF8A76C6), words: ["Casa", "Rua", "Carro", "Ônibus", "Hospital", "Loja", "Praça", "Ponte"]),
    Topic(id: "sports", title: "Esportes", subtitle: "Movimento e práticas", emoji: "⚽", color: const Color(0xFF55A9A4), words: ["Futebol", "Basquete", "Natação", "Correr", "Bicicleta", "Pular", "Vôlei", "Dançar"]),
    Topic(id: "art", title: "Arte", subtitle: "Expressões artísticas", emoji: "🎨", color: const Color(0xFFE17C9A), words: ["Pintar", "Desenhar", "Música", "Cantar", "Tocar", "Cor", "Teatro", "Fotografia"]),
    Topic(id: "routine", title: "Rotina", subtitle: "Ações do cotidiano", emoji: "☀️", color: const Color(0xFFDBB34B), words: ["Dormir", "Acordar", "Escovar Dentes", "Banho", "Almoçar", "Estudar", "Trabalhar", "Brincar"]),
  ];

  static const stories = <Story>[
    Story(
      id: 'first-sign',
      title: 'O primeiro sinal',
      summary: 'Bia conhece Davi e descobre uma nova forma de dizer olá.',
      emoji: '👋',
      pages: [
        'Bia conheceu um colega novo chamado Davi, que é surdo.',
        'Davi fez um sinal com a mão aberta e sorriu: era uma forma de dizer “oi”.',
        'Bia repetiu o sinal e os dois começaram uma amizade.',
      ],
    ),
    Story(
      id: 'class-party',
      title: 'A festa da turma',
      summary: 'A turma aprende a incluir todo mundo na comemoração.',
      emoji: '🎂',
      pages: [
        'A turma preparou uma festa de aniversário para celebrar um dia especial.',
        'Com a ajuda da professora, todos conheceram formas de desejar parabéns em Libras.',
        'No final, cada criança participou da festa e se sentiu parte do grupo.',
      ],
    ),
    Story(
      id: 'hands-talk',
      title: 'Um dia de mãos que falam',
      summary: 'As crianças percebem que comunicação também envolve rosto e olhar.',
      emoji: '🤟',
      pages: [
        'Hoje a aula foi dedicada a descobrir diferentes formas de comunicação.',
        'As crianças observaram gestos, expressões do rosto e movimentos do corpo.',
        'Elas descobriram que podemos aprender e nos entender de muitos jeitos.',
      ],
    ),
    Story(
      id: 'park-trip',
      title: 'Um passeio no parque',
      summary: 'Milo acompanha a turma em uma descoberta pela natureza.',
      emoji: '🌳',
      pages: [
        'Milo convidou os amigos para explorar o parque e observar tudo ao redor.',
        'No caminho, o grupo encontrou árvores, flores, pássaros e um lago.',
        'A turma registrou as descobertas e escolheu novos temas para aprender em Libras.',
      ],
    ),
  ];
}
