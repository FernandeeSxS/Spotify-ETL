CREATE TABLE Tabela_Analise_Completa (
    ID_Musica VARCHAR(50) NOT NULL, 
    Nome_Musica VARCHAR(255) NOT NULL,
    Nome_Album VARCHAR(255) NULL,
    Duracao_Min NVARCHAR(10) NULL,
    Popularidade_Musica INT NULL,

    Nome_Artista VARCHAR(500) NOT NULL, 
    Generos_Musicais VARCHAR(500) NULL, 
    Popularidade_Artista INT NULL,
    Seguidores BIGINT NULL,

    PRIMARY KEY (ID_Musica, Nome_Artista)
);