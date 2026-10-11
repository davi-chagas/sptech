USE sprint2;

/* OBS: algumas tabelas possuem referencia nesse mesmo banco de dados e não consigo dropar, por conta disso
renomeei para não conflitar */

CREATE TABLE publico_alvo (
	id INT PRIMARY KEY AUTO_INCREMENT,
    descricao VARCHAR(45) NOT NULL
);

CREATE TABLE colecao (
	id INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(45) NOT NULL,
    fk_publico_alvo INT,
    CONSTRAINT fk_publico_alvo_colecao FOREIGN KEY (fk_publico_alvo) REFERENCES publico_alvo(id)
);

CREATE TABLE livro (
	id INT PRIMARY KEY AUTO_INCREMENT,
	titulo VARCHAR(45) NOT NULL,
    ano_publicacao INT NOT NULL,
    numero_paginas INT NOT NULL,
    preco DECIMAL(5,2) NOT NULL,
    situacao VARCHAR(45),
    fk_colecao INT NOT NULL,
    CONSTRAINT fk_colecao_livro FOREIGN KEY (fk_colecao) REFERENCES colecao(id)
);

INSERT INTO publico_alvo (descricao) VALUES
('Infantil'),
('Jovem Adulto'),
('Adulto');

INSERT INTO colecao (nome, fk_publico_alvo) VALUES
('Aventuras Infantis', 1),
('Fantasia Juvenil', 2),
('Clássicos da Literatura', 3),
('Fantasia e Aventura', 2);

INSERT INTO livro (titulo, ano_publicacao, numero_paginas, preco, situacao, fk_colecao) VALUES
('O Pequeno Príncipe', 1943, 96, 29.90, 'Disponível', 1),
('Harry Potter e a Pedra Filosofal', 1997, 309, 39.90, 'Disponível', 2),
('Harry Potter e a Câmara Secreta', 1998, 251, 42.90, 'Disponível', 2),
('Dom Casmurro', 1899, 256, 32.90, 'Disponível', 3),
('O Hobbit', 1937, 310, 45.90, 'Disponível', 4);

-- a)Exibir todos os livros cadastrados.
SELECT * FROM livro;

-- b)Exibir o título, a coleção e o público-alvo de cada livro.

SELECT
l.titulo TITULO,
c.nome COLECAO,
p.descricao PUBLICO_ALVO
FROM livro AS l
JOIN colecao AS c
ON l.fk_colecao = c.id
JOIN publico_alvo AS p
ON c.fk_publico_alvo = p.id;

-- c)Exibir, sem repetição, as coleções que possuem livros destinados a um público-alvo específico.
SELECT DISTINCT 
c.nome
FROM colecao AS c
JOIN publico_alvo AS p
ON c.fk_publico_alvo = p.id;

-- d)Exibir os livros publicados após um ano escolhido, 
-- ordenados do mais recente para o mais antigo e limitando o resultado aos 3 primeiros registros.
SELECT 
*
FROM livro 
WHERE ano_publicacao > 1996
ORDER BY ano_publicacao ASC
LIMIT 3;

-- e)Exibir os livros com preço entre dois valores.
SELECT 
*
FROM livro
WHERE preco BETWEEN 30.00 AND 40.00;

-- f)Classificar cada livro como Curto (até 200 páginas), Médio (201 a 400) ou Longo (mais de 400).
SELECT
titulo,
ano_publicacao,
CASE
	WHEN numero_paginas <= 200 THEN 'Curto'
    WHEN numero_paginas <= 400 THEN 'Médio'
    ELSE 'Longo'
END AS tamanho
FROM livro;	

-- g)Atualizar o preço de um livro.
UPDATE livro
SET preco = 20.00
WHERE id = 3;

SELECT * FROM livro;

-- h)Excluir um livro.
DELETE FROM livro
WHERE id = 3;

-- INDICE 2 --

