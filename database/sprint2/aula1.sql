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


