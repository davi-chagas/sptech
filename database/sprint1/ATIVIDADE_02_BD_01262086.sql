USE sprint1;

-- criando tabela atleta 
CREATE TABLE atleta(
	idAtleta INT PRIMARY KEY,
    nome VARCHAR(40),
    modalidade VARCHAR(40),
    qtdMedalha INT
);	

INSERT INTO atleta VALUES
(1, 'Lionel Messi', 'Futebol', 42),
(2, 'Cristiano Ronaldo', 'Futebol', 40),
(3, 'Michael Jordan', 'Basquete', 6),
(4, 'Lebron James', 'Basquete', 4),
(5, 'Tom Brady', 'Futebol Americano', 8),
(6, 'Travis Kelce', 'Futebol Americano', 2);

INSERT INTO atleta VALUE
(7, 'Phelps', 'Natação', 5, '2012-12-12');

-- exibir todos os dados da tabela
SELECT * FROM atleta;
DESC atleta;

-- atualizar a quantidade de medalhas com o id 1
UPDATE atleta
SET qtdMedalha = 1
WHERE idAtleta = 1;

-- atualiza a quantidade de medalhas com o id 2 e 3
UPDATE atleta 
SET qtdMedalha = 70
WHERE idAtleta = 2 OR idAtleta = 3;

-- atualizar o nome do atleta com o id 4
UPDATE atleta
SET nome = 'Stephen Curry'
WHERE idAtleta = 4;

-- adicionar o campo dtnasc com o tipo date
ALTER TABLE atleta ADD COLUMN dtNasc DATE;

-- atualizar a data de nascimento de todos os atletas
UPDATE atleta
SET dtNasc = '2026-08-10'
WHERE idAtleta > 0;

-- excluir o atleta com o id 5
DELETE FROM atleta
where idAtleta = 5;

-- exibir os atletas onde a modalidade é diferente de natação
SELECT * FROM atleta
WHERE modalidade != "Natação";

-- exibir os dados de atleta que possuem a quantidade de medalhas maior ou igual 3
SELECT * FROM atleta
WHERE qtdMedalha >= 3;

-- modificar o campo modalidade do tamanho 40 para o tamanho 60
ALTER TABLE atleta MODIFY COLUMN modalidade VARCHAR(60);

-- descrever os campos da tabela
DESC atleta;

-- Limpar os dados da tabela
TRUNCATE TABLE atleta;
SELECT * FROM atleta; -- visualizar se apagou tudo

-- exercicio 2 --

CREATE TABLE musica (
	idMusica INT PRIMARY KEY,
    titulo VARCHAR(40),
    artista VARCHAR(40),
    genero VARCHAR(40)
);

INSERT INTO musica VALUES 
(1, 'Indiretas com a voz', 'Veigh', 'Trap'),
(2, 'Visões', 'Veigh', 'Trap'),
(3, 'Pq voce nao me liga?', 'NandaTsunami', 'Rap'),
(4, 'P.Y.T', 'Michael Jackson', 'Pop'),
(5, 'The chain', 'Fleetwood Mac', 'Rock'),
(6, 'Snooze', 'SZA', 'Pop'),
(7, 'Classic', 'Drake', 'R&B');

INSERT INTO musica VALUE
(8, 'Número da Sorte', 'Seendy', 'Funk', 2);

-- exibir todos os dados da tabela
SELECT * FROM musica;

-- adicionar o campo curtidas do tipo int
ALTER TABLE musica ADD COLUMN curtidas INT;

DESC musica;

-- atualizar o campo curtidas de todas as musicas cadastradas
UPDATE musica
SET curtidas = 100
WHERE idMusica > 0;

-- modificar o campo artista de 40 para 80
ALTER TABLE musica MODIFY COLUMN artista VARCHAR(80);

-- atualizar o campo de curtidas do id 1
UPDATE musica
SET curtidas = 20
WHERE idMusica = 1;

-- atualizar o campo de curtidas do id 2 e 3
UPDATE musica 
SET curtidas = 36
WHERE idMusica = 2 OR idMusica = 3;

-- atualizar o nome da musica do id 5
UPDATE musica
SET titulo = 'Geteway Car'
WHERE idMusica = 5;

-- excluir a musica com id 4
DELETE FROM musica
WHERE idMusica = 4;

-- exibir as musicas onde genero é diferente de funk
SELECT* FROM musica
WHERE genero != 'funk';

-- exibir os dados da musica que tem 20 ou mais curtidas
SELECT * FROM musica
WHERE curtidas >= 20;

-- descrever tabela
DESC musica;

-- limpar dados da tabela
TRUNCATE TABLE musica;

-- exercicio 3 --

CREATE TABLE filme (
	idFilme INT PRIMARY KEY,
    titulo VARCHAR(50),
    genero VARCHAR(40),
    diretor VARCHAR(40)
);

INSERT INTO filme VALUES
(1, 'Homem Aranha um novo dia', 'Fantasia', 'Destin Daniel Cretton'),
(2, 'Scarface', 'Drama', 'Brian De Palma'),
(3, 'Pulp Fiction', 'Crime', 'Quentin Tarantino'),
(4, 'Superman', 'Fantasia', 'James Gunn'),
(5, 'Guardioes da Galaxia', 'Fantasia', 'James Gunn'),
(6, 'Django Livre', 'Drama', 'Quentin Tarantino'),
(7, 'Mid90s', 'Comédia', 'Jonah Hill');