CREATE TABLE area_atuacao (
	id INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(45) NOT NULL
);

CREATE TABLE equipe_funcionario (
	id INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(45) NOT NULL,
	fk_area_atuacao INT NOT NULL,
    FOREIGN KEY (fk_area_atuacao) REFERENCES area_atuacao(id)
);

CREATE TABLE funcionario (
	id INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(45) NOT NULL,
    email VARCHAR(70) NOT NULL UNIQUE,
    data_admissao DATE NOT NULL,
    salario DECIMAL(10,2) NOT NULL,
    fk_equipe INT,
    fk_mentor INT,
    FOREIGN KEY (fk_equipe) REFERENCES equipe_funcionario(id),
    FOREIGN KEY (fk_mentor) REFERENCES funcionario(id)
);

INSERT INTO area_atuacao (nome) VALUES
('Tecnologia'),
('Marketing'),
('Recursos Humanos');

INSERT INTO equipe_funcionario (nome, fk_area_atuacao) VALUES
('Desenvolvimento', 1),
('Infraestrutura', 1),
('Marketing Digital', 2),
('Recrutamento', 3);

INSERT INTO funcionario 
(nome, email, data_admissao, salario, fk_equipe, fk_mentor) VALUES
('Carlos', 'carlos@empresa.com', '2020-01-10', 7000.00, 1, NULL),
('Ana', 'ana@empresa.com', '2021-03-15', 5000.00, 1, 1),
('Bruno', 'bruno@empresa.com', '2022-06-20', 4500.00, 1, 1),
('Carla', 'carla@empresa.com', '2023-02-10', 4000.00, 2, NULL),
('Diego', 'diego@empresa.com', '2024-01-15', 3500.00, 3, 4),
('Eva', 'eva@empresa.com', '2024-05-20', 3600.00, 4, NULL);

-- a)Exibir cada funcionário, sua equipe e a área de atuação da equipe.
SELECT f.nome,
e.nome,
a.nome
FROM funcionario AS f
JOIN equipe AS e
ON f.fk_equipe = e.id
JOIN area_atuacao AS a
ON e.fk_area_atuacao = a.id;

-- b)Exibir o nome de cada funcionário que possui mentor e o nome desse mentor.
-- Funcionários sem mentor não devem aparecer.
SELECT 
f.nome,
m.nome
FROM funcionario f
JOIN funcionario m 
ON f.fk_mentor = m.id;

-- c)Exibir os funcionários de duas áreas escolhidas, utilizando IN.
SELECT
*
FROM funcionario f
JOIN equipe_funcionario e
ON f.fk_equipe = e.id
JOIN area_atuacao a
ON e.fk_area_atuacao = a.id
WHERE a.id IN (1, 2);
 
-- d)Exibir funcionários admitidos após uma data escolhida, com o nome da equipe e da área,
-- limitando o resultado aos 3 mais recentemente admitidos.
SELECT 
f.nome NOME_FUNCIONARIO,
e.nome NOME_EQUIPE,
a.nome NOME_AREA_ATUACAO
FROM funcionario f
JOIN equipe_funcionario e
ON f.fk_equipe = e.id
JOIN area_atuacao a
ON e.fk_area_atuacao = a.id
WHERE data_admissao > '2022-01-01'
LIMIT 3;

-- e)Exibir as pessoas orientadas por um mentor específico.
SELECT 
f.nome FUNCIONARIO,
m.nome MENTOR
FROM funcionario f
JOIN funcionario m
ON f.fk_mentor = m.id
WHERE m.id = 1;

-- f)Exibir, sem repetição, os nomes dos mentores cujo nome comece com uma letra escolhida.
SELECT DISTINCT
m.nome
FROM funcionario AS f
JOIN funcionario AS m
ON f.fk_mentor = m.id
WHERE m.nome LIKE 'C%';

-- g)Excluir um funcionário que não seja mentor de outra pessoa.
DELETE FROM funcionario
WHERE id = 6;

