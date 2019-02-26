# Prog

- Verificar tags SEO para o google - Título do post

# Primeiros posts

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
