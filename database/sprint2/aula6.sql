USE sprint2;

CREATE TABLE empresa(
	id INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(45)
);

CREATE TABLE aluno (
	id INT PRIMARY KEY AUTO_INCREMENT,
    ra CHAR(8) NOT NULL UNIQUE,
    nome VARCHAR(45),
    email VARCHAR(50) UNIQUE,
    fk_empresa INT,
    INDEX fk_alunoEmpresa_idx (fk_empresa), -- FACILITADOR NA PESQUISA EM UM BANCO DE DADOS PARA SER MAIS RÁPIDO (quando se cria mts indices, ele fica lento) 
    CONSTRAINT fk_aluno_empresa FOREIGN KEY (fk_empresa) REFERENCES empresa(id)
);

CREATE TABLE representante (
	nome VARCHAR(45),
	fk_empresa INT,
    UNIQUE INDEX fk_representante_empresa_idx (fk_empresa), -- representante não repete
    CONSTRAINT chFkEmpresa FOREIGN KEY (fk_empresa) REFERENCES empresa(id)
);

ALTER TABLE aluno ADD COLUMN data_criacao DATETIME DEFAULT CURRENT_TIMESTAMP;

-- Error Code: 1452. Cannot add or update a child row:
-- a foreign key constraint fails (`sprint2`.`representante`, CONSTRAINT `chFkEmpresa` FOREIGN KEY (`fk_empresa`) REFERENCES `empresa` (`id`))
INSERT INTO representante VALUES
('Marco', 1);

INSERT INTO empresa VALUES
(DEFAULT, 'Octea'),
(DEFAULT, 'Indra'),
(DEFAULT, 'PWC'),
(DEFAULT, 'C6 BANK');

INSERT INTO representante VALUES
('Marcus Piombo', 1),
('Brandão', 2),
('Brian', 3);

-- Error Code: 1062. Duplicate entry '1' for key 'representante.fk_representante_empresa_idx'
INSERT INTO representante VALUES
('Julia', 1);

SELECT * FROM representante;
SELECT * FROM empresa;

INSERT INTO aluno (ra, nome, email, fk_empresa) VALUES
('01262086', 'Davi', 'davi@gmail.com', 2),
('01202002', 'Julia', 'julia@sptech.school', NULL),
('01262050', 'Brian', 'brian@sptech.school', 1),
('01262105', 'José Anderson', 'jose.anderson@sptech.school', 3),
('01262091', 'Mayara', 'mayara@sptech.school', 4),
('01262136', 'Yasmin', 'yasmin@sptech.school', 4);

SELECT * FROM aluno;

SELECT nome AS NOME_ALUNO,
email EMAIL_ALUNO
FROM aluno;

SELECT 
CONCAT('Nome: ', nome, ' | E-mail: ', email, ' | Id: ', id) AS informacao
FROM aluno;

-- SELECTS COM JOINS
-- começou com aluno termina com empresa

-- Não retorna valoes null caso não existe em alguma tabela
SELECT * FROM aluno
JOIN empresa ON empresa.id = aluno.fk_empresa; 

-- como a c6 não possui representante ela não aparece
SELECT * FROM aluno
JOIN empresa ON empresa.id = aluno.fk_empresa
JOIN representante ON representante.fk_empresa = empresa.id;

SELECT aluno.nome, 
empresa.nome,
representante.nome FROM aluno
JOIN empresa ON empresa.id = aluno.fk_empresa
JOIN representante ON representante.fk_empresa = empresa.id;

-- usando alias
SELECT a.nome AS nome_aluno, 
e.nome AS nome_empresa,
r.nome AS nome_representante FROM aluno AS a
JOIN empresa AS e ON e.id = a.fk_empresa
JOIN representante AS r ON e.id = r.fk_empresa;

-- Vai trazer os alunos e as empresas na direita que estão null
SELECT * FROM aluno
LEFT JOIN empresa ON empresa.id = aluno.fk_empresa;

SELECT * FROM aluno
LEFT JOIN empresa ON empresa.id = aluno.fk_empresa
ORDER BY aluno.nome;

SELECT * FROM aluno
RIGHT JOIN empresa ON empresa.id = aluno.fk_empresa;

SELECT * FROM empresa
RIGHT JOIN representante ON empresa.id = representante.fk_empresa;

SELECT * FROM representante
RIGHT JOIN empresa ON empresa.id = representante.fk_empresa;

SELECT * FROM representante
left JOIN empresa ON empresa.id = representante.fk_empresa
right JOIN aluno ON aluno.id = aluno.fk_empresa;

-- 
SET SQL_SAFE_UPDATES = 0;

DELETE FROM empresa WHERE id = 1;
DELETE FROM representante WHERE fk_empresa = 1;
DELETE FROM aluno WHERE fk_empresa;
