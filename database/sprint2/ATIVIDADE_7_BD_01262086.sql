USE sprint2;

CREATE TABLE autor (
	id INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(45) NOT NULL,
    nacionalidade VARCHAR(45),	
    dt_nascimento DATE
);

CREATE TABLE livro (
	id INT PRIMARY KEY AUTO_INCREMENT,
    titulo VARCHAR(45) NOT NULL,
    qtd_paginas INT NOT NULL
    CONSTRAINT ch_qtd_paginas CHECK (qtd_paginas > 0),
    ano_publicacao INT NOT NULL,
    preco DECIMAL(5,2) NOT NULL,
    situacao TINYINT DEFAULT 1, 
	fk_autor INT,
    CONSTRAINT fk_autor_livro FOREIGN KEY (fk_autor) REFERENCES autor(id)
);

INSERT INTO autor (nome, nacionalidade, dt_nascimento) VALUES
('J.K. Rowling', 'Britânica', '1965-07-31'),
('George Orwell', 'Britânica', '1903-06-25'),
('Machado de Assis', 'Brasileira', '1839-06-21'),
('J.R.R. Tolkien', 'Britânica', '1892-01-03'),
('Agatha Christie', 'Britânica', '1890-09-15');

INSERT INTO livro (titulo, qtd_paginas, ano_publicacao, preco, situacao, fk_autor) VALUES
('Harry Potter e a Pedra Filosofal', 309, 1997, 39.90, 1, 1),
('Harry Potter e a Câmara Secreta', 251, 1998, 42.90, 1, 1),
('1984', 328, 1949, 35.90, 1, 2),
('A Revolução dos Bichos', 152, 1945, 29.90, 1, 2),
('Dom Casmurro', 256, 1899, 32.90, 1, 3),
('O Senhor dos Anéis', 1216, 1954, 89.90, 1, 4),
('O Hobbit', 310, 1937, 45.90, 1, 4),
('Assassinato no Expresso do Oriente', 288, 1934, 38.90, 1, 5);

-- a) Exibir todos os dados dos livros.
SELECT * FROM livro;

-- b) Exibir título do livro, ano de publicação e nome de seu autor.
SELECT
l.titulo,
l.ano_publicacao,
a.nome
FROM livro AS l
JOIN autor AS a
ON l.fk_autor = a.id;

-- c) Exibir os livros publicados após determinado ano, apresentando título, ano de publicação e autor.
SELECT
l.titulo,
l.ano_publicacao,
a.nome
FROM livro AS l
JOIN autor AS a
ON l.fk_autor = a.id
WHERE l.ano_publicacao > 1995;

-- d) Exibir os livros de um determinado autor.
SELECT 
*
FROM livro AS l
JOIN autor AS a
ON l.fk_autor = a.id
WHERE a.id = 1;

-- e) Exibir os livros cujo preço esteja entre dois valores determinados.
SELECT
*
FROM livro
WHERE preco BETWEEN 35.00 AND 45.00;

SELECT
l.titulo,
a.nome,
l.qtd_paginas,
CASE
	WHEN qtd_paginas <= 200 THEN 'Curto'
    WHEN qtd_paginas <= 400 THEN 'Médio'
    ELSE 'Longo'
END AS 'classificação'
FROM livro AS l
JOIN autor AS a
ON l.fk_autor = a.id;

-- g) Atualizar o preço de um determinado livro.
UPDATE livro
SET preco = 400.00 
WHERE id = 1;

-- h) Excluir um determinado livro.
DELETE FROM livro
WHERE id = 2;

-- i) Exibir título, autor e ano de publicação, ordenando do livro mais recente para o mais antigo.

SELECT
l.titulo,
a.nome,
l.ano_publicacao 
FROM livro AS l
JOIN autor AS a
ON fk_autor= a.id
ORDER BY l.ano_publicacao DESC;

-- Exercicio 2
CREATE TABLE departamento (
	id INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(45) NOT NULL,
    andar VARCHAR(45)
);

CREATE TABLE funcionario (
	id INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(45) NOT NULL,
    email VARCHAR(50) NOT NULL UNIQUE,
    salario DECIMAL(6,2),
    data_admissao DATE,
    fk_departamento INT NOT NULL,
    fk_supervisor INT,
    CONSTRAINT fk_departamento_funcionario FOREIGN KEY (fk_departamento) REFERENCES departamento(id),
    CONSTRAINT fk_supervisor_funcionario FOREIGN KEY (fk_supervisor) REFERENCES funcionario(id)
);