-- exibir todos os dados da tabela
SELECT * FROM filme;
DESC filme;

-- adicionar campo protagonista
ALTER TABLE filme ADD COLUMN protagonista VARCHAR(50);

-- atualizar o campo protagonista de todos os filmes
UPDATE filme
SET protagonista = 'Peter Parker'
WHERE idFilme > 0;

-- modificar o campo diretor de 40 para 150
ALTER TABLE filme MODIFY COLUMN diretor VARCHAR(150);

-- atualizar o diretor do filme 5
UPDATE filme
SET diretor = 'Sam Raimi'
WHERE idFilme = 5;

-- atualizar o diretor dos filmes 2 e 7
UPDATE filme
SET diretor = 'Copolla'
WHERE idFilme = 2 OR idFilme = 7;

-- atualizar o titulo do filme 6
UPDATE filme
SET titulo = 'Era uma vez em hollywood'
WHERE idFilme = 6;

-- Exibir os dados dos filmes que o gênero é igual ‘suspense’.

INSERT INTO filme VALUE
(8, 'Corra', 'Suspense', 'Jordan Peele', 'Chris');

SELECT * FROM filme
WHERE genero = 'Suspense';

-- Descrever campos da tabela
DESC filme;

-- limpar dados da tabela
TRUNCATE TABLE filme;

-- exercicio 4 --
CREATE TABLE professor (
	idProfessor INT PRIMARY KEY,
    nome VARCHAR(50),
    especialidade VARCHAR(40),
    dtNasc DATE
);

INSERT INTO professor VALUES
(1, 'Murilo', 'Banco de Dados', '2000-08-10'),
(2, 'Julia', 'Banco de Dados', '2000-04-12'),
(3, 'JP', 'Algoritmo', '1998-02-23'),
(4, 'Frizza', 'Algoritmo', '1960-12-30'),
(5, 'Brandão', 'Projeto e Inovação', '1980-01-10'),
(6, 'Márcio', 'Introdução a SO', '1999-03-30');

-- exibir todos os dados da tabela
SELECT * FROM professor;
DESC professor;

-- criando a coluna funçao
ALTER TABLE professor ADD COLUMN funcao VARCHAR(50);

-- fazendo a restrição dela
ALTER TABLE professor ADD CONSTRAINT chFuncao
	CHECK (funcao = 'monitor' OR funcao = 'assistente' OR funcao = 'titular'); 
 
-- atualizar a funçao dos professores 
UPDATE professor
SET funcao = 'monitor'
WHERE idProfessor > 0;

-- inserindo novo professor
INSERT INTO professor VALUE
(7, 'Rayssa', 'Socioemocional', '1992-09-02', 'titular');

-- excluir o professor 5
DELETE FROM professor
WHERE idProfessor = 5;

-- exibir apenas o nome dos professores titulares
SELECT nome FROM professor
WHERE funcao = 'titular';

-- Exibir apenas as especialidades e as datas de nascimento dos professores monitores.
SELECT especialidade, dtNasc FROM professor
WHERE funcao = 'monitor';

-- atualizar a data de nascimento do professor 3
UPDATE professor
SET dtNasc = '2004-07-18'
WHERE idProfessor = 3;

-- limpar a tabela professor
TRUNCATE TABLE professor;

-- exercicio 5 ---

CREATE TABLE curso (
	idCurso INT PRIMARY KEY,
    nome VARCHAR(50),
    sigla CHAR(3),
    coordenador VARCHAR(40)
);

INSERT INTO curso VALUES
(1, 'Análise e Desenvolvimento de Sistemas', 'ADS', 'Gerson'),
(2, 'Mecatronica', 'MEC', 'Cleisson'),
(3, 'Sistemas da Informação', 'SIS', 'Thiago');

-- Exibir todos os dados da tabela
SELECT * FROM curso;

-- exibir apenas os coordenadores dos cursos
SELECT coordenador FROM curso;

-- exibir os dados de um curso de uma determinada sigla
SELECT * FROM curso
WHERE sigla = 'ADS';

-- Exibir os dados da tabela ordenados pelo nome do curso
SELECT * FROM curso
ORDER BY nome;

-- Exibir os dados da tabela ordenados pelo nome do coordenador em ordem decrescente.
SELECT * FROM curso
ORDER BY coordenador DESC;

-- Exibir os dados da tabela dos cursos cujo nome comece com uma determinada letra.
SELECT * FROM curso
WHERE nome LIKE 'a%';

-- Exibir os dados da tabela dos cursos cujo nome termine com uma determinada letra.
SELECT * FROM curso
WHERE nome LIKE '%a';

-- Exibir os dados da tabela dos cursos cujo nome tenha como segunda letra uma determinada letra.
SELECT * FROM curso
WHERE nome LIKE '_n%';

-- Exibir os dados da tabela dos cursos cujo nome tenha como penúltima letra uma determinada letra.
SELECT * FROM curso
WHERE nome LIKE '%a_';

-- Eliminar a tabela
DROP TABLE curso;















