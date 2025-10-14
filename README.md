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

A estrutura do projeto está organizada em várias pastas, cada uma com uma função específica dentro do processo ETL desenvolvido no **Pentaho Data Integration (Kettle)**.

---

### 1. Pasta `dataint/` (Lógica Principal - Pentaho Kettle)

Esta pasta contém os **Jobs** e **Transformações** do Pentaho, que implementam a lógica principal de Extração, Transformação e Carga (ETL).

| Ficheiro | Tipo | Função |
| :--- | :--- | :--- |
| **`JobPrincipal.kjb`** | **Job (PDI)** | É o *Job* principal do projeto. Orquestra todo o processo ETL, desde a autenticação com a API do Spotify até ao carregamento final dos dados na base de dados. |
| **`ObterToken.ktr`** | **Transformação (PDI)** | Obtém o Token de Acesso do Spotify e armazena-o na variável `SPOTIFY_TOKEN`. |
| **`Get Request Playlist.ktr`** | **Transformação (PDI)** | Lê o ficheiro `playlist_link.txt` e, utilizando o `SPOTIFY_TOKEN`, faz a requisição à API do Spotify para extrair dados das faixas da playlist. |
| **`Get Request Artista.ktr`** | **Transformação (PDI)** | Faz a chamada à API do Spotify para obter dados detalhados dos artistas presentes na playlist. |
| **`Get Album.ktr`** | **Transformação (PDI)** | Extrai detalhes de álbuns a partir de links definidos no ficheiro `album_link.txt`. |
| **`Join.ktr`** | **Transformação (PDI)** | Combina dados de playlists e artistas através do *step* **Merge Join**, criando um dataset unificado. |

---

### 2. Pasta `src/` (Código Auxiliar e Estrutura SQL)

Esta pasta contém os **Scripts SQL** utilizados para criar as tabelas da base de dados e o **Código Python Auxiliar** usado em operações complementares, como autenticação e codificação.

| Ficheiro | Tipo | Função |
| :--- | :--- | :--- |
| **`TabelaDadosPlaylist.sql`** | **Script SQL** | Define a estrutura da tabela principal de dados das playlists. |
| **`TabelaArtistas.sql`** | **Script SQL** | Cria a tabela com informações detalhadas dos artistas. |
| **`TabelaAnaliseCompleta.sql`** | **Script SQL** | Junta dados de músicas e artistas da playlist para análises no Power BI. |
| **`TabelaMusicasAlbum.sql`** | **Script SQL** | Define a estrutura para armazenar as músicas associadas a cada álbum. |
| **`spotify_auth_encoder.py`** | **Script Python** | Script auxiliar que codifica as credenciais (Client ID e Secret) em Base64 e escreve automaticamente o resultado no ficheiro `credentials.txt`. Necessário para o processo de autenticação com a API do Spotify. |

---

### 3. Pasta `data/` (Gestão de Dados)

Esta pasta centraliza todos os **ficheiros de dados de entrada e saída** utilizados e gerados pelo pipeline ETL.

#### 📥 `data/input/` — Ficheiros de Configuração e Links

Contém os ficheiros de texto necessários para parametrizar a extração de dados.

| Ficheiro | Função |
| :--- | :--- |
| **`playlist_link.txt`** | Contém o link completo da *playlist* a processar pela pipeline. |
| **`album_link.txt`** | Contém o link do *álbum* a ser processado. |
| **`credentials.txt`** | Ficheiro que armazena as credenciais codificadas em Base64 (`Client ID` e `Client Secret`). |

#### 📤 `data/output/` — Resultados Finais e Intermédios

Contém os ficheiros de saída gerados após a execução do processo ETL. Os dados são exportados tanto em formato de texto como XML.

| Ficheiro | Função |
| :--- | :--- |
| **`nomes_artistas.csv`** | Saída final do conjunto de artistas presentes na playlist. |
| **`dados_playlist.xml`** | Saída final das playlists em formato XML. |
| **`dados_artistas.xml`** | Saída dos artistas em formato XML. |
| **`dados_album.xml`** | Saída dos dados do álbum em formato XML. |

---

### 4. Pasta `doc/` (Documentação)

Contém a documentação e relatórios do projeto.

| Ficheiro | Função |
| :--- | :--- |
| **`README.md`** | Documento explicativo com as instruções e descrição geral do projeto. |
| **`27960_doc.pdf`** | Documento final com a descrição técnica e análise do trabalho realizado. |

---

### 5. Outros Ficheiros

| Ficheiro | Função |
| :--- | :--- |
| **`.gitignore`** | Define os ficheiros e pastas a serem ignorados pelo Git (por exemplo, credenciais, logs e ficheiros temporários). |


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

### 4. Como Obter Acesso

Para garantir o sucesso da extração de dados da API do Spotify, siga os seguintes passos de configuração e autenticação:

### **Passo 1: Obter as Credenciais da API**

1. Crie uma conta em [Spotify for Developers](https://developer.spotify.com/dashboard/).  
2. Crie uma nova aplicação para obter o seu **Client ID** e **Client Secret**.

### **Passo 2: Configurar o Ficheiro `credentials.txt`**

A *transformação* lê a chave de autenticação a partir do ficheiro `data/input/credentials.txt`.  
Existem duas formas de inserir as credenciais necessárias:

#### 🔹 Opção A: Executar o Script de Auxílio (Recomendado)

Esta é a forma mais simples, pois o script faz a codificação Base64 e escreve no ficheiro automaticamente.

1. Abra a consola (CMD/Terminal) na pasta  
   `[O seu workspace]\tp01-27960\src\`.  
2. Execute o ficheiro `spotify_auth_encoder.py`, passando o seu **Client ID** e **Client Secret** como argumentos:

   ```bash
   python spotify_auth_encoder.py <Client ID> <Client Secret>

#### 🔹 Opção B: Inserção Manual

Se preferir inserir manualmente, edite o ficheiro `data/input/credentials.txt` e substitua os *placeholders*.

1. Codifique a string `Client ID:Client Secret` em Base64 externamente (pode usar um site online).  
2. Edite o ficheiro e insira a chave de autorização, seguindo o formato abaixo:

   ```txt
   [SUA_CHAVE_BASE64]


### 5. Execução do Pipeline

A execução deve ser iniciada a partir do ficheiro de *Job* principal:

1.  Abra o **Pentaho Spoon**.
2.  Abra o ficheiro **`JobPrincipal.kjb`**.
3.  Clique no botão **"Run"** (Executar) na barra de ferramentas e confirme a execução.
4.  Verifique a existência das tabelas, na base de dados, atualizadas com os dados fornecidos.