// SoundGraph — schema seguro e idempotente
CREATE CONSTRAINT usuario_id_unico IF NOT EXISTS
FOR (u:Usuario) REQUIRE u.id IS UNIQUE;
CREATE CONSTRAINT musica_id_unico IF NOT EXISTS
FOR (m:Musica) REQUIRE m.id IS UNIQUE;
CREATE CONSTRAINT artista_id_unico IF NOT EXISTS
FOR (a:Artista) REQUIRE a.id IS UNIQUE;
CREATE CONSTRAINT genero_nome_unico IF NOT EXISTS
FOR (g:Genero) REQUIRE g.nome IS UNIQUE;
CREATE INDEX musica_popularidade IF NOT EXISTS
FOR (m:Musica) ON (m.popularidade);