SELECT * FROM funcionario;

-- INDICE 3

CREATE TABLE cursos (
	id INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(45) NOT NULL,
    carga_horario INT NOT NULL
);

CREATE TABLE turno (
	id INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(45) NOT NULL
);

CREATE TABLE turmas (
	id INT PRIMARY KEY AUTO_INCREMENT,
    codigo CHAR(8) NOT NULL UNIQUE,
    data_inicio DATE NOT NULL,
    fk_curso INT NOT NULL,
    fk_turno INT NOT NULL,
    CONSTRAINT fk_curso_turmas FOREIGN KEY (fk_curso) REFERENCES cursos(id),
    CONSTRAINT fk_turno_turmas FOREIGN KEY (fk_turno) REFERENCES turno(id)
);

CREATE TABLE status_matricula (
	id INT PRIMARY KEY AUTO_INCREMENT,
    descricao VARCHAR(45) NOT NULL,
    CONSTRAINT ch_descricao CHECK (descricao IN ('Concluída', 'Ativa', 'Trancada'))
);

CREATE TABLE aluno (
	id INT PRIMARY KEY AUTO_INCREMENT,
    ra CHAR(8) NOT NULL UNIQUE,
    nome VARCHAR(45) NOT NULL,
    email VARCHAR(70) NOT NULL UNIQUE,
    data_nascimento DATE NOT NULL,
    fk_matricula INT,
    fk_turma INT,
    FOREIGN KEY (fk_matricula) REFERENCES status_matricula(id),
    FOREIGN KEY (fk_turma) REFERENCES turmas(id)
);

INSERT INTO cursos (nome, carga_horario) VALUES
('Análise e Desenvolvimento de Sistemas', 2000),
('Engenharia de Software', 3200),
('Ciência da Computação', 3200);

INSERT INTO cursos (nome, carga_horario) VALUES
('Sistemas de Informação', 2000);


INSERT INTO turno (nome) VALUES
('Manhã'),
('Tarde'),
('Noite');

INSERT INTO turmas (codigo, data_inicio, fk_curso, fk_turno) VALUES
('ADS26A01', '2026-07-27', 1, 3),
('ADS26B01', '2026-01-28', 1, 1),
('ENG26A01', '2026-10-02', 2, 2),
('CC26A001', '2024-02-05', 3, 3);

INSERT INTO turmas (codigo, data_inicio, fk_curso, fk_turno) VALUES
('1ADSB', '2026-02-02', 1, 3);

INSERT INTO turmas (codigo, data_inicio, fk_curso, fk_turno) VALUES
('1ADSA', '2026-02-02', NULL, 3);

INSERT INTO status_matricula (descricao) VALUES
('Ativa'),
('Trancada'),
('Concluída');

INSERT INTO aluno
(ra, nome, email, data_nascimento, fk_matricula, fk_turma) VALUES
('10000001', 'Carlos Silva', 'carlos@email.com', '2005-03-15', 1, 1),
('10000002', 'Mariana Souza', 'mariana@email.com', '2004-07-22', 1, 1),
('10000003', 'João Oliveira', 'joao@email.com', '2005-01-10', 2, 1),
('10000004', 'Beatriz Lima', 'beatriz@email.com', '2004-11-05', 1, 2),
('10000005', 'Lucas Santos', 'lucas@email.com', '2003-09-18', 3, 3),
('10000006', 'Ana Costa', 'ana@email.com', '2005-05-27', 1, 4),
('10000007', 'Rafael Alves', 'rafael@email.com', '2004-02-14', 1, 4);

-- a)Exibir, sem repetição, os turnos em que há turmas cadastradas.
SELECT DISTINCT 
t.nome
FROM turno t
JOIN turmas 
ON turmas.fk_turno = t.id;

