# Prog

# Tasks

- A principio acho legal duas páginas:

  - /
  - /videos
  - /videos/:slug

- Na página de vídeos, eu vou carregar os registros de uma tabela no banco de dados.

# Primeiros vídeos

- Subir site

- Gzip usando nginx vs gzip usando phoenix:digest
  - Explicar sobre compressão descompressão
  - Fazer alguns testes do tamanho dos arquivos e tempo de carregamento
  - Habilitar gzip pelo nginx
  - Fazer alguns testes mostrando a diferença
  - Quem está fazendo a descompressão? R: chrome, firefox, edge.
  - Quem está fazendo a compressão? Nginx. Em que momento? Para cada requisição.
  - Gerar um arquivo gzip uma única vez pelo phoenix e habilitar gzip_static no nginx
  - Mostrar que não fez muita diferença no tempo de resposta.
- Removendo classes não utilizadas com purge-css
  - Nós podemos ajudar ainda mais o gzip e remover aquilo que não estamos usando
  - PurgeCSS irá remover todas as classes não utilizadas, bem útil para frameworks principalemente.
- Fazendo cache da página de vídeos
- Implementando pesquisa usando fulltext do Postgres
- Implementando Newsletter (ep1. inscrever email + ep2. enviar email + ep3. Desinscrever)
  - Newsletter avisando quando tiver vídeo novo
  - Armazenar os emails
    - email (unique)
    - canceled_at (null)
  - Mostrar widget na página inicial para a pessoa preencher o email e se inscrever
  - Próximo ep: mandando emails

Olá, esse é o primeiro video sobre a implementação de um sistema
de newsletter para esse projeto que vocês estão vendo na tela.
Eu comecei esse projeto para divulgar aulas/tutoriais/conteúdos sobre
programação funcional e performance.
Isso tudo foi ontem em um momento de inspiração, vamos ver se vai dar certo.

Essa newsletter é responsável por enviar emails para as pessoas inscritas quando algum
conteúdo novo for postado (estiver disponível no site). A ideia principal é essa.

Eu vou dividir em três videos:

- inscrição (back-end e widget)
- envio
- cancelamento

Antes de começar, um aviso. Revendo o video agora, e eu percebi que fui direto ao ponto, até de mais. Talvez esse não seja o conteúdo mais amigável para quem está começando
com elixir. Ainda estou pegando prática, então tenha paciência comigo hehe.

Uma outra coisa que eu quero comentar antes, é que vocês vão ver o nome do projeto e dos módulos como Prog, de Programação.
Foi o que pensei na hora quando gerei o projeto, e vocês podem ver que sou bem criativo.

Então, agora sim, vamos começar.
