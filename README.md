# Projecto de Integração de Sistemas de Informação: ETL Spotify

Este projeto implementa um *pipeline* ETL (Extração, Transformação e Carga) para obter dados de faixas, artistas e álbuns da API do Spotify e carregar o resultado numa base de dados SQL para análise subsequente no Power BI.

---

## 👨‍💻 Autores

| Nome do Autor | Número de Aluno |
| :--- | :--- |
| **Ricardo Fernandes** | 27961 |
| **Pedro Ribeiro** | 27960 |

---

## 📂 Descrição dos Ficheiros

O projeto está organizado com o seguinte propósito:

| Ficheiro / Pasta | Tipo | Descrição |
| :--- | :--- | :--- |
| **`JobPrincipal.kjb`** | **Job (PDI)** | O *Job* principal. Orquestra o *pipeline*, começando pela obtenção do Token de Acesso do Spotify, passando pela extração, transformação e carregamento dos dados. |
| **`ObterToken.ktr`** | **Transformação (PDI)** | Obtém a chave de autenticação do Spotify num Token de Acesso válido, guardando-o como a **variável** `SPOTIFY_TOKEN`. |
| **`Get Request Playlist.ktr`** | **Transformação (PDI)** | Utiliza o **`SPOTIFY_TOKEN`** para fazer a chamada à API do Spotify, lendo o *link* da playlist a partir do ficheiro **`playlist_link.txt`** , e processa a resposta JSON para extrair detalhes das faixas. |
| **`Get Request Artista.ktr`** | **Transformação (PDI)** | Utiliza o **`SPOTIFY_TOKEN`** para fazer a chamada à API do Spotify, lendo os *nomes dos artistas* da playlist a partir do ficheiro **`nomes_artistas.csv`** , e processa a resposta JSON para extrair detalhes dos artistas. |
| **`Join.ktr`** | **Transformação (PDI)** | Combina dados de faixas e artistas utilizando o *step* **Merge Join**. Puxa dados de duas tabelas de *input* da base de dados (`Tabela_Dados_Playlist` e `Tabela_Artista`) e junta-os para criar um *dataset* unificado pronto para a análise. |
| **`Get Album.ktr`** | **Transformação (PDI)** | Utiliza o **`SPOTIFY_TOKEN`** para fazer a chamada à API do Spotify, lendo o *link* do álbum a partir do ficheiro **`album_link.txt`** , e processa a resposta JSON para extrair detalhes das faixas. |
| **`Dashboard BI.pbix`** | **Dashboard (PowerBI)** | Demonstra, através do acesso à base de dados, a correlação entre os dados das tabelas **`Tabela_Dados_Playlist`** e **`Tabela_Artistas`** através de gráficos de barras e de dispersão.

---

## ⚙️ Instruções de Execução da Solução

Para executar este *pipeline* ETL com sucesso, siga os passos abaixo:

### 1. Pré-requisitos e Ferramentas Envolvidas

Certifique-se de que tem as seguintes ferramentas instaladas e configuradas:

| Ferramenta | Propósito | Notas de Configuração |
| :--- | :--- | :--- |
| **Pentaho Data Integration (PDI)** | Motor de ETL (Spoon) | Versão 10.2.0.0-222 ou superior. |
| **Base de Dados SQL** | Destino dos Dados | Configurar uma conexão chamada **`SPOTIFY_DB_LOCAL`** no PDI. |

### 2. Configuração da Base de Dados

Antes de executar, deve garantir que a tabela de destino está criada:

1.  Navegue para a pasta `src/` dentro do repositório.
2.  Execute o código presente em **`TabelaDadosPlaylist.sql`** na sua base de dados SQL.
3.  Execute o código presente em **`TabelaArtistas.sql`** na sua base de dados SQL.
4.  Execute o código presente em **`TabelaAnaliseCompleta.sql`** na sua base de dados SQL.
5.  Execute o código presente em **`TabelaMusicasAlbum.sql`** na sua base de dados SQL.
6.  No PDI, crie uma conexão de base de dados chamada **`SPOTIFY_DB_LOCAL`** que aponta para a base onde as tabelas foram criadas.

### 3. Preparação do Ficheiro de Input

O *Job* espera encontrar a *URL* da *playlist* que deseja processar:

1.  Navegue para a pasta `data/input/` dentro do repositório.
2.  Certifique-se de que os ficheiros **`playlist_link.txt`** e **`album_link.txt`** existem e contêm a *URL* do recurso do Spotify na primeira linha.

### 4. Execução do Pipeline

A execução deve ser iniciada a partir do ficheiro de *Job* principal:

1.  Abra o **Pentaho Spoon**.
2.  Abra o ficheiro **`JobPrincipal.kjb`**.
3.  Clique no botão **"Run"** (Executar) na barra de ferramentas e confirme a execução.
4.  Verifique a existência das tabelas, na base de dados, atualizadas com os dados fornecidos.