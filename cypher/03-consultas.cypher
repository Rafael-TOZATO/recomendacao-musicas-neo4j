// 1) Recomendações para Ana: usuários semelhantes por músicas em comum.
MATCH (alvo:Usuario {id: 'u001'})-[:OUVIU]->(ouvida:Musica)
MATCH (parecido:Usuario)-[:OUVIU]->(ouvida)
WHERE parecido <> alvo
WITH alvo, parecido, count(DISTINCT ouvida) AS afinidade
MATCH (parecido)-[op:OUVIU]->(recomendacao:Musica)
WHERE NOT (alvo)-[:OUVIU]->(recomendacao)
RETURN recomendacao.titulo AS musica,
       collect(DISTINCT parecido.nome) AS evidencias,
       afinidade,
       round(avg(op.nota) * 10) / 10.0 AS nota_media,
       recomendacao.popularidade AS popularidade,
       (afinidade * 3) + avg(op.nota) + (recomendacao.popularidade / 100.0) AS score
ORDER BY score DESC, musica;

// 2) Gêneros mais fortes para cada usuário.
MATCH (u:Usuario)-[:OUVIU]->(m:Musica)-[:PERTENCE_A]->(g:Genero)
RETURN u.nome AS usuario, g.nome AS genero, count(*) AS faixas,
       round(avg(m.popularidade) * 10) / 10.0 AS popularidade_media
ORDER BY usuario, faixas DESC;

// 3) Artistas que conectam comunidades de usuários.
MATCH (a:Artista)<-[:CRIADA_POR]-(m:Musica)<-[:OUVIU]-(u:Usuario)
RETURN a.nome AS artista, count(DISTINCT u) AS ouvintes,
       collect(DISTINCT u.nome) AS comunidade
ORDER BY ouvintes DESC, artista;

// 4) Catálogo popular ainda pouco explorado.
MATCH (m:Musica)
OPTIONAL MATCH (u:Usuario)-[:OUVIU]->(m)
RETURN m.titulo, m.popularidade, count(u) AS ouvintes
ORDER BY m.popularidade DESC, ouvintes ASC;