INSERT INTO departamento (nome, andar) VALUES
('Tecnologia', '1º andar'),
('Recursos Humanos', '2º andar'),
('Financeiro', '3º andar'),
('Marketing', '4º andar');

INSERT INTO funcionario (nome, email, salario, data_admissao, fk_departamento, fk_supervisor) VALUES
('Carlos Mendes', 'carlos@empresa.com', 5000.00, '2020-01-15', 1, NULL),
('Mariana Souza', 'mariana@empresa.com', 4500.00, '2021-03-10', 1, 1),
('Joao Oliveira', 'joao@empresa.com', 3800.00, '2022-06-20', 1, 1),
('Beatriz Lima', 'beatriz@empresa.com', 3500.00, '2023-02-05', 2, NULL),
('Rafael Santos', 'rafael@empresa.com', 4200.00, '2021-08-12', 2, 4),
('Lucas Costa', 'lucas@empresa.com', 6000.00, '2019-11-25', 3, NULL),
('Ana Ferreira', 'ana@empresa.com', 3900.00, '2022-04-18', 3, 6),
('Pedro Alves', 'pedro@empresa.com', 3700.00, '2023-09-01', 4, NULL);

-- a) Exibir o nome de cada funcionário e o nome do departamento ao qual pertence.
SELECT 
f.nome,
d.nome 
FROM funcionario AS f
JOIN departamento AS d
ON f.fk_departamento = d.id;

-- b) Exibir nome, salário e departamento dos funcionários admitidos após uma determinada data.
SELECT 
f.nome,
f.salario,
d.nome
FROM funcionario AS f
JOIN departamento AS d
ON f.fk_departamento = d.id
WHERE f.data_admissao > '2023-01-01';

-- c) Exibir os funcionários pertencentes a dois departamentos específicos utilizando IN.
SELECT 
*
FROM funcionario AS f
JOIN departamento AS d
ON f.fk_departamento = d.id
WHERE d.id IN (1, 2);

-- d) Exibir nome do funcionário, salário e departamento, ordenando pelo salário em ordem decrescente.
SELECT
f.nome,
f.salario,
d.nome
FROM funcionario AS f
JOIN departamento AS d
ON f.fk_departamento = d.id
ORDER BY f.salario DESC;

-- e) Exibir o nome de cada funcionário que possui supervisor e o nome de seu respectivo supervisor.
SELECT
f.nome,
s.nome
FROM funcionario AS f
JOIN funcionario AS s
ON f.fk_supervisor = s.id;

-- f) Exibir nome e e-mail dos funcionários cujo supervisor seja um funcionário específico.
SELECT
f.nome,
f.email
FROM funcionario AS f
JOIN funcionario AS s
ON f.fk_supervisor = s.id
WHERE s.id = 6;

-- g) Exibir os funcionários cujo nome do supervisor comece com uma determinada letra.
SELECT 
*
FROM funcionario AS f
JOIN funcionario AS s
ON f.fk_supervisor = s.id
WHERE s.nome LIKE 'L%';

-- h) Exibir nome do funcionário, nome do supervisor e uma classificação salarial utilizando CASE WHEN, considerando três faixas salariais definidas por você.
SELECT 
f.nome,
s.nome,
CASE
	WHEN f.salario <= 3500 THEN 'Baixo'
    WHEN f.salario < 5000 THEN 'Médio'
    ELSE 'Alto'
END AS classificacao_salarial
FROM funcionario AS f
JOIN funcionario AS s
ON f.fk_supervisor = s.id;

-- i) Atualizar o supervisor de um determinado funcionário.
UPDATE funcionario
SET fk_supervisor = 2
WHERE id = 1;

-- j) Remover o supervisor de um determinado funcionário.
UPDATE funcionario
SET fk_supervisor = NULL
WHERE id = 1;

select * from funcionario;

-- k) Excluir um funcionário que não seja supervisor de nenhum outro funcionário.
DELETE FROM funcionario
WHERE id = 8;

-- EXERCICIO 3
CREATE TABLE curso (
	id INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(45) NOT NULL,
    sigla CHAR(2),
    duracao_semestre INT NOT NULL
);

CREATE TABLE turma (
	id INT PRIMARY KEY AUTO_INCREMENT,
    codigo CHAR(8) NOT NULL UNIQUE,
    semestre_ingresso INT,
    fk_curso INT,
    CONSTRAINT fk_curso_turma FOREIGN KEY (fk_curso) REFERENCES curso(id)
);

