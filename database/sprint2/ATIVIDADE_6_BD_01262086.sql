USE sprint2;

-- Indice 1
CREATE TABLE pessoa1 (
	idPessoa1 INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(45),
    dtNascimento DATE
);

CREATE TABLE pessoa2 (
	idPessoa2 INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(45),
    dtNascimento DATE,
    fk_pessoa1 INT,
    INDEX fk_pessoa_1_idx (fk_pessoa1),
    CONSTRAINT fk_pessoa_1 FOREIGN KEY (fk_pessoa1) REFERENCES pessoa1(idPessoa1)
);

INSERT INTO pessoa1 VALUES
(DEFAULT, 'Davi', '2005-07-18'),
(DEFAULT, 'Carol', '2007-03-11'),
(DEFAULT, 'Ramon', '2005-05-05'),
(DEFAULT, 'Vitória', NULL),
(DEFAULT, 'Luiz Eduardo', NULL);

INSERT INTO pessoa2 (nome, dtNascimento, fk_pessoa1) VALUES
('Thiago Henrique', NULL, 1),
('Gabriel', '2006-12-04', 3),
('Quézia', NULL, NULL);

SELECT * FROM pessoa1;
SELECT * FROM pessoa2;

-- Exibir todos os dados de todas as Pessoa1 e suas Pessoa2 correspondentes.
SELECT * FROM pessoa1
LEFT JOIN pessoa2 ON pessoa2.fk_pessoa1 = pessoa1.idPessoa1;

-- Exibir os dados de uma Pessoa1 apenas e sua Pessoa2 correspondente.
SELECT * FROM pessoa1
JOIN pessoa2 ON pessoa2.fk_pessoa1 = pessoa1.idPessoa1;

-- Exibir os dados de uma Pessoa2 apenas e sua Pessoa1 correspondente.
SELECT * FROM pessoa2
JOIN pessoa1 ON pessoa1.idPessoa1 = pessoa2.fk_pessoa1;

-- Exibir apenas o nome das Pessoa1 e Pessoa2 correspondentes.
SELECT p1.nome, p2.nome FROM pessoa1 AS p1
JOIN pessoa2 AS p2 ON p2.fk_pessoa1 = p1.idPessoa1;

-- Exibir todas as Pessoa1 que correspondam a uma Pessoa2 cuja data de nascimento seja posterior ao ano 2000.
SELECT *
 FROM pessoa1 AS p1
JOIN pessoa2 AS p2 
ON p2.idPessoa2= p1.idPessoa1
WHERE p2.dtNascimento > '2000-01-01';

-- Indice 2
CREATE TABLE pessoa (
	idpessoa INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(45),
    cpf CHAR(11) UNIQUE
);

CREATE TABLE reserva (
	idReserva INT PRIMARY KEY AUTO_INCREMENT,
    dtReserva DATETIME,
    dtRetirada DATETIME,
    dtDevolucao DATETIME,
    fkPessoa INT,
    INDEX fk_pessoa_idx (fkPessoa),
    CONSTRAINT fk_pessoa FOREIGN KEY (fkPessoa) REFERENCES pessoa(idpessoa)
);

INSERT INTO pessoa VALUES
(DEFAULT, 'Davi', '00000000000'),
(DEFAULT, 'Carol', '11122233344'),
(DEFAULT, 'Gustavo', '01234567890'),
(DEFAULT, 'Matheus Kikuti', '12365494521');

INSERT INTO reserva VALUES 
(DEFAULT, '2026-11-10 19:30:00', '2026-11-10 19:00:00', '2026-11-10 22:00:00', 1),
(DEFAULT, '2026-11-10 19:30:00', '2026-11-10 19:00:00', '2026-11-10 22:00:00', 2),
(DEFAULT, '2026-04-15 12:30:00', '2026-04-15 11:00:00', '2026-04-16 18:40:00', 3),
(DEFAULT, '2026-07-08 08:30:00', '2026-07-08 09:00:00', '2026-07-15 20:30:00', 4);

-- Exibir todos os dados de todas as pessoas e suas reservas correspondentes.
SELECT * FROM pessoa
JOIN reserva ON idReserva = pessoa.idpessoa;

-- Exibir os dados de uma pessoa apenas e suas reservas correspondentes.
SELECT * FROM pessoa AS p
JOIN reserva AS r ON idReserva = p.idpessoa
WHERE p.idpessoa = 1;

-- Exibir apenas o nome das pessoas e a data de reserva.
SELECT p.nome AS nome_pessoa,
r.dtReserva AS data_reserva 
FROM pessoa AS p
JOIN reserva AS r ON r.idReserva = p.idpessoa;

-- Exibir os dados das pessoas e suas reservas de forma que mostre a mensagem: [NOME DA PESSOA] retirou na data [DATA DE RETIRADA].
SELECT 
CONCAT(p.nome, ' retirou na data ', r.dtRetirada) AS informacao
FROM pessoa AS p
JOIN reserva AS r
ON r.idReserva = p.idpessoa;

-- Exibir os dados das pessoas e suas reservas; caso a data de retirada esteja nula, deve aparecer a mensagem 'Não foi retirado'; caso a data de devolucao esteja nula, deve aparecer a mensagem 'Não foi devolvido'.
SELECT p.idpessoa,
 p.nome,
 p.cpf, r.idReserva, r.dtReserva, IFNULL(dtRetirada, 'Não foi retirado'),
IFNULL( dtDevolucao, 'Não foi devolvido'),
r.fkPessoa FROM pessoa AS p
JOIN reserva AS r ON r.idReserva = p.idpessoa;

USE sprint2;

CREATE TABLE restaurante (
	id INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(45),
    bairro VARCHAR(45),
    nota_avaliacao TINYINT,
    CONSTRAINT ch_nota_avaliacao CHECK (nota_avaliacao IN (0, 1, 2, 3 ,4 ,5))
);

CREATE TABLE prato (
	id INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(45),
    tipo VARCHAR(8),
    CONSTRAINT ch_tipo CHECK(tipo IN('Sushi', 'Sashimi', 'Temaki', 'Ramen', 'Yakisoba')),
    preco DECIMAL(5, 2),
    CONSTRAINT ch_preco CHECK (preco > 0),
    disponivel TINYINT DEFAULT 1,
    fk_restaurante INT,
    CONSTRAINT fk_prato_restaurante FOREIGN KEY (fk_restaurante) REFERENCES restaurante(id)
);

