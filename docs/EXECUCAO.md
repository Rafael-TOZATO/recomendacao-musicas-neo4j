# Roteiro de execução e evidências

1. Crie um banco Neo4j 5.x.
2. Execute `cypher/01-schema.cypher`.
3. Importe `data/musicas.csv` usando Data Importer ou coloque o arquivo em `import/`.
4. Execute `cypher/02-carga.cypher`.
5. Execute cada bloco de `cypher/03-consultas.cypher`.
6. Execute `cypher/04-evidencias.cypher` e use o botão de câmera do Neo4j Browser para salvar as imagens em `docs/evidencias/`.

## Validação rápida

```cypher
MATCH (n) RETURN labels(n) AS labels, count(n) AS quantidade;
MATCH ()-[r]->() RETURN type(r) AS relacionamento, count(r) AS quantidade;
```

O dataset é sintético e pequeno de propósito: permite reproduzir o desafio rapidamente e entender cada caminho do algoritmo.
