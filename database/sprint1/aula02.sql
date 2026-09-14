USE sprint1;

-- boas práticas 
-- Usar nomes padrão snake_case ou camelCase
-- não usar caracters especiais e acentuaçãoptimize
-- sempre no singular para atributo, campo e nome de tabela

CREATE TABLE aluno(
	ra CHAR(8) PRIMARY KEY,
    nome VARCHAR(40) NOT NULL, -- TEXTO VARIÁVEL OBRIGATÓRIO,
    email VARCHAR(50) UNIQUE,-- NÃO PODE REPETIR,
    dataNasc DATE -- FORMATO ISO YYYY-MM-DD    
);

DESC aluno; -- METADADOS DA TABELA
SHOW TABLES; -- QUANTIDADE DE TABELAS NO DATABASE (METADADOS DO MEU BANCO DE DADOS - SCHEMA) 

INSERT INTO aluno (ra, nome, email, dataNasc) VALUE
('01262001', 'José', 'jose@gmail.com', '2008-05-28');

-- importante estar na ordem correta
INSERT INTO aluno VALUE
('01262002', 'Maria', 'maria@gmail.com', '2008-07-02');

-- visualizar os registros
SELECT * FROM aluno;

-- NÃO ALTERA OS DADOS ORIGINAL 
SELECT IFNULL(email, 'Sem email'), 
IFNULL (dataNasc, 'Sem registro'),
 nome FROM aluno;

 -- inserindo todos os dados obrigatórios
 INSERT INTO aluno (ra, nome) VALUES
 ('01262003', 'Victor'),
 ('01262004', 'Leonardo'),
 ('01262005', 'Yasmin');
 
 -- TENTATIVA INSERIR APENAS UM DOS DADOS OBRIGATÓRIOS
 INSERT INTO aluno (ra) VALUE 
 ('01262006');
 
 -- Exibir dados de um aluno
 SELECT * FROM aluno
 WHERE ra = '01262001';
 
-- ATUALIZAR OS DADOS DE UM ALUNO
UPDATE aluno 
SET email = 'victor@gmail.com'
WHERE ra = '01262003';

-- atualizando dois registros em uma unica query
UPDATE aluno 
SET email = 'victor1@gmail.com', 
dataNasc = '2005-07-18'
WHERE ra = '01262003';

-- alterar a estrutura da tabela - DDL
-- adicionando coluna
ALTER TABLE aluno ADD COLUMN nota DECIMAL (3,2); -- (9,99) primeira casa quantidade de numeros, e o segundo é apos a virgula 
ALTER TABLE aluno ADD COLUMN nota_float FLOAT; -- (9,99) primeira casa quantidade de numeros, e o segundo é apos a virgula 

DESC aluno;

-- adicionando nota para o aluno victor
UPDATE aluno 
SET nota = 9.99, nota_float = 9.767777
WHERE ra = '01262003';

SELECT * FROM aluno;

-- renomear nome de uma coluna
ALTER TABLE aluno RENAME COLUMN dataNasc TO dataNascimento;

-- modificar o metadado da coluna
ALTER TABLE aluno MODIFY COLUMN dataNascimento DATETIME; -- YYYY/-MM-DD HH-MM-SS

-- alterar o nome da tabela
ALTER TABLE aluno RENAME TO aluno_ads;

DESC aluno_ads;

-- Removendo uma coluna da tabela
ALTER TABLE aluno_ads DROP COLUMN nota_float;

-- alterando a tabela -- ADD A COLUMN ATIVO
ALTER TABLE aluno_ads ADD COLUMN ativo TINYINT; -- BOOLEAN (0 == falso, 1 == true)

-- Atualizar o campo ativo para todos os registros
UPDATE aluno_ads
SET ativo = 1
WHERE ra LIKE "0%";

SELECT * FROM aluno_ads;

-- criando uma coluna de genero
ALTER TABLE aluno_ads ADD COLUMN genero CHAR(1);

-- criando restrição no campo gênero
-- serve como restrição para o campo genero receber apenas m, f ou o. Ele não aceita outro valor
ALTER TABLE aluno_ads ADD CONSTRAINT chGenero 
CHECK(genero = 'm' OR genero ='f' OR genero = 'o');

SELECT * FROM aluno_ads;

-- atualizando o valor do genero
UPDATE aluno_ads SET genero = 'b' WHERE ra = '01262003';
UPDATE aluno_ads SET genero = 'm' WHERE ra = '01262003';

-- excluir um registro da tabela aluno_ads
DELETE FROM aluno_ads 
WHERE ra = '01262004';

-- excluir todos os registros
TRUNCATE TABLE aluno_ads;