-- 1. Inserir restaurantes
INSERT INTO restaurante (nome, bairro, nota_avaliacao) VALUES
('Sabor da Casa', 'Vila Formosa', 4),
('Cantina Italiana', 'Vila Linda', NULL),
('Burger House', 'Carijós' , 2);


-- 2. Inserir pratos associados aos restaurantes
INSERT INTO prato (nome, tipo, preco, disponivel, fk_restaurante) VALUES
('Sushi Salmão', 'Sushi', 32.90, 1, 1),
('Sashimi Salmão', 'Sashimi', 38.90, 1, 1),
('Temaki Atum', 'Temaki', 25.90, 1, 2),
('Ramen Tradicional', 'Ramen', 42.90, 0, 2),
('Yakisoba Especial', 'Yakisoba', 35.90, 1, 3);

-- Exibir o nome e o preco de todos os pratos.
SELECT nome, preco FROM prato;

-- Exibir apenas os pratos do tipo Ramen.
SELECT * FROM prato
WHERE tipo = 'Ramen';

-- Exibir os pratos ordenados pelo preco em ordem crescente.
SELECT * FROM prato
ORDER BY preco ASC;

-- Exibir apenas os pratos com preço superior a R$ 30.
SELECT * FROM prato
WHERE preco > 30;

-- Exibir o nome do prato como 'Prato' e o preco como 'Valor (R$)'.
SELECT  nome AS Prato,
preco AS 'Valor (R$)'
FROM prato;

-- Exibir o nome do restaurante como 'Estabelecimento' e o bairro como 'Localização'.
SELECT nome AS Estabelecimento,
bairro AS Localização
FROM restaurante;

-- Exibir o preco com desconto de 10% como 'Preço com Desconto 10%' para cada prato.
SELECT preco * 0.90 AS 'Preço com Desconto 10%'
FROM prato;

-- Exibir o nome do prato e o tipo, renomeando para 'Item do Cardapio' e 'Categoria'.
SELECT nome AS 'Item do Cardapio',
tipo AS categoria
FROM prato;

-- Exibir o nome do prato e uma coluna 'faixa_preço' usando CASE:
-- pratos com preço abaixo de R$ 25 devem exibir 'Barato', pratos com preço entre R$ 25 e R$ 50 devem exibir 'Moderado', e os demais devem exibir 'Premium'.
SELECT nome, 
CASE 
	WHEN preco < 25 THEN 'Barato'
    WHEN preco <= 50 THEN 'Moderado'
    ELSE 'Premium'
	END AS faixa_preco
FROM prato;

SELECT nome,
CASE 
	WHEN disponivel = 1 THEN 'Disponível'
    ELSE 'Indisponivel'
	END AS status
FROM prato;

SELECT nome,
CASE
	WHEN nota_avaliacao >= 4 THEN 'Excelente'
    WHEN nota_avaliacao >= 3 THEN 'Bom'
	ELSE 'Regular'
    END AS classificacao
FROM restaurante;

SELECT nome,
CASE 
	WHEN tipo = 'Sushi' OR tipo = 'Sashimi' THEN 'Prato Frio'
    ELSE 'Prato quente'
    END AS origem
FROM prato;

-- Exibir o nome do restaurante e substituir o campo nota_avaliacao nulo por 'Sem avaliação' usando IFNULL.
SELECT nome,
IFNULL(nota_avaliacao, 'Sem avaliação') AS nota_avaliação
FROM restaurante;

-- Fazer um LEFT JOIN entre restaurante e prato e substituir o nome do prato por 'NENHUM PRATO' quando não houver nenhum prato associado.
SELECT r.nome, 
IFNULL(p.nome, 'NENHUM PRATO') AS prato
FROM restaurante AS r
LEFT JOIN prato AS p 
ON p.fk_restaurante = r.id;

-- Fazer um INNER JOIN entre prato e restaurante para exibir o nome do prato, o preço e o nome do restaurante.
SELECT p.nome,
p.preco,
r.nome FROM prato AS p
JOIN restaurante AS r
ON r.id = p.fk_restaurante;

-- Fazer um INNER JOIN entre prato e restaurante e combinar as colunas em uma unica coluna chamada 'cardapio', no formato "Prato - Tipo - Restaurante".
SELECT 
CONCAT('Prato: ', p.nome, ' - Tipo ', p.tipo, ' - Restaurante ', r.nome) AS cardapio
FROM prato AS p
JOIN restaurante AS r ON r.id = p.fk_restaurante;

-- Fazer um RIGHT JOIN entre prato e restaurante para exibir todos os restaurantes, inclusive os sem pratos cadastrados.
SELECT * FROM prato AS p
RIGHT JOIN restaurante AS r ON p.fk_restaurante = r.id;

CREATE TABLE usuario (
	id INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(45)
);

CREATE TABLE carteira_habilitacao (
	id INT PRIMARY KEY AUTO_INCREMENT,
    nivel_carteira VARCHAR(5),
    CONSTRAINT ch_nivel_carteira CHECK (nivel_carteira IN('A', 'B', 'ACC', 'A e B')),
    validade DATE,
    fk_pessoa INT,
    CONSTRAINT fk_carteira_pessoa FOREIGN KEY (fk_pessoa) REFERENCES usuario(id)
);

INSERT INTO usuario (nome) VALUES
('Davi'),
('Carlos'),
('Mariana'),
('Beatriz'),
('Rafael');

INSERT INTO carteira_habilitacao 
(nivel_carteira, validade, fk_pessoa) VALUES
('A', '2025-09-10', 1),
('B', '2027-03-07', 2),
('ACC', '2025-07-24', 3),
('A e B', '2029-09-15', 4),
('B', '2032-12-03', 5);

-- Exibir todos os dados de todas as pessoas e sua carteira de habilitacao correspondente.
SELECT * FROM usuario AS u
JOIN carteira_habilitacao AS ch ON ch.fk_pessoa = u.id;

-- Exibir os dados de uma pessoa apenas e sua carteira de habilitacao correspondente.
SELECT * FROM usuario AS u
JOIN carteira_habilitacao AS ch ON ch.fk_pessoa = u.id
WHERE u.id = 1;

-- Exibir apenas o nome das pessoas e a categoria da carteira de habilitacao correspondente.
SELECT u.nome, 
ch.nivel_carteira AS categoria
FROM usuario AS u
JOIN carteira_habilitacao AS ch ON ch.fk_pessoa = u.id
WHERE u.id = 2;

-- Exibir todas as pessoas que tem a categoria A.
SELECT *
FROM usuario AS u
JOIN carteira_habilitacao AS ch ON ch.fk_pessoa = u.id
WHERE nivel_carteira LIKE '%A%';

