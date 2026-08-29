use sprint1;

CREATE TABLE aluguel (
	id INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(45),
    sobrenome VARCHAR(45),
    valor_total DECIMAL(5, 2), -- 000.00
    status VARCHAR(12)
);

TRUNCATE aluguel;

INSERT INTO aluguel (nome, sobrenome, valor_total, status) VALUES 
('Davi', 'Chagas', 505, 'finalizado'),
('Ana Carollini', 'Rossi', 950, 'finalizado'),
('Ramon', 'Coelho', 500, 'em_andamento'),
('Luis', 'Favariz', 400, 'em_andamento'),
('Vitoria', 'Lucena', 150, 'qlqr_coisa');

SELECT 
CONCAT(nome , ' ' , sobrenome) AS cliente,
valor_total as 'valor total',
CASE
	WHEN status = 'finalizado' THEN  'Concluido'
	WHEN status = 'em_andamento' THEN  'Em andamento'
	WHEN status != 'finalizando' OR status != 'em_andamento' THEN 'Cancelado'
    END AS situacao
FROM aluguel ORDER BY nome;

-- exercicio 2 --
CREATE DATABASE biblioteca;

use biblioteca;

CREATE TABLE livro (
	codigo INT PRIMARY KEY AUTO_INCREMENT,
    titulo VARCHAR(45),
    autor VARCHAR(45) DEFAULT 'Sem Autor',
    ano_publicacao DATE
);

INSERT INTO livro (titulo, autor, ano_publicacao) VALUES
('Harry Potter e a Pedra Filosofal', 'J.K Rolling', '1999-10-13'),
('Percy Jackson e o Ladrão de Raios', DEFAULT, '2002-02-19');

-- Exibir todos os registros existentes na tabela livro.
SELECT * FROM livro;

-- Alterar o nome do autor de um dos livros já cadastrados.
UPDATE livro
SET autor = 'Rick Riordan'
WHERE codigo = 2;

-- Exibir o titulo e o autor do registro alterado.
SELECT titulo, autor FROM livro
WHERE codigo = 2;

-- Remover um registro da tabela livro.
DELETE from livro
WHERE codigo = 1;

-- Mostrar a estrutura (colunas e tipos de dados) da tabela livro usando.
DESC livro;

-- Acrescentar uma nova coluna chamada editora na tabela livro.
ALTER TABLE livro ADD COLUMN editora VARCHAR(45);

-- Exibir todos os registros em que a coluna autor contenha a letra a.
SELECT * FROM livro
WHERE autor LIKE '%a%';

-- Excluir a coluna editora da tabela livro.
ALTER TABLE livro DROP COLUMN editora;

CREATE TABLE usuario (
	codigo INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(45) NOT NULL,
    tipo VARCHAR(9)
);

INSERT INTO usuario (nome, tipo) VALUES
('Davi', ''),
('Makima', '');

UPDATE usuario
SET tipo = 'visitante'
WHERE codigo IN (1, 2);

ALTER TABLE usuario MODIFY COLUMN tipo VARCHAR(9)
CONSTRAINT chTipo CHECK (tipo IN('docente', 'discente', 'visitante'));

-- Exibir todos os registros da tabela usuario em que a penúltima letra do campo nome seja m.
SELECT * FROM usuario
WHERE nome LIKE '%m_';

-- Alterar a tabela usuario, aumentando a quantidade de caracteres na coluna nome.
ALTER TABLE usuario MODIFY COLUMN nome VARCHAR(90);

SELECT nome AS nome_completo
FROM usuario;

SELECT 
CONCAT(titulo, ': ' ,autor) AS detalhes
FROM livro;

SELECT
titulo,
YEAR(ano_publicacao) ano_publicacao,
CASE
	WHEN ano_publicacao < '2000-01-01' THEN 'Antigo'
    WHEN ano_publicacao > '2000-01-01' THEN 'Moderno'
END AS classificacao
FROM livro;

SELECT * FROM livro
ORDER BY titulo DESC;

SELECT * FROM usuario
WHERE tipo != 'docente';

-- Esvaziar todos os registros da tabela livro, mantendo sua estrutura.
TRUNCATE livro;
-- Apagar o banco de dados biblioteca completamente.
DROP DATABASE biblioteca;

  
  
