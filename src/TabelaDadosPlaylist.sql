CREATE TABLE Tabela_Dados_Playlist (
    ID_Musica VARCHAR(50) PRIMARY KEY, 

    Nome_Musica VARCHAR(255) NOT NULL,

    Nome_Artista VARCHAR(500) NULL, 

    Duracao_Min NVARCHAR(10) NULL, 

    Popularidade_Musica INT NULL,

    Nome_Album VARCHAR(255) NULL
);