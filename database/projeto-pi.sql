CREATE DATABASE projeto_pi;

USE projeto_pi;

 /* padrões: 
	snake_case 
	tinyint - para boolean 
    cep e cnpj não armazenarão . e -
 */
 
CREATE TABLE usuario(
	id INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(45) NOT NULL,
    email VARCHAR(60) UNIQUE NOT NULL,
    senha VARCHAR(12) NOT NULL,
    dt_cadastro DATETIME DEFAULT CURRENT_TIMESTAMP,
    status TINYINT DEFAULT 1, -- por default ativo
    role VARCHAR(10),
    CONSTRAINT chRole CHECK (role IN('ADMIN', 'USUARIO', 'GESTOR'))
);

CREATE TABLE empresa (
	id INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(45) NOT NULL,
    cnpj CHAR(14) NOT NULL UNIQUE,
    logradouro VARCHAR(40) NOT NULL,
    cidade VARCHAR(45) NOT NULL,
    estado CHAR(2) NOT NULL,
    cep CHAR(8),
	dt_cadastro DATETIME DEFAULT CURRENT_TIMESTAMP,
    status TINYINT DEFAULT 1 -- por default ativo
);

CREATE TABLE unidade (
	id INT PRIMARY KEY AUTO_INCREMENT,
    empresa_id INT NOT NULL, -- referencia logica para qual empresa pertencer
    nome VARCHAR(60) NOT NULL,
    logradouro VARCHAR(100) NOT NULL,
    cidade VARCHAR(45) NOT NULL,
    estados CHAR(2) NOT NULL,
    cep CHAR(8)
);

CREATE TABLE sensor (
	id INT PRIMARY KEY AUTO_INCREMENT,
    tolva_id INT NULL,
	status TINYINT DEFAULT 1 -- por default ativo
);

CREATE TABLE leitura_sensor (
	id INT PRIMARY KEY AUTO_INCREMENT,
    sensor_id INT NOT NULL,
    distancia DECIMAL (5,2) NOT NULL, -- em centimetros
    nivel_percentual DECIMAL(5,2) NOT NULL,
    estado VARCHAR (10) NOT NULL
    CONSTRAINT chEstado CHECK (estado IN('baixo', 'médio', 'alto', 'critico')),
    dt_leitura DATETIME DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE tolva (
	id INT PRIMARY KEY AUTO_INCREMENT,
    unidade_id INT NOT NULL,
    altura DECIMAL (5,2) NOT NULL,
    capacidade DECIMAL (10,2) NOT NULL,
    residuo VARCHAR(45) NOT NULL
);

-- INSERÇÃO DE DADOS
INSERT INTO usuario (nome, email, senha, dt_cadastro, role) VALUES 
('Brian', 'brian@gmail.com', 'senha123', NOW(), 'ADMIN'),
('Fernando Brandão', 'fernando@gmail.com', 'senha123', NOW(), 'USUARIO'),
('Julia Araripe', 'julia@gmail.com', 'senha123', NOW(), 'GESTOR');

INSERT INTO empresa (nome, cnpj, logradouro, cidade, estado, cep, dt_cadastro) VALUES 
('Grupo Braido', '1234567891234', 'Rua lala', 'São Caetano do Sul', 'SP', '00000000', NOW());

-- LISTAR TODOS OS USUARIOS
SELECT * FROM usuario;

-- LISTAR USUÁRIOS ATIVOS E INATIVOS
SELECT id, nome,
CASE
	WHEN status = 1 THEN 'Ativo'
	WHEN status = 0 THEN 'Inativo'
    END as 'Status do usuário'
FROM usuario;

-- LISTAR TODAS AS EMPRESAS
SELECT * from empresa;

-- Listar empresas ativas e inativas
SELECT id, 
nome,
CASE
	WHEN status = 1 THEN 'Ativo'
    WHEN status = 0 THEN 'Inativo'
END as 'Status empresa'
FROM empresa;

-- Exibir tempo da empresa cadastrada
SELECT id, nome,
TIMESTAMPDIFF(DAY, dt_cadastro, NOW()) as tempo_cadastrado
from empresa;


-- MONITORAMENTO DAS TOLVAS
-- Contar a quantidade de tolvas não nulls.
SELECT COUNT(id) FROM tolva;

-- Capacidade tolva
SELECT id, capacidade FROM tolva;

-- Exibir o id e codigo do sensor do qual alerta é TRUE
SELECT id, codigo from sensor
WHERE alerta = 1;