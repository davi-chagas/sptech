-- creating a database
CREATE DATABASE sprint1;

-- using 
USE sprint1;

-- criando tabela atleta e atribuindo tipos
CREATE TABLE Atleta(
	idAtleta INT PRIMARY KEY,
    nome VARCHAR(40),
    modalidade VARCHAR(40),
    qtdMedalha INT
);

-- inserindo dados na tabela
INSERT INTO Atleta VALUES 
(1, 'NeskWGA', "E-Sports", 40),
(2, "Astro", "E-Sports", 40);

-- selecionando todos os dados da tabela
SELECT * FROM Atleta;

-- selecionando apenas o nome e a quantidade de medalhas da tabela atleta
SELECT nome, qtdMedalha FROM Atleta;

-- selecionando apenas a modalidade da tabela e precisa ser E-sports
SELECT * FROM Atleta
WHERE modalidade = "E-Sports";

-- visualizando os dados da tabela atleta do qual nome contem a letra A
SELECT * FROM Atleta
WHERE nome LIKE "%A%";

-- selecionando os dados da tabela do qual o nome começa com a letra A
SELECT * FROM Atleta
WHERE nome LIKE "a%";

-- selecionando os dados da tabela do qual o nome termina com a letra O
SELECT * FROM Atleta
WHERE nome LIKE "%o";

-- selecionando os dados da tabela do qual a penultima letra é o R
SELECT * FROM Atleta
WHERE nome LIKE "%r_";

-- apagando a tabela e seus dados
DROP TABLE Atleta;