-- b)Exibir nome, RA, turma, curso e status de matrícula de cada aluno.
SELECT
a.nome,
a.ra,
t.codigo turma,
c.nome curso,
s.descricao
FROM aluno a
JOIN turmas t
ON a.fk_turma = t.id
JOIN cursos c
ON t.fk_curso = c.id
JOIN status_matricula s
ON a.fk_matricula = s.id;

-- c)Exibir os alunos de um curso escolhido, apresentando também suas turmas e limitando o resultado a 5 alunos.
SELECT
a.nome,
c.nome curso,
t.codigo turma
FROM aluno a
JOIN turmas t
ON a.fk_turma = t.id
JOIN cursos c
ON t.fk_curso = c.id
LIMIT 5;

-- d)Exibir os alunos com um status de matrícula específico.
SELECT
a.nome,
s.descricao
FROM aluno a
JOIN status_matricula s
ON a.fk_matricula = s.id
WHERE a.id = 1;

-- e)Exibir todos os cursos e, quando existirem, suas turmas. O curso sem turma também deve aparecer.
SELECT 
c.nome,
t.codigo turma
FROM cursos c
LEFT JOIN turma t
ON c.id = t.fk_curso;

-- f)Exibir todas as turmas e, quando existirem, seus alunos. A turma sem alunos também deve aparecer.
SELECT 
t.codigo turma,
a.nome
FROM turmas t
LEFT JOIN aluno a
ON a.fk_turma = t.id;

-- g)Exibir todos os cursos, suas turmas e os alunos dessas turmas, quando existirem.
--  O curso sem turma e a turma sem alunos devem aparecer.
SELECT 
c.nome,
t.codigo turma,
a.nome 
FROM cursos c
left JOIN turmas t
ON t.fk_curso = c.id
LEFT JOIN aluno a
ON a.fk_turma = t.id;
SELECT * FROM turmas;

-- h)Exibir o nome do aluno, a turma e sua data de início formatada como "dia/mês/ano".
--  Calcular também há quantos dias a turma começou e, com base nesse resultado,
--  classificá-la em três faixas definidas por você.
SELECT 
a.nome,
t.codigo,
DATE_FORMAT(t.data_inicio, '%d/%m/%Y'),
TIMESTAMPDIFF(DAY, t.data_inicio, NOW()) diferenca_em_dias,
CASE	
	WHEN TIMESTAMPDIFF(DAY, t.data_inicio, NOW()) > 200 THEN 'Veterano'
    ELSE 'Calouro'
END AS nivel
FROM aluno a
JOIN turmas t
ON a.fk_turma = t.id;

-- INDICE 4

CREATE DATABASE suporte_dcl;
USE suporte_dcl;

CREATE TABLE categoria (
	id INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(45) NOT NULL
);

CREATE TABLE status_chamado (
	id INT PRIMARY KEY AUTO_INCREMENT,
    descricao VARCHAR(45) NOT NULL,
    CONSTRAINT ch_descricao CHECK(descricao IN('pendente', 'concluido', 'cancelado', 'em andamento'))
);

CREATE TABLE chamado (
	id INT PRIMARY KEY AUTO_INCREMENT,
    titulo VARCHAR(45) NOT NULL,
    descricao VARCHAR(100),
    data_abertura DATETIME DEFAULT CURRENT_TIMESTAMP,
    fk_categoria INT,
    fk_status_chamado INT,
    FOREIGN KEY (fk_categoria) REFERENCES categoria(id),
    FOREIGN KEY (fk_status_chamado) REFERENCES status_chamado(id)
);

INSERT INTO categoria (nome) VALUES
('Hardware'),
('Software'),
('Rede');

INSERT INTO status_chamado (descricao) VALUES
('pendente'),
('em andamento'),
('concluido');

