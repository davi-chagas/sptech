CREATE DATABASE projeto_pi;

USE projeto_pi;

 /* padrão snake_case*/
 
CREATE TABLE usuario(
	id INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(45) NOT NULL,
    email VARCHAR(60) UNIQUE NOT NULL,
    senha VARCHAR(12) NOT NULL,
    dt_cadastro DATETIME DEFAULT CURRENT_TIMESTAMP,
    status TINYINT
);

CREATE TABLE empresa (
	id INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(45) NOT NULL,
    cnpj CHAR(14) NOT NULL UNIQUE,
    dt_cadastro DATETIME DEFAULT CURRENT_TIMESTAMP,
    status TINYINT
);

-- tabela auxiliar empresa_usuario?


CREATE TABLE sensor (
	id  INT PRIMARY KEY AUTO_INCREMENT,
    codigo VARCHAR(45),
    distancia DECIMAL (3, 1),
    nivel VARCHAR(40),
    CONSTRAINT chNivel CHECK(nivel IN('baixo', 'medio', 'alto', 'critico')),
	status TINYINT
);