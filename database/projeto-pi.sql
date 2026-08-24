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

CREATE TABLE sensor (
	id  INT PRIMARY KEY AUTO_INCREMENT,
    codigo VARCHAR(45),
    distancia DECIMAL (3, 1),
    nivel VARCHAR(40),
    CONSTRAINT chNivel CHECK(nivel IN('baixo', 'medio', 'alto', 'critico')),
    alerta TINYINT, -- se possui alerta 
	status TINYINT
);

CREATE TABLE tolva (
	id INT PRIMARY KEY AUTO_INCREMENT,
    capacidade DECIMAL (3,1) NOT NULL,
    residuo VARCHAR(45) NOT NULL,
    CONSTRAINT chResiduo CHECK (residuo IN('ossos', 'sangue'))
);

-- LISTAR TODOS OS USUARIOS
SELECT * FROM usuario;

-- LISTAR TODOS OS USUARIOS ATIVOS
SELECT * FROM usuario
WHERE status != 0;

-- LISTAR TODOS OS USUARIOS INATIVOS
SELECT * FROM usuario
WHERE status = 0;

-- Monitoramento de Tolvas

-- Contar a quantidade de tolvas não nulls.
SELECT COUNT(id) FROM tolva;

SELECT COUNT(alerta) FROM sensor;

SELECT id, codigo from sensor
WHERE alerta = 1;

DROP TABLE sensor;