INSERT INTO chamado
(titulo, descricao, fk_categoria, fk_status_chamado) VALUES
('Computador não liga', 'Computador não apresenta nenhum sinal de energia.', 1, 1),
('Erro no sistema', 'Sistema apresenta erro ao tentar iniciar.', 2, 2),
('Internet lenta', 'Conexão apresenta lentidão durante o uso.', 3, 1),
('Teclado com defeito', 'Algumas teclas do teclado não funcionam.', 1, 3),
('Atualização de software', 'Necessário realizar atualização do sistema.', 2, 2),
('Queda de conexão', 'Computador perde conexão com a rede.', 3, 1);

CREATE USER atendente_suporte@localhost IDENTIFIED BY 'Atendente-2707';
GRANT SELECT ON suporte_dcl.* TO atendente_suporte@localhost;
GRANT INSERT, UPDATE ON suporte_dcl.chamado TO atendente_suporte@localhost;

CREATE USER analista_suporte@localhost IDENTIFIED BY 'Analista-2707';
GRANT SELECT ON suporte_dcl.* TO atendente_suporte@localhost;

CREATE USER gestor_suporte@localhost IDENTIFIED BY 'Gestor-2707';
GRANT SELECT, INSERT, UPDATE, DELETE ON suporte_dcl.* TO atendente_suporte@localhost;

SHOW GRANTS FOR atendente_suporte@localhost;
/*
SHOW GRANTS FOR atendente_suporte@localhost;
+----------------------------------------------------------------------------+
| Grants for atendente_suporte@localhost                                     |
+----------------------------------------------------------------------------+
| GRANT USAGE ON *.* TO `atendente_suporte`@`localhost`                      |
| GRANT SELECT ON `suporte_dcl`.* TO `atendente_suporte`@`localhost`         |
| GRANT INSERT ON `suporte_dcl`.`chamado` TO `atendente_suporte`@`localhost` |
+----------------------------------------------------------------------------+
3 rows in set (0.00 sec)
*/

SHOW GRANTS FOR analista_suporte@localhost;
/*
+-------------------------------------------------------------------+
| Grants for analista_suporte@localhost                             |
+-------------------------------------------------------------------+
| GRANT USAGE ON *.* TO `analista_suporte`@`localhost`              |
| GRANT SELECT ON `suporte_dcl`.* TO `analista_suporte`@`localhost` |
+-------------------------------------------------------------------+
2 rows in set (0.00 sec)
*/

SHOW GRANTS FOR gestor_suporte@localhost;
/*
+---------------------------------------------------------------------------------+
| Grants for gestor_suporte@localhost                                             |
+---------------------------------------------------------------------------------+
| GRANT USAGE ON *.* TO `gestor_suporte`@`localhost`                              |
| GRANT SELECT, INSERT, UPDATE, DELETE ON `suporte_dcl`.* TO `gestor_suporte`@`localhost` |
+---------------------------------------------------------------------------------+
*/

/* a)Consultar os chamados, apresentando o nome da categoria e a descrição do status.
	R: Todos conseguiram fazer select.
    
    b)Cadastrar um chamado utilizando uma categoria e um status já existentes.
	R: apenas atendente e gestor conseguiram fazer o insert, o analista tem o acesso negado
    
    c)Alterar o status de um chamado.
    R: apenas atendente e gestor conseguiram fazer o update, o analista tem o acesso negado
    
    d)Cadastrar uma nova categoria.
    R: apenas o gestor conseguiu fazer o insert, o analista e atendente possuem o acesso negado
    
    e)Cadastrar um novo status.
	R: apenas o gestor conseguiu fazer o insert, o analista e atendente possuem o acesso negado
    
    f)Excluir um chamado.
	R: apenas o gestor conseguiu fazer o delete, o analista e atendente possuem o acesso negado
*/

-- O atendente deixou de ser responsável por alterar chamados já registrados. Utilize REVOKE para retirar somente sua permissão de UPDATE na tabela chamado.
REVOKE UPDATE ON suporte_dcl.chamado FROM atendente_suporte@localhost;