CREATE TABLE aluno (
	id INT PRIMARY KEY AUTO_INCREMENT,
    ra CHAR(8) NOT NULL UNIQUE,
    nome VARCHAR(45) NOT NULL,
    email VARCHAR(60) NOT NULL UNIQUE,
    data_nascimento DATE,
    fk_turma INT,
    CONSTRAINT fk_turma_aluno FOREIGN KEY (fk_turma) REFERENCES turma(id)
);

INSERT INTO curso (nome, sigla, duracao_semestre) VALUES
('Análise e Desenvolvimento de Sistemas', 'AD', 5),
('Engenharia de Software', 'ES', 8),
('Ciência da Computação', 'CC', 8);

INSERT INTO turma (codigo, semestre_ingresso, fk_curso) VALUES
('ADS2026A', 1, 1),
('ADS2026B', 2, 1),
('CC2026A', 3, 3),
('CC2025A', 6, 3);

INSERT INTO aluno (ra, nome, email, data_nascimento, fk_turma) VALUES
('10000001', 'Carlos Silva', 'carlos@email.com', '2005-03-15', 1),
('10000002', 'Mariana Souza', 'mariana@email.com', '2004-07-22', 1),
('10000003', 'Joao Oliveira', 'joao@email.com', '2005-01-10', 1),
('10000004', 'Beatriz Lima', 'beatriz@email.com', '2004-11-05', 2),
('10000005', 'Lucas Santos', 'lucas@email.com', '2003-09-18', 2),
('10000006', 'Ana Costa', 'ana@email.com', '2005-05-27', 3),
('10000007', 'Rafael Alves', 'rafael@email.com', '2004-02-14', 3),
('10000008', 'Pedro Mendes', 'pedro@email.com', '2003-12-01', 4);

-- a) Exibir o código da turma e o nome do curso ao qual ela pertence.
SELECT 
t.codigo,
c.nome
FROM turma AS t
JOIN curso AS c
ON t.fk_curso = c.id;

-- b) Exibir nome do aluno, RA, código da turma e nome do curso, relacionando as três tabelas.
SELECT
a.nome,
a.ra,
t.codigo,
c.nome
FROM aluno AS a
JOIN turma AS t
ON a.fk_turma = t.id
JOIN curso AS c
ON t.fk_curso = c.id;

-- c) Exibir os alunos pertencentes a um determinado curso, apresentando também a turma.
SELECT 
*
FROM aluno AS a
JOIN turma AS t
ON a.fk_turma = t.id
JOIN curso AS c
ON t.fk_curso = c.id
WHERE c.id = 1;

-- d) Exibir nome do aluno, turma e uma classificação baseada no semestre de ingresso, 
-- seguindo critérios definidos por você.

SELECT
a.nome,
t.codigo,
CASE
	WHEN t.semestre_ingresso = 1 THEN 'Novato'
    WHEN t.semestre_ingresso = 2 THEN 'Estagiário'
    WHEN t.semestre_ingresso = 3 OR 4 THEN 'Aluno efetivado'
    ELSE 'Senior'
END AS classificacao
FROM aluno AS a
JOIN turma AS t
ON a.fk_turma = t.id;

-- e) Exibir todos os cursos e suas respectivas turmas, incluindo cursos sem turma.
SELECT 
*
FROM curso AS c
LEFT JOIN turma AS f
ON f.fk_curso = c.id;

-- f) Adicionar um campo para armazenar o telefone do aluno.
ALTER TABLE aluno ADD COLUMN telefone VARCHAR(11);

-- g) Atualizar o telefone de 2 alunos.
UPDATE aluno
SET telefone = '11942726724'
WHERE id = 1;

UPDATE aluno
SET telefone = '11972226746'
WHERE id = 2;

SELECT * FROM aluno;

-- EXERCICIO 4

CREATE TABLE setor (
	id INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(45) NOT NULL,
    sigla CHAR(2),
    fk_setor_superior INT,
    CONSTRAINT fk_setor_superior FOREIGN KEY (fk_setor_superior) REFERENCES setor(id) 
);

CREATE TABLE funcionario (
	id INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(45) NOT NULL,
    email VARCHAR(50) NOT NULL UNIQUE,
    salario DECIMAL(6,2),
    data_admissao DATE,
    fk_setor INT NOT NULL,
    CONSTRAINT fk_setor_funcionario FOREIGN KEY (fk_setor) REFERENCES setor(id)
);

CREATE TABLE projeto (
	id INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(45) NOT NULL,
    descricao VARCHAR(80) NOT NULL,
    data_inicio DATE NOT NULL,
    data_fim DATE,
    fk_setor INT,
    CONSTRAINT fk_setor_projeto FOREIGN KEY (fk_setor) REFERENCES setor(id)
);

