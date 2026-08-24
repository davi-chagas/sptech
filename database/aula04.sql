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

INSERT INTO treinador VALUES
(DEFAULT, 'Ash Ketchum', 12, '11956482366', NOW()),
(DEFAULT, 'Misty', 12, NULL, NOW()),
(DEFAULT, 'Brocky', 15, '11926482366', NOW()),
(DEFAULT, 'Lance', 60, NULL, NOW()),
(DEFAULT, 'Serena', 14, '11923487512', NOW());

SELECT * FROM treinador;

SELECT nome, DATE_FORMAT(dataCadastro, '%D/%m/%Y %H:%m:%s') AS data_cadastro
FROM treinador;


-- preciso especificar todos os campos 
INSERT INTO treinador (nome, idade, telefone, dataCadastro) VALUES 
();