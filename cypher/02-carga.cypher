// Ajuste o caminho se necessário. No Neo4j Browser, use file:///musicas.csv.
LOAD CSV WITH HEADERS FROM 'file:///musicas.csv' AS row FIELDTERMINATOR ';'
MERGE (u:Usuario {id: row.usuario_id})
  ON CREATE SET u.nome = row.usuario_nome, u.pais = row.pais
MERGE (m:Musica {id: row.musica_id})
  ON CREATE SET m.titulo = row.titulo, m.ano = toInteger(row.ano), m.popularidade = toInteger(row.popularidade)
MERGE (a:Artista {id: row.artista_id})
  ON CREATE SET a.nome = row.artista_nome
MERGE (g:Genero {nome: row.genero})
MERGE (u)-[o:OUVIU]->(m)
SET o.reproducoes = toInteger(row.reproducoes), o.nota = toInteger(row.nota), o.ultimaVez = date(row.ultima_vez)
MERGE (m)-[:CRIADA_POR]->(a)
MERGE (m)-[:PERTENCE_A]->(g);