INSERT INTO setor (nome, sigla, fk_setor_superior) VALUES
('Diretoria', 'DI', NULL),
('Tecnologia', 'TI', 1),
('Desenvolvimento', 'DV', 2),
('Infraestrutura', 'IF', 2),
('Recursos Humanos', 'RH', NULL);

INSERT INTO funcionario (nome, email, salario, data_admissao, fk_setor) VALUES
('Carlos Mendes', 'carlos@empresa.com', 7500.00, '2019-01-10', 1),
('Mariana Souza', 'mariana@empresa.com', 6500.00, '2020-03-15', 2),
('Joao Oliveira', 'joao@empresa.com', 5000.00, '2021-06-20', 3),
('Beatriz Lima', 'beatriz@empresa.com', 4800.00, '2022-02-10', 3),
('Lucas Santos', 'lucas@empresa.com', 4500.00, '2022-08-05', 4),
('Ana Costa', 'ana@empresa.com', 4200.00, '2023-01-18', 4);

INSERT INTO projeto (nome, descricao, data_inicio, data_fim, fk_setor) VALUES
('Sistema ERP', 'Desenvolvimento do sistema empresarial', '2026-01-10', NULL, 3),
('Aplicativo Mobile', 'Desenvolvimento do aplicativo corporativo', '2026-02-15', NULL, 3),
('Portal Web', 'Desenvolvimento do portal institucional', '2026-03-01', NULL, 3),
('Rede Corporativa', 'Implantacao da infraestrutura de rede', '2026-01-20', NULL, 4),
('Seguranca TI', 'Implementacao de seguranca digital', '2026-02-10', NULL, 2),
('Novo Escritório', 'Projeto de expansão empresarial', '2026-04-01', NULL, 1);

-- a) Exibir nome do funcionário e nome do setor ao qual ele pertence.
SELECT 
f.nome,
s.nome
FROM funcionario AS f
JOIN setor AS s
ON f.fk_setor = s.id;

-- b) Exibir nome do projeto e nome do setor responsável.
SELECT 
p.nome,
s.nome
FROM projeto AS p
JOIN setor AS s
ON p.fk_setor = s.id;

-- c) Exibir os funcionários admitidos após determinada data, apresentando também seu setor.
SELECT
*
FROM funcionario AS f
JOIN setor AS s
ON f.fk_setor = s.id
WHERE data_admissao > '2023-01-01';

-- d) Exibir o nome de cada setor subordinado e o nome de seu respectivo setor superior.
--  Não devem aparecer setores que não possuam um setor superior.

SELECT 
s.nome,
ss. nome 
FROM setor AS s
JOIN setor AS ss
ON s.fk_setor_superior = ss.id;

-- e) Exibir todos os setores e, quando existir, o nome do setor superior ao qual estão subordinados.
-- Setores sem um setor superior também deverão aparecer.
SELECT
s.*,
ss.nome
FROM setor AS s
LEFT JOIN setor AS ss
ON s.fk_setor_superior = ss.id;

-- f) Exibir todos os setores subordinados a um determinado setor superior.
SELECT 
*
FROM setor AS s
JOIN setor AS ss
ON s.fk_setor_superior = ss.id
WHERE ss.id = 1;

-- g) Exibir todos os setores e seus respectivos funcionários, incluindo setores que não possuem funcionários.
SELECT 
*
FROM setor AS s
LEFT JOIN funcionario AS f
ON f.fk_setor = s.id;

-- h) Exibir nome do funcionário, salário, setor e uma classificação salarial considerando três faixas definidas por você.
SELECT 
f.nome,
f.salario,
s.nome,
CASE 
	WHEN salario <= 4500 THEN 'Baixo'
    WHEN salario < 6000 THEN 'Médio'
    ELSE 'Alto'
END AS classificacao_salarial
FROM funcionario AS f
JOIN setor AS s
ON f.fk_setor = s.id;

-- i) Exibir os funcionários pertencentes a dois setores específicos utilizando IN.
SELECT 
* 
FROM funcionario AS f
JOIN setor AS s
ON f.fk_setor = s.id
WHERE s.id IN (1,2);

-- j) Atualizar o setor superior ao qual um determinado setor está subordinado.
UPDATE setor
SET fk_setor_superior = 1
WHERE id = 3;

-- k) Remover a subordinação de um determinado setor, fazendo com que ele deixe de possuir um setor superior.
UPDATE setor
SET fk_setor_superior = NULL
WHERE id = 2;

SELECT * FROM setor;







