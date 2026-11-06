<div align="center">
  <img src="https://capsule-render.vercel.app/api?type=waving&color=0:0b1020,100:00c2a8&height=180&section=header&text=SoundGraph%20Neo4j&fontSize=46&fontColor=ffffff&animation=fadeIn&fontAlignY=36" alt="Banner SoundGraph Neo4j" width="100%" />
  <h1>🎧 SoundGraph — Recomendação de músicas com Neo4j</h1>
  <p>Projeto prático da DIO para modelar preferências musicais e descobrir recomendações usando banco de dados em grafos.</p>
  <p>
    <img src="https://img.shields.io/badge/Neo4j-5.x-008CC1?logo=neo4j&logoColor=white" alt="Neo4j 5" />
    <img src="https://img.shields.io/badge/Cypher-Query%20Language-4581C3" alt="Cypher" />
    <img src="https://img.shields.io/badge/DIO-Projeto%20de%20Dados-7B61FF" alt="DIO" />
    <img src="https://img.shields.io/badge/Documentation-PDF%20Report-FF6C37?logo=adobeacrobatreader&logoColor=white" alt="Documentação PDF" />
    <img src="https://img.shields.io/badge/Security-Best%20Practices-2EA44F?logo=github" alt="Boas práticas de segurança" />
    <img src="https://img.shields.io/badge/License-MIT-yellow.svg" alt="Licença MIT" />
  </p>
</div>

## Visão geral

O SoundGraph representa usuários, músicas, artistas, gêneros e interações em um grafo. A recomendação parte de um princípio simples e explicável: **usuários com gostos semelhantes ajudam a encontrar músicas que ainda não foram ouvidas**.

> Projeto autoral inspirado na organização dos exemplos públicos de [`neo4j-graph-examples`](https://github.com/neo4j-graph-examples/), sem reutilizar dados proprietários.

## 📄 Documentação Técnica Completa

Para uma análise aprofundada da arquitetura, formulação do algoritmo de recomendação, segurança, governança e conformidade com LGPD, consulte o dossiê técnico do projeto:

- 📥 [**Baixar Dossiê Técnico em PDF**](docs/Dossie_Tecnico_SoundGraph_Neo4j.pdf)

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
data/musicas.csv                       # Dataset pequeno e reproduzível
cypher/01-schema.cypher                 # Constraints e índices
cypher/02-carga.cypher                  # Importação idempotente com LOAD CSV
cypher/03-consultas.cypher              # Perguntas de negócio e recomendação
cypher/04-evidencias.cypher             # Consultas para gerar evidências no Browser
cypher/05-limpeza.cypher                # Limpeza controlada do dataset
docs/modelo-grafo.svg                  # Diagrama visual do modelo
docs/Dossie_Tecnico_SoundGraph_Neo4j.pdf # Dossiê técnico completo em PDF