-- Exibir os dados das pessoas cuja carteira de habilitacao esteja vencida.
SELECT * 
FROM usuario AS u
JOIN carteira_habilitacao AS ch ON ch.fk_pessoa = u.id
WHERE validade < '2026-09-26';

CREATE TABLE clube (
	id INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(45),
    cidade VARCHAR(45),
    estadio VARCHAR(45)
);

CREATE TABLE jogador (
	id INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(45),
    posicao VARCHAR(15),
    CONSTRAINT ch_posicao CHECK (posicao IN('Goleiro', 'Defensor', 'Meia', 'Atacante')),
    numero_camisa INT,
	salario DECIMAL (10, 2),
    CONSTRAINT ch_salario CHECK (salario > 0),
    fk_clube INT,
    CONSTRAINT fk_clube_jogador FOREIGN KEY (fk_clube) REFERENCES clube(id)
);

-- Inserindo os times
INSERT INTO clube (nome, cidade, estadio) VALUES
('Santos FC', 'Santos', 'Vila Belmiro'),
('São Paulo', 'São Paulo', 'Morumbis'),
('Corinthians', 'São Paulo', 'Neo Química Arena'),
('Palmeiras', 'São Paulo', NULL);

INSERT INTO jogador (nome, posicao, numero_camisa, salario, fk_clube) VALUES
('João Silva', 'Goleiro', 1, 15000.00, 1),
('Carlos Oliveira', 'Defensor', 4, 18000.00, 2),
('Lucas Santos', 'Meia', 8, 22000.00, 2),
('Rafael Costa', 'Atacante', 9, 30000.00, 3),
('Pedro Henrique', 'Defensor', 3, 17000.00, 1),
('Gabriel Souza', 'Atacante', 10, 25000.00, NULL);

-- Exibir todos os dados das duas tabelas com SELECT para verificar os dados inseridos.
SELECT * FROM clube;
SELECT * FROM jogador;

-- Exibir o nome e o salario de todos os jogadores.
SELECT nome, salario
FROM jogador;

-- Exibir apenas os jogadores que atuam como Atacante.
SELECT * FROM jogador 
WHERE posicao LIKE 'Atacante';

-- Exibir os jogadores ordenados pelo salario em ordem decrescente.
SELECT * FROM jogador
ORDER BY salario DESC;

-- Exibir apenas os jogadores com salario superior a 5000.
SELECT * FROM jogador 
WHERE salario > 5000;

-- Exibir o nome do jogador como 'Nome do Jogador' e o salario como 'Salario Mensal'.
SELECT nome AS 'Nome do Jogador',
salario AS 'Salario Mensal'
FROM jogador;

-- Exibir o nome do time como 'Clube' e o estadio como 'Arena'.
SELECT nome AS 'time',
estadio AS 'Arena'
FROM clube;

-- Exibir o salario multiplicado por 12 como 'Salario Anual' para cada jogador.
SELECT 
salario * 12 AS 'Salario Anual'
FROM jogador;

-- Exibir o nome e o numero_camisa do jogador, renomeando para 'Atleta' e 'Camisa'.
SELECT nome AS Atleta,
numero_camisa AS Camisa
FROM jogador;

SELECT nome,
CASE
	WHEN salario < 3000 THEN 'Baixo'
    WHEN salario <= 8000 THEN 'Médio'
    ELSE 'Alto'
END AS faixa_salarial
FROM jogador;

SELECT nome,
CASE
	WHEN posicao = 'Goleiro' OR posicao = 'Defensor' THEN 'Linha de Defesa'
	WHEN posicao = 'Meia' THEN 'Meio Campo'
    ELSE 'Ataque'
END AS 'tipo_posição'
FROM jogador;

SELECT nome,
CASE
	WHEN estadio IS NOT NULL THEN 'Sim'
    ELSE 'Não'
END AS possui_estadio
FROM clube;

SELECT nome,
CASE
	WHEN numero_camisa = 10 THEN 'Camisa 10 - Craque'
    ELSE 'jogador'
END AS destaque
FROM jogador;

-- Exibir o nome do jogador e substituir o campo fk_time nulo por 'Sem time' usando IFNULL.
SELECT nome,
IFNULL(fk_clube, 'Sem time') AS clube
FROM jogador;

-- Fazer um LEFT JOIN entre jogador e time para exibir o nome do time; substituir o nome do time por 'SEM CLUBE' quando não houver associação.
SELECT * FROM jogador AS j
LEFT JOIN clube AS c ON c.id = j.fk_clube;

-- Fazer um INNER JOIN entre jogador e time para exibir o nome do jogador, a posição e o nome do time.
SELECT j.nome, 
j.posicao,
c.nome 
FROM jogador AS j
JOIN clube AS c ON c.id = j.fk_clube;

-- Fazer um INNER JOIN entre jogador e time e combinar as colunas em uma unica coluna chamada 'ficha', no formato "Jogador - Posição - Time".
SELECT 
CONCAT(j.nome, ' - ', j.posicao, ' - ', c.nome) AS ficha
FROM jogador AS j
JOIN clube AS c ON c.id = j.fk_clube;

-- Fazer um RIGHT JOIN entre jogador e time para exibir todos os times, inclusive os que não possuem jogadores cadastrados.
SELECT *
FROM jogador AS j
RIGHT JOIN clube AS c
ON c.id = j.fk_clube;

CREATE TABLE animal (
	id INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(45),
    especie VARCHAR(45),
    raca VARCHAR(45),
    idade TINYINT
);

CREATE TABLE ficha_medica (
	id INT PRIMARY KEY AUTO_INCREMENT,
    data_ultima_consulta DATE,
    peso DECIMAL(5, 2), -- xxx.00
    vacina_em_dia TINYINT DEFAULT 1,
    observacao VARCHAR(100),
    fk_animal INT UNIQUE,
    CONSTRAINT fk_ficha_animal FOREIGN KEY (fk_animal) REFERENCES animal(id)
);

INSERT INTO animal (nome, especie, raca, idade) VALUES
('Thor', 'Cachorro', 'Golden Retriever', 5),
('Luna', 'Gato', 'Siamês', 3),
('Mel', 'Cachorro', 'Poodle', 7),
('Joaquim', 'Gato', 'Persa', 2),
('Snoopy', 'Cachorro', 'Beagle', 4);

