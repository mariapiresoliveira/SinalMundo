/// Descrições em linguagem natural derivadas dos dois manuais enviados.
/// Quando os PDFs não detalham a anatomia de uma CM, o app informa a lacuna
/// em vez de inventar a posição dos dedos.
class SignParameterDescriptions {
  static String handShape(String cm) {
    final v = cm.toLowerCase();

    // Configurações compostas: não reduza duas mãos/configurações a uma só.
    if (v.contains(' / ') && !v.contains('espalmada cruzada')) {
      if (v.contains("'v'") && v.contains("'l'")) {
        return 'O registro combina duas configurações: CM V e CM L. Para a CM L, o manual descreve indicador estendido e polegar aberto em ângulo reto; para a forma V, consulte a referência de configuração e valide o detalhe da variante usada no sinal.';
      }
      if (v.contains('espalmada') && (v.contains("'f'") || v.contains('pinça'))) {
        return 'O registro combina uma configuração F/pinça com uma mão espalmada. O manual descreve a mão espalmada como aberta e com dedos estendidos; a forma específica da configuração F/pinça precisa ser conferida na matriz e validada.';
      }
      return 'O registro indica mais de uma configuração de mão: $cm. A ficha preserva as duas formas na ordem do manual; o material enviado não detalha a anatomia completa de todas as combinações, portanto a composição deve ser conferida e validada.';
    }

    if (v.contains('45') || v.contains('46') || v.contains('47') || v.contains('garra')) {
      return 'Dedos dobrados, arqueados e entreabertos, formando uma configuração de garra. O manual cita as CM 45/46/47 para este grupo.';
    }
    if (v.contains('cm 1') || v.contains("'a'") || v.contains('cm a')) {
      return 'Mão fechada em punho, com os dedos dobrados e o polegar encostado lateralmente, conforme a descrição da CM 1 (A) no manual ilustrado.';
    }
    if (v.contains('8a') || v.contains("'l'") || v.contains('cm l')) {
      return 'Indicador estendido e polegar aberto, formando aproximadamente um ângulo reto. Os demais dedos ficam recolhidos, conforme a descrição da CM 8a (L).';
    }
    if (v.contains('12') || v.contains("'d'")) {
      return 'Indicador apontado para cima; os demais dedos ficam unidos ao polegar, conforme a descrição da CM 12 (D).';
    }
    if (v.contains('14') || v.contains('indicador estendido') || v == 'cm indicador') {
      return 'Mão fechada em punho, mantendo somente o indicador estendido, conforme a descrição da CM 14.';
    }
    if (v.contains('15') || v.contains('gancho')) {
      return 'Indicador projetado e semi-flexionado, formando um gancho, conforme a descrição da CM 15.';
    }
    if (v.contains('27') || v.contains("'u'")) {
      return 'Indicador e dedo médio unidos e estendidos, com o polegar aberto, conforme a descrição da CM 27.';
    }
    if (v.contains('28') || (v.contains("'v'") && v.contains('polegar'))) {
      return 'Indicador e dedo médio abertos em V, com o polegar destacado, conforme a descrição da CM 28.';
    }
    if (v.contains('64') || v.contains('espalmada') || v.contains("'b'")) {
      return 'Mão aberta e espalmada, com os dedos estendidos. Para variantes específicas (como B, folha ou espalmada cruzada), o posicionamento fino deve ser conferido na referência visual e validado.';
    }
    if (v.contains('pinça')) {
      return 'Configuração em pinça: o registro identifica a aproximação do indicador e do polegar. O manual não detalha a posição dos demais dedos para todas as variantes de pinça.';
    }
    if (v.contains('fechada para aberta') || v.contains('aberta para fechada') || v.contains('pinça para aberta')) {
      return 'A descrição indica uma mudança entre uma posição inicial fechada/ aproximada e uma posição aberta. A forma exata de cada dedo não está detalhada no quadro e precisa ser conferida na referência do sinal.';
    }
    if (v.contains('sinal composto') || v.contains('mulher +') || v.contains('homem +') || v.contains('comer +')) {
      return 'O manual descreve um sinal composto por etapas. A posição de cada mão deve acompanhar a sequência dos sinais componentes; a ficha preserva a composição textual sem inventar configurações ausentes.';
    }
    if (v.contains('concha')) {
      return 'O manual identifica uma configuração em concha, mas não especifica a curvatura de cada dedo. A forma precisa deve ser conferida na referência visual e validada.';
    }
    if (v.contains("'y'") || v.contains('v invertido') || v.contains("'s'") || v.contains("'c'") || v.contains("'f'") || v.contains("'5'") || v.contains('dedos soltos') || v.contains('variada') || v.contains('dedos médios')) {
      return 'O manual identifica esta configuração pelo código ou nome indicado, mas não apresenta uma descrição anatômica completa da posição de todos os dedos. A forma deve ser conferida no diagrama de CM e validada por especialista.';
    }
    if (v.contains('aberta')) {
      return 'A mão é descrita como aberta. A separação exata e a flexão de cada dedo não estão detalhadas no texto fornecido; conferir a referência visual e validar.';
    }
    return 'O manual informa “$cm”, mas não detalha a posição anatômica completa da mão nas páginas fornecidas. A ficha mantém o código original e sinaliza esta parte para conferência.';
  }

