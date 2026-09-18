-- entidade forte
ALTER TABLE sprint2.loja
	ADD COLUMN cnpj CHAR(14) NOT NULL UNIQUE,
	ADD COLUMN segmento VARCHAR(45),
	ADD COLUMN nome VARCHAR(50);
    
-- FOREIGN KEY 
-- entidade fraca
CREATE TABLE sprint2.produto(
	id INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(50), 
    preco DECIMAL (4, 2),
    tipo VARCHAR(20),
    cog_produto CHAR(8) UNIQUE,
    data_validade DATE,
    data_fabricacao DATETIME,
    fk_loja INT,
    CONSTRAINT chFkLoja FOREIGN KEY (fk_loja) REFERENCES sprint2.loja(id)
);

DESC loja;
DESC produto;

INSERT INTO sprint2.loja (nome, cnpj, segmento) VALUES 
('Americanas', '321.264.1000/5', 'Varejo');

SELECT* FROM sprint2.loja;

-- ERRO DE ID INEXISTENTE
-- Error Code: 1452. Cannot add or update a child row: 
-- a foreign key constraint fails (`sprint2`.`produto`, CONSTRAINT `chFkLoja` FOREIGN KEY (`fk_loja`) REFERENCES `loja` (`id`))
INSERT INTO sprint2.produto VALUES 
(DEFAULT, 'Bis X', 5.50, 'doce' ,'12345678', '2026-10-05', NOW(), 1);

SELECT * FROM produto;

SELECT * FROM sprint2.produto 
JOIN sprint2.loja;

INSERT INTO sprint2.produto VALUES 
(DEFAULT, 'Monster', 14.90, 'Energético' ,'22385678', '2026-02-05', NOW(), 1),
(DEFAULT, 'Negresco', 3.55, 'bolacha' ,'52345678', '2026-11-14', NOW(), 1),
(DEFAULT, 'Miojo - turma da monica', 3.00, 'macarrão' ,'02345678', '2030-04-05', NOW(), 1);

INSERT INTO sprint2.loja (nome, cnpj, segmento) VALUES 
('Pernambucanas', '356.785.0001/1', 'Varejo');

-- join correto
SELECT * FROM produto 
JOIN loja
ON loja.id = produto.fk_loja;

-- todos os produtos e todas as lojas
SELECT * FROM produto 
RIGHT JOIN loja ON loja.id = produto.fk_loja;

-- criando apelidos para as tabelas
SELECT * FROM produto AS p
JOIN loja as l On l.id = p.fk_loja;

SELECT 
CONCAT(p.nome, ' - ',l.nome ) AS produto_loja
FROM produto AS p
JOIN loja AS l ON l.id = p.fk_loja;

UPDATE produto 
SET fk_loja = null
where id = 6;

SELECT 
CONCAT(p.nome, ' - ', IFNULL(l.nome, 'SEM LOJA') ) AS produto_loja
FROM produto AS p
LEFT JOIN loja AS l ON l.id = p.fk_loja;