INSERT INTO ficha_medica 
(data_ultima_consulta, peso, vacina_em_dia, observacao, fk_animal) VALUES
('2026-08-15', 28.50, 1, 'Animal saudável.', 1),
('2026-07-20', 4.20, 1, 'Sem alterações clínicas.', 2),
('2026-06-10', 12.80, 0, 'Necessita atualização das vacinas.', 3),
('2026-09-01', 5.50, 1, 'Consulta de rotina.', 4);

-- Exibir todos os dados das duas tabelas com SELECT para verificar os dados inseridos.
SELECT * FROM animal;
SELECT * FROM ficha_medica;

-- Exibir o nome e a especie de todos os animais.
SELECT nome, 
especie
FROM animal;

-- Exibir as fichas médicas dos animais com vacina em atraso.
SELECT *
FROM ficha_medica
WHERE vacina_em_dia = 0;

-- Exibir os animais ordenados pela idade em ordem decrescente.
SELECT * 
FROM animal
ORDER BY idade DESC;

--  Exibir apenas os animais da especie Cachorro (ou a especie que você inseriu).
SELECT * 
FROM animal
WHERE especie LIKE 'Cachorro';

-- Exibir o nome do animal como 'Pet' e a especie como 'Tipo'.
SELECT 
nome AS pet,
especie AS tipo
FROM animal;

-- Exibir o peso da ficha médica como 'Peso (kg)' e a data_ultima_consulta como 'Ultima Consulta'.
SELECT
peso AS 'Peso (kg)',
data_ultima_consulta AS 'Ultima Consulta'
FROM ficha_medica;

-- Exibir a idade multiplicada por 7 como 'Idade Humana Aproximada' para cada animal.
SELECT nome,
idade * 7 AS 'Idade Humana Aproximada'
FROM animal;

-- Exibir o nome do animal e a raca, renomeando para 'Nome do Pet' e 'Raca/Tipo'.
SELECT
nome AS 'Nome do Pet',
raca AS 'Raca/Tipo' 
FROM animal;

SELECT
nome,
CASE
	WHEN idade < 2 THEN 'Filhote'
    WHEN idade <= 7 THEN 'Adulto'
    ELSE 'Idoso'
END AS fase_vida
FROM animal;

SELECT 
a.nome,
CASE
	WHEN vacina_em_dia = 1 THEN 'Vacinado'
    ELSE 'Pendente'
END AS vacinacao
FROM animal AS a
JOIN ficha_medica AS f
ON f.fk_animal = a.id;

SELECT
peso,
CASE
	WHEN peso < 5 THEN 'Pequeno'
    WHEN peso <= 20 THEN 'Médio'
    ELSE 'Grande'
END AS porte
FROM ficha_medica;

SELECT
nome,
CASE
	WHEN especie LIKE 'Cachorro' THEN 'Canino'
    WHEN especie LIKE 'Gato' THEN 'Felino'
    ELSE 'Outro'
END AS especie_tipo
FROM animal;

-- Exibir o nome do animal e substituir o campo observacao nulo por 'Nenhuma observação' (usando JOIN com ficha_medica).
SELECT
a.nome,
f.observacao
FROM animal AS a
JOIN ficha_medica AS f ON f.fk_animal = a.id;

SELECT * 
FROM animal AS a
LEFT JOIN ficha_medica AS f 
ON f.fk_animal = a.id;	

-- Fazer um INNER JOIN entre animal e ficha_medica para exibir o nome do animal, o peso e a data da ultima consulta.
SELECT 
a.nome,
f.peso,
f.data_ultima_consulta
FROM animal AS a
JOIN ficha_medica AS f
ON f.fk_animal = a.id;

-- Fazer um INNER JOIN entre animal e ficha_medica e combinar as colunas em uma unica coluna chamada 'resumo', no formato "Animal - Especie - Peso kg".
SELECT
CONCAT(a.nome, ' - ', a.especie, ' - ', f.peso,'kg') AS resumo
FROM animal AS a
JOIN ficha_medica AS f
ON f.fk_animal = a.id;

-- Exibir todos os animais e substituir o campo raca nulo por 'Raca não informada' usando IFNULL.
SELECT nome,
especie,
IFNULL(raca, 'Raça não informada') AS raca,
idade
FROM animal;

CREATE TABLE farmacia (
	id INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(45),
    cnpj CHAR(18)
);

CREATE TABLE endereco (
	id INT PRIMARY KEY AUTO_INCREMENT,
    rua VARCHAR(45),
    numero VARCHAR(45),
    bairro VARCHAR(45),
    cidade VARCHAR(45),
    fk_farmacia INT UNIQUE,
    CONSTRAINT fk_endereco_farmacia FOREIGN KEY (fk_farmacia) REFERENCES farmacia(id)
);

CREATE TABLE farmaceutico (
	id INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(70),
    crf VARCHAR(20),
    turno VARCHAR(10)
    CONSTRAINT ch_turno CHECK (turno IN ('Manhã', 'Tarde', 'Noite')),
    fk_farmacia INT,
    CONSTRAINT fk_farmaceutico_farmacia FOREIGN KEY (fk_farmacia) REFERENCES farmacia(id)
);

INSERT INTO farmacia (nome, cnpj) VALUES
('Drogaria São Paulo', '12345678000101'),
('Drogasil', '23456789000102'),
('Pague Menos', '34567890000103');

INSERT INTO endereco (rua, numero, bairro, cidade, fk_farmacia) VALUES
('Rua das Flores', 150, 'Centro', 'São Paulo', 1),
('Avenida Brasil', 850, 'Vila Mariana', 'São Paulo', 2);

INSERT INTO farmaceutico 
(nome, crf, turno, fk_farmacia) VALUES
('Ana Carolina Souza', '12345', 'Manhã', 1),
('Bruno Henrique Lima', '23456', 'Tarde', 1),
('Camila Oliveira', '34567', 'Noite', 2),
('Daniel Santos', '45678', 'Manhã', 2),
('Fernanda Alves', '56789', 'Tarde', 3);

-- Exibir todos os dados das tres tabelas com SELECT para verificar os dados inseridos.
SELECT * FROM farmacia;
SELECT * FROM endereco;
SELECT * FROM farmaceutico;

-- Exibir o nome e o cnpj de todas as farmácias.
SELECT 
nome,
cnpj 
FROM farmacia;

-- Exibir apenas os farmacêuticos que trabalham no turno da Noite.
SELECT 
* 
FROM farmaceutico
WHERE turno LIKE 'Noite';

-- Exibir os endereços ordenados pela cidade em ordem alfabética.
SELECT
*
FROM endereco
ORDER BY cidade ASC;

-- Exibir o nome e o CRF de todos os farmacêuticos.
SELECT
nome,
crf
FROM farmaceutico;

