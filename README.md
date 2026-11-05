<div align="center">
  <img src="https://capsule-render.vercel.app/api?type=waving&color=0:0b1020,100:00c2a8&height=180&section=header&text=SoundGraph%20Neo4j&fontSize=46&fontColor=ffffff&animation=fadeIn&fontAlignY=36" alt="Banner SoundGraph Neo4j" width="100%" />
  <h1>🎧 SoundGraph — Recomendação de músicas com Neo4j</h1>
  <p>Projeto prático da DIO para modelar preferências musicais e descobrir recomendações usando banco de dados em grafos.</p>
  <p>
    <img src="https://img.shields.io/badge/Neo4j-5.x-008CC1?logo=neo4j&logoColor=white" alt="Neo4j 5" />
    <img src="https://img.shields.io/badge/Cypher-Query%20Language-4581C3" alt="Cypher" />
    <img src="https://img.shields.io/badge/DIO-Projeto%20de%20Dados-7B61FF" alt="DIO" />
    <img src="https://img.shields.io/badge/Security-Best%20Practices-2EA44F?logo=github" alt="Boas práticas de segurança" />
    <img src="https://img.shields.io/badge/License-MIT-yellow.svg" alt="Licença MIT" />
  </p>
</div>

## Visão geral

O SoundGraph representa usuários, músicas, artistas, gêneros e interações em um grafo. A recomendação parte de um princípio simples e explicável: **usuários com gostos semelhantes ajudam a encontrar músicas que ainda não foram ouvidas**.

> Projeto autoral inspirado na organização dos exemplos públicos de [`neo4j-graph-examples`](https://github.com/neo4j-graph-examples/), sem reutilizar dados proprietários.

## Por que grafos?

Em um modelo relacional, a pergunta “o que pessoas parecidas escutaram e eu ainda não escutei?” exige várias junções. Em Neo4j, os caminhos entre `Usuario`, `Musica`, `Artista` e `Genero` são os próprios dados, tornando a consulta mais natural, legível e fácil de evoluir.

## Modelo do grafo

![Modelo do grafo SoundGraph](docs/modelo-grafo.svg)

### Entidades e relacionamentos

- `(:Usuario {id, nome, pais})`
- `(:Musica {id, titulo, ano, popularidade})`
- `(:Artista {id, nome})`
- `(:Genero {nome})`
- `(:Usuario)-[:OUVIU {reproducoes, nota, ultimaVez}]->(:Musica)`
- `(:Musica)-[:CRIADA_POR]->(:Artista)`
- `(:Musica)-[:PERTENCE_A]->(:Genero)`

## Estrutura

```text
data/musicas.csv       # Dataset pequeno e reproduzível
cypher/01-schema.cypher # Constraints e índices
cypher/02-carga.cypher  # Importação idempotente com LOAD CSV
cypher/03-consultas.cypher # Perguntas de negócio e recomendação
cypher/04-evidencias.cypher # Consultas para gerar evidências no Browser
cypher/05-limpeza.cypher # Limpeza controlada do dataset
 docs/modelo-grafo.svg  # Diagrama visual do modelo
```

## Como executar

1. Crie um banco Neo4j 5.x local ou no [Neo4j Aura](https://neo4j.com/cloud/aura/).
2. Abra o Neo4j Browser ou o Neo4j Desktop.
3. Execute `cypher/01-schema.cypher`.
4. No Neo4j Browser, envie o arquivo `data/musicas.csv` para a pasta de importação ou adapte o caminho do `LOAD CSV`.
5. Execute `cypher/02-carga.cypher`.
6. Execute `cypher/03-consultas.cypher` e visualize os resultados em tabela ou grafo.

> No Aura, prefira importar o CSV pelo Data Importer ou hospedar o arquivo em uma URL HTTPS. Nunca versionamos credenciais ou URLs privadas neste repositório.

## Perguntas de negócio respondidas

1. Quais músicas um usuário ainda não ouviu, mas foram ouvidas por pessoas com gostos semelhantes?
2. Quais gêneros são mais relevantes para cada perfil?
3. Quais artistas conectam diferentes comunidades de ouvintes?
4. Quais recomendações têm maior evidência de afinidade?
5. Quais músicas populares ainda possuem baixa cobertura de audiência?

## Algoritmo de recomendação

A consulta calcula uma pontuação explicável combinando:

- quantidade de usuários semelhantes que ouviram a música;
- média das notas dadas por esses usuários;
- popularidade da música;
- penalização de itens que o usuário já ouviu.

A pontuação não é uma “caixa-preta”: cada recomendação retorna os usuários que serviram como evidência e o motivo da indicação.

## Evidências visuais

Após executar `cypher/04-evidencias.cypher`, use o modo **Graph** do Neo4j Browser para gerar os prints exigidos pelo desafio:

- `docs/evidencias/recomendacoes.png` — recomendações conectadas aos ouvintes semelhantes;
- `docs/evidencias/comunidades.png` — relações entre usuários, gêneros e artistas;
- `docs/evidencias/schema.png` — resultado de `CALL db.schema.visualization()`.

As imagens são artefatos gerados no ambiente do estudante, porque o resultado depende do banco carregado. O roteiro para reproduzi-las está documentado no script de evidências.

## Troubleshooting

- **`Couldn't load the external resource`**: confirme se o CSV está no diretório `import` ou use o Data Importer.
- **`already exists with type`**: execute novamente o schema; os comandos usam `IF NOT EXISTS`.
- **Nenhum resultado**: confira se a carga terminou e rode `MATCH (n) RETURN labels(n), count(n)`.
- **CSV com acentos quebrados**: salve o arquivo em UTF-8 e mantenha `FIELDTERMINATOR ';'`.
- **Aura bloqueando arquivo local**: use Data Importer ou uma URL HTTPS pública temporária, sem dados pessoais.

## Segurança e qualidade

- Nenhum segredo é armazenado no repositório.
- Constraints evitam duplicidade de identificadores.
- Consultas de escrita são idempotentes com `MERGE`.
- CSV contém dados sintéticos, não dados pessoais reais.
- Recomenda-se habilitar autenticação, TLS e menor privilégio no ambiente Neo4j.

## Licença

Distribuído sob a licença MIT. Consulte `LICENSE`.

## Autor

**Rafael Ornelas Tozato** · [GitHub](https://github.com/rafael-tozato) · [LinkedIn](https://linkedin.com/in/rafael-ornelas-tozato)
