// Execute cada bloco e use o modo Graph do Neo4j Browser para capturar evidências.

// Evidência A — caminho da recomendação para Ana.
MATCH p=(alvo:Usuario {id:'u001'})-[:OUVIU]->(comum:Musica)<-[:OUVIU]-(parecido:Usuario)-[:OUVIU]->(recomendada:Musica)
WHERE NOT (alvo)-[:OUVIU]->(recomendada)
RETURN p LIMIT 30;

// Evidência B — visão completa do catálogo.
MATCH p=(u:Usuario)-[:OUVIU]->(m:Musica)-[:CRIADA_POR|PERTENCE_A]->(entidade)
RETURN p LIMIT 60;

// Evidência C — modelo gerado pelo banco.
CALL db.schema.visualization();