-- Exibir o nome da farmácia como 'Estabelecimento' e o cnpj como 'Documento'.
SELECT
nome AS Estabelecimento,
cnpj AS Documento
FROM farmacia;

-- Exibir o nome do farmacêutico como 'Profissional' e o turno como 'Horario de Trabalho'.
SELECT
nome AS Profissional,
turno AS 'Horário de trabalho'
FROM farmaceutico;

-- Exibir a rua e o numero do endereço como 'Logradouro' e 'Num.'.
SELECT
rua AS Lograduoro ,
numero AS 'Num.' 
FROM endereco;

-- Combinar a rua e o numero em uma unica coluna chamada 'Endereço Completo'.
SELECT 
CONCAT(rua, ', ', numero) AS 'Endereço Completo'
FROM endereco;

SELECT 
nome,
CASE
	WHEN turno = 'Manhã' THEN '06h12h'
    WHEN turno = 'Tarde' THEN '12h-18h'
    ELSE '18h-00h'
END AS periodo
FROM farmaceutico;

SELECT 
nome,
CASE
	WHEN cnpj LIKE '1_%' THEN 'Matriz'
    ELSE 'Filial'
END AS tipo_cnpj
FROM farmacia;

SELECT 
bairro,
CASE
	WHEN bairro = 'Centro' THEN 'Zona Norte'
    ELSE 'Outra'
END AS zona
FROM endereco;

SELECT
nome,
CASE
	WHEN turno = 'Noite' THEN 'Adicional Noturno'
    ELSE 'Normal'
END AS carga_horaria
FROM farmaceutico;

SELECT 
f.id,
f.nome,
IFNULL(e.rua, 'SEM ENDEREÇO') AS endereco
FROM farmacia AS f
LEFT JOIN endereco AS e 
ON e.id = f.id;

SELECT 
fo.nome,
fo.crf,
f.nome 
FROM farmaceutico fo
JOIN farmacia AS f
ON fo.fk_farmacia = f.id;

SELECT 
f.nome,
e.cidade,
fo.nome
FROM farmacia AS f
JOIN endereco AS e 
ON e.fk_farmacia = f.id
JOIN farmaceutico AS fo
ON fo.fk_farmacia = f.id;

SELECT 
CONCAT(fo.nome, ' - ', fo.crf, ' - ', f.nome) AS info
FROM farmaceutico AS fo
JOIN farmacia AS f 
ON fo.fk_farmacia = f.id;

SELECT 
IFNULL(bairro, 'Bairro não informado') AS bairro
FROM endereco;

CREATE TABLE artista (
	id INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(45),
    genero_musical VARCHAR(45),
    pais VARCHAR(45),
    ativo TINYINT DEFAULT 1
);

CREATE TABLE musica (
	id INT PRIMARY KEY AUTO_INCREMENT,
    titulo VARCHAR(45),
    duracao_segundos INT,
    ano_lancamento INT,
    fk_artista INT,
    CONSTRAINT fk_musica_artista FOREIGN KEY (fk_artista) REFERENCES artista(id)
);

INSERT INTO artista (nome, genero_musical, pais, ativo) VALUES
('Ariana Grande', 'Pop', 'Estados Unidos', 1),
('Tyler, The Creator', 'Hip Hop', 'Estados Unidos', 1),
('Pharrell Williams', 'Hip Hop', NULL, 1);

INSERT INTO musica (titulo, duracao_segundos, ano_lancamento, fk_artista) VALUES
('7 rings', 178, 2019, 1),
('thank u, next', 207, 2019, 1),
('EARFQUAKE', 190, 2019, 2),
('See You Again', 180, 2017, 2),
('Happy', 233, 2013, NULL);

SELECT * FROM artista;
SELECT * FROM musica;

-- Exibir o titulo e a duracao_segundos de todas as músicas.
SELECT titulo,
duracao_segundos
FROM musica;

-- Exibir as músicas lancadas apos o ano 2020.
SELECT * FROM musica
WHERE ano_lancamento > 2020;

-- Exibir os artistas ordenados pelo nome em ordem alfabética.
SELECT
*
FROM artista
ORDER BY nome ASC;

-- Exibir apenas as músicas com duração superior a 200 segundos.
SELECT 
*
FROM musica
WHERE duracao_segundos > 200;

-- Exibir o titulo da música como 'Nome da Música' e o ano_lancamento como 'Ano'.
SELECT 
titulo AS 'Nome da Música',
ano_lancamento AS ano
FROM musica;

-- Exibir o nome do artista como 'Cantor/Banda' e o genero_musical como 'Estilo'.
SELECT
nome AS 'Cantor/Banda',
genero_musical AS Estilo
FROM artista;

-- Exibir a duracao_segundos dividida por 60 como 'Duração (min)'.
SELECT 
duracao_segundos / 60 AS 'Duração (min)'
FROM musica;

-- Exibir o titulo e o ano_lancamento, renomeando para 'Faixa' e 'Lançamento'.
SELECT 
titulo AS faixa,
ano_lancamento AS 'Lançamento'
FROM musica;

SELECT
titulo,
CASE
	WHEN ano_lancamento < 2000 THEN 'Clássico'
    WHEN ano_lancamento <= 2015 THEN 'Moderno'
    ELSE 'Atual'
END AS era
FROM musica;

SELECT
nome,
CASE
	WHEN ativo = 1 THEN'Ativo'
    ELSE 'Inativo'
END AS status
FROM artista;

SELECT 
titulo,
CASE
	WHEN duracao_segundos < 180 THEN 'Curta'
    WHEN duracao_segundos <= 300 THEN 'Normal'
    ELSE 'Longa'
END AS tamanho
FROM musica;

SELECT 
nome,
CASE
	WHEN pais = 'Brasil' THEN 'Nacional'
    ELSE 'Internacional'
END AS origem
FROM artista;

-- Exibir o nome do artista e substituir o campo pais nulo por 'Pais desconhecido' usando IFNULL.
SELECT nome,
IFNULL(pais, 'Pais desconhecido') AS pais
FROM artista;

SELECT 
a.id,
IFNULL(a.nome, 'ARTISTA DESCONHECIDO') AS nome,
a.genero_musical,
a.pais,
a.ativo,
m.id,
m.titulo,
m.duracao_segundos,
m.ano_lancamento,
m.fk_artista
FROM musica AS m
LEFT JOIN artista AS a
ON m.fk_artista = a.id;

SELECT
m.titulo,
m.ano_lancamento,
a.nome
FROM musica AS m
JOIN artista AS a 
ON m.fk_artista = a.id;

