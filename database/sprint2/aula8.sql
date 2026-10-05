USE sprint2;

CREATE TABLE casa (
	id INT PRIMARY KEY AUTO_INCREMENT,
    logradouro VARCHAR(45),
    cep CHAR(8),
    numero INT
);

CREATE TABLE comodo (
	id INT AUTO_INCREMENT,
    nome VARCHAR(45),
    m2 DECIMAL (10,2),
    fk_casa INT,
    PRIMARY KEY(id, fk_casa),
    CONSTRAINT fk_casa_comodo FOREIGN KEY (fk_casa) REFERENCES casa(id)
);

INSERT INTO casa (logradouro, cep, numero) VALUES
('Avenida', '00000001', 595),
('Paulista', '21000001', 301);

SELECT * FROM casa;

INSERT INTO comodo (nome, m2, fk_casa) VALUES
('Banheiro', 5.2, 1),
('Banheiro', 2.5, 1),
('Quarto', 20, 1),
('Cozinha', 10, 1),
('Sala', 6.3, 1);

SELECT
id,
fk_casa,
nome,
m2
FROM comodo;

-- LISTANDO OS COMODOS DA CASA DO MURILO
SELECT DISTINCT
fk_casa,
nome
FROM comodo
WHERE fk_casa = 1;

INSERT INTO comodo (id, nome, m2, fk_casa) VALUES
(1, 'Banheiro', 5.2, 2);

-- Retorna de forma distinta sem repetir
SELECT DISTINCT
nome
FROM comodo;

-- Usamos limit para não retorna uma req possivel de crash
SELECT
id,
fk_casa,
nome,
m2
FROM comodo
ORDER BY m2 DESC
LIMIT 3;

UPDATE comodo 
SET m2 = 12.00 
WHERE fk_casa = 1 AND id = 3;
