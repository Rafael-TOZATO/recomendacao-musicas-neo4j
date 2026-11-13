<div align="center">
  <img src="https://capsule-render.vercel.app/api?type=waving&color=0:0b1020,100:00c2a8&height=180&section=header&text=SoundGraph%20Neo4j&fontSize=46&fontColor=ffffff&animation=fadeIn&fontAlignY=36" alt="Banner SoundGraph Neo4j" width="100%" />

  <br><br>

  <img src="https://img.shields.io/badge/Status-AI%20Engineer-success?style=for-the-badge&logo=git" alt="Status">
  <img src="https://img.shields.io/badge/Qualidade-ISO%209001-blue?style=for-the-badge&logo=checkmarx&logoColor=white" alt="ISO 9001">
  <img src="https://img.shields.io/badge/Governança-Indústria%204.0-orange?style=for-the-badge&logo=databricks&logoColor=white" alt="Indústria 4.0">
  <img src="https://img.shields.io/badge/Python-%20AI-yellow?style=for-the-badge&logo=python&logoColor=white" alt="Python & IA">
  <img src="https://img.shields.io/badge/Lean%20Six%20Sigma-Green%20Belt-purple?style=for-the-badge&logo=ercot&logoColor=white" alt="Lean Six Sigma">
  <img src="https://img.shields.io/badge/Neo4j-5.x-008CC1?style=for-the-badge&logo=neo4j&logoColor=white" alt="Neo4j 5" />
  <img src="https://img.shields.io/badge/Cypher-Query%20Language-4581C3?style=for-the-badge" alt="Cypher" />
  <img src="https://img.shields.io/badge/CI%2FCD-Active-success?style=for-the-badge&logo=githubactions&logoColor=white" alt="CI/CD">
  <img src="https://img.shields.io/badge/CodeQL-Protected-blue?style=for-the-badge&logo=github&logoColor=white" alt="CodeQL">
  <img src="https://img.shields.io/badge/Auto--Merge-Streamlined-informational?style=for-the-badge&logo=git&logoColor=white" alt="Auto-Merge">
  <img src="https://img.shields.io/badge/Governan%C3%A7a-4.0-critical?style=for-the-badge&logo=appveyor&logoColor=white" alt="Governança 4.0">
  <img src="https://img.shields.io/badge/Security-Secured%20%26%20Verified-success?style=for-the-badge&logo=security&logoColor=white" alt="Security">

  <br><br>

  <h1>🎧 SoundGraph — Recomendação de Músicas com Neo4j</h1>
  <p><b>AI Engineer | Especialista em Governança 4.0 e Qualidade | Engenheiro Químico</b></p>
  <p>Projeto prático da DIO para modelar preferências musicais e descobrir recomendações usando banco de dados em grafos.</p>
</div>

---

## 📌 Visão Geral

O SoundGraph representa usuários, músicas, artistas, gêneros e interações em um grafo. A recomendação parte de um princípio simples e explicável: **usuários com gostos semelhantes ajudam a encontrar músicas que ainda não foram ouvidas**.

> Projeto autoral inspirado na organização dos exemplos públicos de [`neo4j-graph-examples`](https://github.com/neo4j-graph-examples/), sem reutilizar dados proprietários.

---

## 🧠 Por que Grafos?

Em um modelo relacional, a pergunta “o que pessoas parecidas escutaram e eu ainda não escutei?” exige várias junções. Em Neo4j, os caminhos entre `Usuario`, `Musica`, `Artista` e `Genero` são os próprios dados, tornando a consulta mais natural, legível e fácil de evoluir.

---

## 📊 Modelo do Grafo

[Modelo do grafo SoundGraph](docs/modelo-grafo.svg)

### Entidades e Relacionamentos

- `(:Usuario {id, nome, pais})`
- `(:Musica {id, titulo, ano, popularidade})`
- `(:Artista {id, nome})`
- `(:Genero {nome})`
- `(:Usuario)-[:OUVIU {reproducoes, nota, ultimaVez}]->(:Musica)`
- `(:Musica)-[:CRIADA_POR]->(:Artista)`
- `(:Musica)-[:PERTENCE_A]->(:Genero)`

---

## 🗂️ Estrutura do Repositório

```text
data/musicas.csv                      # Dataset pequeno e reproduzível
cypher/01-schema.cypher               # Constraints e índices
cypher/02-carga.cypher                # Importação idempotente com LOAD CSV
cypher/03-consultas.cypher            # Perguntas de negócio e recomendação
cypher/04-evidencias.cypher           # Consultas para gerar evidências no Browser
cypher/05-limpeza.cypher              # Limpeza controlada do dataset
docs/modelo-grafo.svg                 # Diagrama visual do modelo
docs/Dossie_Tecnico_SoundGraph_Neo4j.pdf # Dossiê técnico completo em PDF