SELECT
CONCAT(m.titulo, ' - ', a.nome , ' - ', m.ano_lancamento) AS catalago
FROM musica AS m
JOIN artista AS a 
ON m.fk_artista = a.id;

-- Fazer um RIGHT JOIN entre musica e artista para exibir todos os artistas, inclusive os que não possuem músicas cadastradas.
SELECT
*
FROM musica AS m
RIGHT JOIN artista AS a
ON m.fk_artista = a.id;

CREATE TABLE cliente (
	id INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(45),
    telefone VARCHAR(11),
    email VARCHAR(50)
);

CREATE TABLE veiculo (
	id INT PRIMARY KEY AUTO_INCREMENT,
    placa CHAR(8) UNIQUE,
    marca VARCHAR(40),
    modelo VARCHAR(40),
    ano INT,
    fk_cliente INT,
    CONSTRAINT fk_veiculo_cliente FOREIGN KEY (fk_cliente) REFERENCES cliente(id)
);

INSERT INTO cliente (nome, telefone, email) VALUES
('Carlos Eduardo', '11987654321', 'carlos@email.com'),
('Mariana Silva', '11976543210', NULL),
('Rafael Oliveira', '11965432109', 'rafael@email.com');

INSERT INTO veiculo (placa, marca, modelo, ano, fk_cliente) VALUES
('ABC1D23', 'Toyota', 'Corolla', 2022, 1),
('DEF4G56', 'Honda', 'Civic', 2021, 2),
('GHI7J89', 'Volkswagen', 'T-Cross', 2023, 3),
('JKL1M23', 'Chevrolet', 'Onix', 2020, 1),
('MNO4P56', 'Ford', 'Ka', 2019, NULL);

SELECT * FROM  cliente;
SELECT * FROM veiculo;

-- Exibir a placa, a marca e o modelo de todos os veículos.
SELECT 
placa,
marca,
modelo
FROM veiculo;

-- Exibir apenas os veículos da marca Fiat (ou a marca que você inseriu).
SELECT 
*
FROM veiculo
WHERE marca = 'Ford';

-- Exibir os veículos ordenados pelo ano em ordem decrescente.
SELECT 
*
FROM veiculo
ORDER BY ano DESC;

-- Exibir apenas os veículos com ano anterior a 2015.
SELECT
*
FROM veiculo
WHERE ano < 2015;

-- Exibir a placa do veículo como 'Placa do Veículo' e o modelo como 'Modelo do Carro'.
SELECT 
placa AS 'Placa do Veículo',
modelo AS 'Modelo do Carro'
FROM veiculo;

-- Exibir o nome do cliente como 'Proprietario' e o telefone como 'Contato'.
SELECT
nome AS Proprietario,
telefone AS Contato
FROM cliente;

-- Exibir o ano e calcular a idade do veículo (ano atual menos o ano do veículo) como 'Idade do Veículo'.
SELECT 
ano,
2026 - ano AS 'Idade do Veículo'
FROM veiculo;

-- Combinar a marca e o modelo em uma unica coluna chamada 'Veículo Completo'.
SELECT
CONCAT(marca, ', ' ,modelo) AS 'Veículo Completo'
FROM veiculo;

SELECT 
placa,
CASE
	WHEN ano >= 2020 THEN 'Novo'
    WHEN ano >= 2010 AND ano <= 2019 THEN 'Seminovo'
    ELSE 'Antigo'
END AS 'classificação'
FROM veiculo;

SELECT
modelo,
CASE
	WHEN marca = 'Chevrolet' OR marca = 'Volkswagen' THEN 'Nacional'
    ELSE 'Internacional'
END AS tipo_marca
FROM veiculo;

SELECT 
nome,
CASE
	WHEN email IS NULL THEN 'Não'
    ELSE 'Sim'
END AS possui_email
FROM cliente;

SELECT 
placa,
CASE
	WHEN ano >= 2000 AND ano <= 2009 THEN 'Anos 2000'
    WHEN ano >= 2010 AND ano <= 2019 THEN 'Anos 2010'
    ELSE 'Anos 2020'
END AS decada
FROM veiculo;

SELECT 
nome,
IFNULL(email, 'Email não cadastrado') AS email
FROM cliente;

SELECT 
v.id,
v.placa,
v.marca,
v.modelo,
v.ano,
v.fk_cliente,
c.id,
IFNULL(c.nome, 'SEM DONO') AS nome,
c.email,
c.telefone 
FROM veiculo AS v
LEFT JOIN cliente AS c 
ON v.fk_cliente = c.id;

-- Fazer um INNER JOIN entre veiculo e cliente para exibir a placa, o modelo e o nome do proprietario.
SELECT 
v.placa,
v.modelo,
c.nome 
FROM veiculo AS v	
JOIN cliente AS c
ON v.fk_cliente = c.id;

-- Fazer um INNER JOIN entre veiculo e cliente e combinar as colunas em uma unica coluna chamada 'registro', no formato "Placa - Modelo - Proprietario".
SELECT
CONCAT(v.placa, ' - ', v.modelo, ' - ', c.nome) AS registro
FROM veiculo AS v
JOIN cliente AS c 
ON c.id = v.fk_cliente;

-- Fazer um RIGHT JOIN entre veiculo e cliente para exibir todos os clientes, inclusive os que não possuem veículos cadastrados.
SELECT
*
FROM cliente AS c
RIGHT JOIN veiculo AS v
ON c.id = v.fk_cliente;

CREATE TABLE equipe (
	id INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(45),
    regiao VARCHAR(45),
    CONSTRAINT ch_regiao CHECK(regiao IN('Américas', 'Europa', 'Asia')),
    ranking INT
);

CREATE TABLE jogador_cs (
	id INT PRIMARY KEY AUTO_INCREMENT,
    nickname VARCHAR(45),
    nome_real VARCHAR(45),
    funcao VARCHAR(15),
    CONSTRAINT ch_funcao CHECK(funcao IN ('Rifler', 'AWPer', 'Entry', 'IGL', 'Suporte')),
	fk_equipe INT,
    CONSTRAINT fk_jogador_equipe FOREIGN KEY (fk_equipe) REFERENCES equipe(id)
);

INSERT INTO equipe (nome, regiao, ranking) VALUES
('FURIA', 'Americas', 12),
('Natus Vincere', 'Europa', NULL),
('T1', 'Asia', 18);

