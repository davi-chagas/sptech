CREATE DATABASE liga_pokemon;
use liga_pokemon;
	
CREATE TABLE treinador (
	id INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(45) NOT NULL,
    idade TINYINT,
    telefone CHAR(11),
    dataCadastro DATETIME 
);

ALTER TABLE treinador AUTO_INCREMENT = 100;