# Integração oficial do VLibras no SinalMundo

## O que foi integrado

- Widget oficial carregado no `web/index.html`, com avatar Ícaro como padrão e posição à direita.
- Página `web/vlibras_demo.html`, aberta com o termo selecionável e, na ficha do catálogo, os dados de referência dos cinco parâmetros.
- Atalho `Preparar termo no VLibras 3D` em cada ficha.
- A integração funciona como página Web; o aplicativo principal continua navegável mesmo se o serviço remoto estiver indisponível.

## Fluxo de tradução por termo

1. Na ficha de um sinal, clique em **Preparar termo no VLibras 3D**.
2. A página de demonstração abre em outra aba e mostra o termo em texto HTML selecionável.
3. Clique no botão flutuante do VLibras.
4. Passe o cursor sobre o termo destacado e clique quando o Widget indicar que ele pode ser traduzido.

Esse é o fluxo documentado pelo manual do Widget. O atalho prepara o texto, mas não inicia a tradução nem reproduz automaticamente um sinal lexical específico. O Widget não oferece, no manual público consultado, uma chamada programática documentada para reproduzir diretamente uma palavra individual a partir do Flutter. Por isso, o projeto usa a seleção de texto suportada oficialmente.

## Avatar e opções

O avatar padrão foi configurado como `icaro`. A documentação oficial também lista `hosana`, `guga` e `random`. O usuário pode trocar o avatar pelo próprio menu do Widget, quando a opção estiver disponível na versão carregada.

## Autorização

O projeto foi preparado com base na informação do responsável pelo SinalMundo de que recebeu permissão. Guarde a autorização por escrito e confirme que ela abrange especificamente: uso educacional no SinalMundo, incorporação do Widget oficial, uso dos avatares e traduções geradas para demonstração dos sinais do catálogo, e distribuição da aplicação. Se a autorização abranger apenas o Widget de acessibilidade em páginas Web, não presuma que ela também autoriza extrair ou redistribuir o modelo 3D ou arquivos de animação.

## Limitações pedagógicas

- O Widget traduz texto selecionado automaticamente; não é garantia de que cada palavra isolada terá um sinal lexical equivalente ou de que a tradução será adequada ao contexto.
- O resultado pode variar por regionalismo e pode conter imprecisões.
- O texto dos parâmetros nas fichas continua sendo a transcrição dos manuais fornecidos, pendente de validação linguística especializada.
- A tradução automática não substitui revisão por pessoas surdas e fluentes em Libras nem intérprete humano quando exigido.
- Para uma animação controlada diretamente por cada registro, será necessário um contrato/API oficial ou pacote de animações com documentação e autorização específicas. Esta versão não acessa endpoints antigos ou não documentados para tentar forçar esse controle.

## Fonte técnica oficial consultada

- Manual do Widget VLibras 7.0.0: https://vlibras.gov.br/doc/widget/installation/webpageintegration.html
- Tradução de texto no Widget: https://www.vlibras.gov.br/doc/widget/functionalities/text-translation.html
- Termos e aviso de privacidade: https://www.vlibras.gov.br/privacy.html

A execução do Widget exige internet, pois o script e o player 3D são fornecidos pelo serviço oficial. O aplicativo Flutter não baixa nem redistribui o avatar ou os arquivos de animação.