INSERT INTO jogador_cs (nickname, nome_real, funcao, fk_equipe) VALUES
('KSCERATO', 'Kaike Cerato', 'Rifler', 1),
('yuurih', 'Yuri Boian', 'Entry', 1),
('s1mple', 'Oleksandr Kostyliev', 'AWPer', 2),
('electroNic', 'Denis Sharipov', 'IGL', 2),
('ZywOo', 'Mathieu Herbaut', 'Rifler', 3),
('Fallen', 'Gabriel', 'Suporte', NULL);

SELECT * FROM equipe;
SELECT * FROM jogador_cs;

-- Exibir o nickname e a funcao de todos os jogadores.
SELECT
nickname,
funcao
FROM jogador_cs;

SELECT 
*
FROM jogador_cs
WHERE funcao = 'AWPer';

-- Exibir as equipes ordenadas pelo ranking em ordem crescente.
SELECT 
*
FROM equipe
ORDER BY ranking ASC;

-- Exibir os jogadores cujo nickname comeca com a letra 'F'.
SELECT
* 
FROM jogador_cs
WHERE nickname LIKE 'F%';

-- Exibir o nickname como 'Nick' e o nome_real como 'Nome Verdadeiro'.
SELECT 
nickname AS Nick,
nome_real AS 'Nome Verdadeiro'
FROM jogador_cs;

-- Exibir o nome da equipe como 'Time' e a regiao como 'Região Competitiva'.
SELECT 
nome AS 'Time',
regiao AS 'Região Competitiva'
FROM equipe;

-- Exibir o ranking da equipe como 'Posição no Ranking Mundial'.
SELECT 
ranking AS 'Posisão no Ranking Mundial'
FROM equipe;

-- Combinar o nickname e a funcao em uma unica coluna chamada 'Jogador e Função'.
SELECT
CONCAT(nickname, ' - ', funcao) AS 'Jogador e Função'
FROM jogador_cs;

SELECT nome,
CASE
	WHEN ranking <= 5 THEN 'Tier 1'
    WHEN ranking <= 20 THEN 'Tier 2'
    ELSE 'Tier 3'
END AS Nivel
FROM equipe;

SELECT 
nickname,
CASE
	WHEN funcao = 'Rifler' OR funcao = 'Entry' THEN 'Agressivo'
    WHEN funcao = 'AWPer' THEN 'Sniper'
    ELSE 'Tático'
END AS 'tipo_função'
FROM jogador_cs;

SELECT 
nome,
CASE
	WHEN regiao = 'Américas' THEN 'Ocidente'
    ELSE 'Oriente'
END AS continente
FROM equipe;

SELECT 
nickname,
CASE
	WHEN funcao = 'IGL' THEN 'Sim - In-Game Leader'
    ELSE 'Não'
END AS lider	
FROM jogador_cs;

-- Exibir o nome da equipe e substituir o campo ranking nulo por 'Sem ranking' usando IFNULL.
SELECT nome,
IFNULL(ranking, 'Sem ranking') AS ranking
FROM equipe;

SELECT 
j.id,
j.nickname,
j.nome_real,
j.funcao,
j.fk_equipe,
e.id,
IFNULL(e.nome, 'FREE AGENT') AS nome_equipe,
e.regiao,
e.ranking
FROM jogador_cs AS j
LEFT JOIN equipe AS e
ON j.fk_equipe = e.id;

-- Fazer um INNER JOIN entre jogador_cs e equipe para exibir o nickname, a função e o nome da equipe.
SELECT 
j.nickname,
j.funcao,
e.nome
FROM jogador_cs AS j
JOIN equipe AS e
ON j.fk_equipe = e.id;

-- Fazer um INNER JOIN entre jogador_cs e equipe e combinar as colunas em uma unica coluna chamada 'perfil', no formato "Nickname - Função - Equipe".
SELECT 
CONCAT(j.nickname, ' - ', j.funcao, ' - ' , e.nome) AS perfil
FROM jogador_cs AS j
JOIN equipe AS e
ON j.fk_equipe = e.id;

-- Fazer um RIGHT JOIN entre jogador_cs e equipe para exibir todas as equipes, inclusive as sem jogadores cadastrados.
SELECT
*
FROM equipe AS e
RIGHT JOIN jogador_cs AS j
ON e.id = j.fk_equipe;

CREATE TABLE marca (
	id INT PRIMARY KEY AUTO_INCREMENT,
    Nome VARCHAR(45),
    pais_origem VARCHAR(45)
);

CREATE TABLE tenis (
	id INT PRIMARY KEY AUTO_INCREMENT,
	modelo VARCHAR(45),
    tamanho INT,
    preco DECIMAL (10, 2),
    CONSTRAINT ch_preco_tenis CHECK(preco > 0),
    categoria VARCHAR(20),
    CONSTRAINT ch_categoria CHECK(categoria IN('Corrida', 'Casual', 'Basquete', 'Futebol')),
    fk_marca INT,
    CONSTRAINT ch_tenis_marca FOREIGN KEY (fk_marca) REFERENCES marca(id)
);

INSERT INTO marca (nome, pais_origem) VALUES
('Nike', 'Estados Unidos'),
('Adidas', 'Alemanha'),
('Mizuno', NULL);

INSERT INTO tenis (modelo, tamanho, preco, categoria, fk_marca) VALUES
('Air Max 90', 40, 699.90, 'Corrida', 1),
('Ultraboost 22', 42, 899.90, 'Corrida', 2),
('Court Vision', 41, 499.90, 'Casual', 1),
('Wave Rider 27', 43, 799.90, 'Corrida', 3),
('Tênis Esportivo', 40, 599.90, 'Futebol', NULL);

SELECT
modelo, 
preco
FROM tenis;

-- Exibir apenas os tênis da categoria Corrida.
SELECT 
*
FROM tenis
WHERE categoria = 'Corrida';

-- Exibir os tênis ordenados pelo preco em ordem decrescente.
SELECT 
* 
FROM tenis
ORDER BY preco DESC;

-- Exibir apenas os tênis com tamanho maior ou igual a 40.
SELECT 
*
FROM tenis
WHERE tamanho >= 40;

-- Exibir o modelo do tênis como 'Produto' e o preco como 'Valor (R$)'.
SELECT
modelo AS Produto,
preco AS 'Valor (R$)'
FROM tenis;

-- Exibir o nome da marca como 'Fabricante' e o pais_origem como 'Pais'.
SELECT 
nome AS Fabricante,
pais_origem AS Pais
FROM marca;

-- Exibir o preco acrescido de 15% como 'Preço com Frete'.
SELECT
preco * 1.15 AS 'Preço com frete' 
FROM tenis;