  static String handPosition(String pa) {
    final v = pa.toLowerCase();
    if (v.contains('espaço neutro')) {
      final extra = v.replaceAll('espaço neutro', '').replaceAll('(', '').replaceAll(')', '').trim();
      if (extra.isNotEmpty) {
        return 'A mão fica no espaço à frente do corpo, sem tocar diretamente uma região corporal; o registro especifica a altura/região de referência: ${extra.replaceAll(RegExp(r'^[-–/]'), '').trim()}.';
      }
      return 'A mão fica no espaço neutro à frente do corpo, sem contato direto com uma região corporal.';
    }
    if (v.contains(' / ') || v.contains(' + ') || v.contains(' e ')) {
      return 'O registro indica mais de uma região de articulação: $pa. A mão se desloca entre as regiões conforme a sequência descrita no campo de movimento; quando a ordem não está explícita, ela precisa ser conferida com demonstração validada.';
    }
    if (v.contains('testa')) return 'A mão é posicionada junto à testa. Quando o registro indica “lateral” ou “centro”, essa localização deve ser observada exatamente como descrita.';
    if (v.contains('olho') || v.contains('nariz') || v.contains('bochecha')) return 'A mão é posicionada na região do rosto indicada no registro: $pa. Observe o ponto específico, pois pequenas mudanças de localização podem alterar o sinal.';
    if (v.contains('boca') || v.contains('lábio') || v.contains('queixo') || v.contains('dente')) return 'A mão é articulada próxima à região da boca/queixo indicada no registro: $pa. O contato e a sequência devem seguir a referência do sinal.';
    if (v.contains('peito') || v.contains('tronco') || v.contains('abdômen')) return 'A mão atua na região do tronco indicada: $pa. O movimento pode ocorrer em contato com o corpo ou junto a essa região, conforme o registro.';
    if (v.contains('antebraço') || v.contains('braço') || v.contains('palma da mão') || v.contains('dorso da mão') || v.contains('mão passiva')) return 'A mão ativa se posiciona em relação à região de apoio indicada: $pa. A mão/ braço passivo funciona como referência quando assim descrito.';
    if (v.contains('ombro')) return 'A mão é posicionada na região do ombro ou no espaço próximo a ele, conforme a localização registrada: $pa.';
    if (v.contains('espaço neutro') == false && (v.contains('/') || v.contains('+') || v.contains(' e '))) {
      return 'O registro indica mais de uma região: $pa. A ficha preserva todas as posições descritas; a sequência exata deve ser conferida com uma demonstração validada.';
    }
    return 'Segundo o manual, a articulação acontece em: $pa. Esta descrição textual explica a localização indicada, sem acrescentar um ponto que não esteja na fonte.';
  }

  static String movementNote(String movement) {
    return 'Registro textual do manual: $movement. A demonstração específica deste movimento ainda aguarda validação.';
  }
}
