USE sprint2;

CREATE TABLE people (
	id INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(45),
    localNasc VARCHAR(45),
    cpf CHAR(11),
    dataNasc DATE,
    fk_mae INT,
    fk_pai INT,
    CONSTRAINT fk_mae_pessoa FOREIGN KEY (fk_mae) REFERENCES people(id),
    CONSTRAINT fk_pai_pessoa FOREIGN KEY (fk_pai) REFERENCES people(id)
);

-- INSERIR AS PRIMEIRAS PESSOAS
INSERT INTO people (nome, localNasc, dataNasc, cpf) VALUES
('Vivian', 'Rio de Janeiro', '1987-04-23', '12345678910'),
('Walfredo', 'Ceará', '1977-11-05', '09876543210');

SELECT * FROM people;

-- INSERIR O RESTANTE DAS PESSOAS 
INSERT INTO people (nome, localNasc, dataNasc, cpf, fk_mae, fk_pai) VALUES
('Davi', 'Santo andré', '2005-07-18', '10102367315', 1, 2),
('Ana Carollini', 'São Bernardo do Campo', '2007-11-03', '09176543719', NULL, NULL),
('Vitoria', 'São Paulo', '2007-01-15', '12176343715', NULL, NULL),
('Gustavo Weslley', 'São Paulo', '2006-09-28', '75166343715', NULL, NULL);

-- O ON tem comportamento de WHERE dentro do JOIN
-- Estou selecionando os filhos que possuem uma mae
SELECT 
*
FROM people AS filho
JOIN people AS  mae
ON filho.fk_mae = mae.id;

UPDATE people SET fk_mae = 2 WHERE id = 4;

SELECT 
mae.nome NOME_MAE,
filho.nome NOME_FILHO,
filho.localNasc LOCAL_NASCIMENTO
FROM people AS filho
JOIN people AS  mae
ON filho.fk_mae = mae.id;

-- FILHOS QUE POSSUEM MÃE
SELECT 
*
FROM people AS filho
LEFT JOIN people AS  mae
ON filho.fk_mae = mae.id;

-- MAES QUE POSSUEM FILHO
SELECT 
*
FROM people AS filho
RIGHT JOIN people AS  mae
ON filho.fk_mae = mae.id;	

-- RELACIONAR PAI, MAE, FILHO DO QUAL POSSUEM MÃE E PAI NÃO NECESSARIAMENTE UM PAI
SELECT 
pai.nome AS NOME_PAI,
mae.nome AS NOME_MAE,
filho.nome AS NOME_FILHO
FROM people AS filho
JOIN people AS  mae
ON filho.fk_mae = mae.id
LEFT JOIN people AS pai
ON filho.fk_pai = pai.id;

-- TODOS OS FILHOS
SELECT 
pai.nome AS NOME_PAI,
mae.nome AS NOME_MAE,
filho.nome AS NOME_FILHO
FROM people AS filho
LEFT JOIN people AS  mae
ON filho.fk_mae = mae.id
LEFT JOIN people AS pai
ON filho.fk_pai = pai.id;

SELECT
* 
FROM people;

UPDATE people 
SET fk_mae = 5, 
fk_pai = 6 
WHERE id = 1;

SELECT
avo.nome NOME_AVO,
mae.nome NOME_MAE,
filho.nome NOME_FILHO
FROM people AS filho
	JOIN people AS mae
ON filho.fk_mae = mae.id
	JOIN  people AS avo
ON mae.fk_mae = avo.id