-- Combinar o modelo e o tamanho em uma unica coluna chamada 'Descrição do Produto'.
SELECT 
CONCAT(modelo, ' - ', tamanho) AS 'Descrição do Produto'
FROM tenis;

SELECT 
modelo,
CASE
	WHEN preco < 200 THEN  'Economico'
    WHEN preco <= 500 THEN 'Intermediario'
    ELSE 'Premium'
END AS faixa_preco
FROM tenis;

SELECT
modelo,
CASE
	WHEN categoria = 'Corrida' THEN 'Esporte - Performance'
    WHEN categoria = 'Casual' THEN 'Dia a dia'
    ELSE 'Esporte - Especifico'
END AS uso
FROM tenis;

SELECT
nome,
CASE
	WHEN pais_origem = 'Brasil' THEN 'Nacional'
    ELSE 'Importada'
END AS origem
FROM marca;

SELECT 
modelo,
CASE
	WHEN tamanho < 38 THEN 'Pequeno'
    WHEN tamanho <= 42 THEN 'Médio'
    ELSE 'Grande'
END AS 'numeração'
FROM tenis;

SELECT
nome,
IFNULL(pais_origem, 'Origem desconhecida') AS pais	
FROM marca;

SELECT 
m.id,
IFNULL(m.nome, 'MARCA GENERICA') AS nome_marca,
m.pais_origem,
t.id,
t.modelo,
t.tamanho,
t.preco,
t.categoria,
t.fk_marca
FROM tenis AS t
LEFT JOIN marca AS m
ON t.fk_marca = m.id;

-- Fazer um INNER JOIN entre tenis e marca para exibir o modelo do tênis, o preço e o nome da marca.
SELECT 
t.modelo,
t.preco,
m.nome
FROM tenis AS t
JOIN marca AS m
ON t.fk_marca = m.id;

-- Fazer um INNER JOIN entre tenis e marca e combinar as colunas em uma unica coluna chamada 'vitrine', 
-- no formato "Modelo - Categoria - Marca".
SELECT
CONCAT(t.modelo, ' - ', t.categoria, ' - ', m.nome) AS vitrine
FROM tenis AS t
JOIN marca AS m
ON t.fk_marca = m.id;

-- Fazer um RIGHT JOIN entre tenis e marca para exibir todas as marcas, inclusive as que não possuem tênis cadastrados.
SELECT
*
FROM marca AS m
RIGHT JOIN tenis AS t
ON m.id = t.fk_marca;

CREATE TABLE atleta (
	idAtleta INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(45),
    modalidade VARCHAR(45),
    qtdMedalha INT
);

CREATE TABLE pais (
	idPais INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(45),
    capital VARCHAR(45)
);

INSERT INTO atleta (nome, modalidade, qtdMedalha) VALUES
('Carlos Silva', 'Natação', 5),
('Mariana Souza', 'Natação', 3),
('João Oliveira', 'Atletismo', 7),
('Lucas Santos', 'Atletismo', 2),
('Beatriz Costa', 'Ginástica', 4),
('Ana Lima', 'Ginástica', 6);

INSERT INTO pais (nome, capital) VALUES
('Brasil', 'Brasília'),
('Estados Unidos', 'Washington, D.C.'),
('França', 'Paris'),
('Japão', 'Tóquio');

/* 1 pais tem 1 ou muitos atletas.
1 atleta e de 1 e somente 1 pais.
Escreva e execute os comandos para:

Criar a chave estrangeira na tabela correspondente, conforme a modelagem.
Atualizar o pais de todos os atletas. */
ALTER TABLE atleta ADD COLUMN fk_pais INT, ADD
CONSTRAINT fk_atleta_pais FOREIGN KEY (fk_pais) REFERENCES pais(idPais);

UPDATE atleta
SET fk_pais = 1
WHERE idAtleta IN (1, 2);

UPDATE atleta
SET fk_pais = 2
WHERE idAtleta IN (3, 4);

UPDATE atleta
SET fk_pais = 3
WHERE idAtleta = 5;

UPDATE atleta
SET fk_pais = 4
WHERE idAtleta = 6;

-- Exibir os atletas e seu respectivo pais.
SELECT *
FROM atleta AS a
JOIN pais AS p
ON p.idPais = a.fk_pais;

-- Exibir apenas o nome do atleta e o nome do respectivo pais.
SELECT
a.nome,
p.nome
FROM atleta AS a
JOIN pais AS p
ON p.idPais = a.fk_pais;

-- Exibir os dados dos atletas e seus respectivos paises, filtrando por uma determinada capital.
SELECT *
FROM atleta AS a
JOIN pais AS p
ON p.idPais = a.fk_pais
WHERE capital = 'Paris';

CREATE TABLE Musica (
	idMusica INT PRIMARY KEY AUTO_INCREMENT,
    titulo VARCHAR(45),
    artista VARCHAR(45),
    genero VARCHAR(45)
);

CREATE TABLE Album (
	idAlbum INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(45),
    tipo VARCHAR(10),
    CONSTRAINT ch_tipo_album CHECK (tipo IN('fisico', 'digital')),
    dtLancamento DATE
);

INSERT INTO Musica (titulo, artista, genero) VALUES
('7 rings', 'Ariana Grande', 'Pop'),
('thank u, next', 'Ariana Grande', 'Pop'),
('EARFQUAKE', 'Tyler, The Creator', 'Hip Hop'),
('See You Again', 'Tyler, The Creator', 'Hip Hop');

INSERT INTO Album (nome, tipo, dtLancamento) VALUES
('thank u, next', 'digital', '2019-02-08'),
('IGOR', 'fisico', '2019-05-17');

-- Exibir todos os dados das tabelas separadamente.
SELECT * FROM Musica;
SELECT * FROM Album;

ALTER TABLE Musica
ADD COLUMN fk_album INT,
ADD CONSTRAINT fk_album_musica
FOREIGN KEY (fk_album) REFERENCES Album(idAlbum);

UPDATE Musica
SET fk_album = 0
WHERE idMusica IN (1, 2);

UPDATE Musica
SET fk_album = 2
WHERE idMusica IN (3, 4);

SELECT 
m.*,
a.*
FROM Musica AS m
JOIN Album AS a
ON m.fk_album = a.idAlbum;
    
SELECT 
m.titulo,
a.nome
FROM Musica AS m
JOIN Album AS a
ON m.fk_album = a.idAlbum;
    
SELECT 
m.*,
a.*
FROM Musica AS m
JOIN Album AS a
ON m.fk_album = a.idAlbum
WHERE a.tipo = 'digital';