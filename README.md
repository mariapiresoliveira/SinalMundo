# SinalMundo

Aplicativo educacional em Flutter para explorar Libras por temas do cotidiano, consultar um catálogo de referência e criar histórias livres.

## O que existe nesta versão

- **Início:** resumo da jornada, XP, nível e atalhos para os módulos.
- **Mundo Vivo:** dez áreas temáticas com palavras e acesso às fichas correspondentes.
- **Catálogo de Sinais:** 90 registros em dez categorias, com busca que ignora maiúsculas e acentos.
- **Ficha do termo:** os cinco parâmetros transcritos do manual, diagramas gerais de referência, estado de revisão e atalho para preparar o texto no Widget oficial do VLibras.
- **Biblioteca de Histórias:** quatro narrativas demonstrativas e as histórias escritas durante a sessão.
- **Criador de Histórias:** texto livre, identificação de termos do catálogo, separação em trechos e atalhos para preparar termos ou frases no Widget.
- **Leitor de Histórias:** leitura por trechos, navegação anterior/próximo e conclusão com registro de XP.
- **Árvore da Comunicação:** acompanhamento visual dos sinais vistos, histórias concluídas e temas explorados.
- **Área do Educador:** tela demonstrativa, sem contas, turmas reais ou relatórios sincronizados.

## Catálogo e validação de Libras

Os 90 registros foram transcritos dos PDFs fornecidos no projeto. Cada ficha inclui configuração de mão (CM), ponto de articulação (PA), movimento (M), orientação da palma (O) e expressões não manuais (ENM), além de contexto e referência de página quando disponíveis.

**Os registros ainda aguardam validação linguística e pedagógica.** Os PDFs não fornecem vídeos individuais dos 90 sinais. Por isso, o espaço visual de cada ficha informa quando a demonstração específica está pendente. O projeto não simula movimentos genéricos como se fossem sinais corretos. Os diagramas incorporados são referências gerais dos parâmetros, não demonstrações lexicais.

## Integração do Widget VLibras

A versão Web carrega o Widget oficial remotamente. Ao clicar em um atalho de termo ou trecho, o SinalMundo abre `web/vlibras_demo.html` com o texto selecionável e, nas fichas, os parâmetros transcritos do registro.

A tradução **não começa automaticamente**: a criança precisa abrir o botão flutuante do Widget e selecionar o texto na página. O Widget realiza tradução automática, e não garante que cada palavra isolada corresponda a um sinal lexical específico ou à variante regional esperada. Consulte `INTEGRACAO_VLIBRAS_OFICIAL.md` para o fluxo e as limitações.

O avatar e o player são servidos pelo site oficial. Este ZIP não contém nem redistribui arquivos do modelo 3D ou suas animações.

## Criador de Histórias

A criança pode escrever qualquer narrativa, sem escolher personagens, lugares ou objetos de uma lista fechada. O aplicativo procura correspondências exatas no catálogo local, ignorando maiúsculas, acentos e limites de palavra, e reconhece alguns plurais comuns. A busca não interpreta livremente sinônimos nem garante encontrar todas as formas de uma palavra.

Cada termo reconhecido abre sua ficha e um atalho para a tradução automática do termo no Widget. Cada trecho também pode ser enviado como texto livre. A presença de um termo na história não significa que seu sinal esteja validado.

As histórias criadas ficam na biblioteca **somente durante a sessão atual**. A persistência após fechar o aplicativo ainda não foi implementada.

## Escopo e limitações

- Não há atividades de associação, memória ou sequência.
- Não há câmera, reconhecimento facial, reconhecimento automático de sinais ou realidade aumentada.
- Firebase, login, perfis, turmas reais e sincronização não estão conectados.
- A pontuação e o progresso são dados locais demonstrativos e reiniciam quando a aplicação é reiniciada.
- A tradução do Widget requer internet e interação manual na página aberta.

## Executar no Windows / Chrome

Use Flutter 3.27 ou superior (Dart 3.6 ou superior). Na pasta que contém `pubspec.yaml`, execute no PowerShell:

```powershell
flutter pub get
flutter run -d chrome
```

A pasta `web/` já vem configurada e inclui a página auxiliar do VLibras. **Não execute `flutter create --platforms=web .` sobre esta versão**, pois isso pode substituir arquivos Web personalizados.

Também é possível usar `ABRIR_NO_CHROME.bat`: ele instala dependências, executa análise estática, roda os testes e inicia o Chrome sem recriar a pasta Web.

## Estrutura

```text
lib/
  core/theme/       Paleta e tema visual
  data/             Dados demonstrativos e catálogo de 90 registros
  models/           Modelos de histórias, temas e sinais
  screens/          Telas do aplicativo
  services/         Busca de termos e abertura do Widget
  state/            Estado local da jornada
  widgets/          Componentes reutilizáveis
assets/reference/   Diagramas gerais dos parâmetros
web/                Página Flutter Web e página auxiliar do VLibras
test/               Testes do reconhecedor de termos
```

## Testes

Há testes unitários para a identificação de termos, divisão de histórias em trechos e concessão única de XP por história. Antes de entregar, execute a análise estática e os testes com:

```powershell
flutter analyze
flutter test
```

Antes de usar o catálogo como material de ensino, cada sinal precisa ser revisado por pessoas surdas/fluentes em Libras e educadores bilíngues, incluindo as variantes regionais.
