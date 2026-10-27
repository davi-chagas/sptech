CREATE DATABASE jurassicPark;
USE jurassicPark;

CREATE TABLE dinossauro (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(50),
    tipo VARCHAR(10),
    CONSTRAINT chk_tipo CHECK (tipo IN ('Marinho', 'Terrestre', 'aereo')),
    peso DECIMAL(6,2),
    altura FLOAT,
    carnivoro CHAR(3),
    CONSTRAINT chk_carnivoro CHECK (carnivoro IN ('sim', 'não')),
    ano_descoberta INT
);

CREATE TABLE parque (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    localizacao VARCHAR(100),
    capacidade_maxima INT,
    data_abertura DATE
);

CREATE TABLE jaula (
    id_jaula INT PRIMARY KEY AUTO_INCREMENT,
    localizacao VARCHAR(45),
    fk_parque INT,
    CONSTRAINT fk_parque_jaula FOREIGN KEY (fk_parque) REFERENCES parque(id)
);

ALTER TABLE dinossauro
ADD fk_jaula INT,
ADD CONSTRAINT fk_jaula_dinossauro
FOREIGN KEY (fk_jaula) REFERENCES jaula(id_jaula);

INSERT INTO dinossauro (nome, tipo, peso, altura, carnivoro, ano_descoberta) VALUES
('Rex', 'Terrestre', 8000.00, 4.2, 'sim', 1902),
('Blue', 'Terrestre', 150.00, 1.8, 'sim', 1924),
('Mosa', 'Marinho', 1400.00, 10.5, 'sim', 1829),
('Trike', 'Terrestre', 6000.00, 3, 'não', 1889),
('Ptera', 'aereo', 25.00, 1.2, 'não', 1784);

ALTER TABLE dinossauro
ADD predador INT,
ADD CONSTRAINT fk_predador FOREIGN KEY (predador) REFERENCES dinossauro(id);

SELECT * FROM dinossauro;

SELECT tipo, carnivoro FROM dinossauro;

SELECT nome FROM dinossauro;

SELECT nome, tipo FROM dinossauro;

UPDATE dinossauro
SET predador = 1
WHERE id = 2;

INSERT INTO parque (nome, localizacao, capacidade_maxima, data_abertura) VALUES
('Jurassic Park Nublar', 'Ilha Nublar', 5000, '1993-06-11'),
('Jurassic World', 'Ilha Nublar', 20000, '2015-06-12'),
('Site B', 'Ilha Sorna', 3000, '1997-05-23');

INSERT INTO jaula (localizacao, fk_parque) VALUES
('Jaula Norte', 1),
('Jaula Sul', 1),
('Jaula Aquática', 2),
('Jaula Aérea', 3);

SELECT * FROM dinossauro WHERE nome = 'Rex';

SELECT d.nome
FROM dinossauro AS d
JOIN dinossauro AS p ON d.predador = p.id;

UPDATE jaula
SET fk_parque = 1
WHERE id_jaula = 1;

SELECT * FROM dinossauro WHERE peso > 1000.00;

UPDATE jaula
SET fk_parque = 2
WHERE id_jaula = 4;

SELECT * FROM dinossauro WHERE nome = 'Rex';

SELECT d.nome AS DINOSSAURO, p.nome AS PREDADOR
FROM dinossauro AS d
JOIN dinossauro AS p ON d.predador = p.id;

SELECT * FROM dinossauro ORDER BY peso ASC;

SELECT * FROM dinossauro
WHERE tipo = 'Marinho' OR tipo = 'Terrestre';

SELECT * FROM dinossauro WHERE carnivoro = 'sim';

ALTER TABLE dinossauro ADD COLUMN especie VARCHAR(50);

ALTER TABLE dinossauro ADD COLUMN cor VARCHAR(30);

ALTER TABLE jaula ADD COLUMN capacidade INT;

INSERT INTO jaula (localizacao, capacidade) VALUES
('Jaula Oeste', 6),
('Jaula Leste', 2);

ALTER TABLE dinossauro MODIFY nome VARCHAR(50) NOT NULL;

UPDATE dinossauro
SET carnivoro = 'sim'
WHERE id = 1;

UPDATE dinossauro
SET especie = 'Tyrannosaurus Rex'
WHERE id = 1;

UPDATE dinossauro
SET nome = 'Rex'
WHERE id = 2;

INSERT INTO dinossauro
(nome, tipo, peso, altura, carnivoro, ano_descoberta, fk_jaula, predador, especie, cor)
VALUES
('Blue 2', 'Terrestre', 150.00, 1.8, 'sim', 1924, 1, NULL, 'Velociraptor', 'Azul'),
('Mosa 2', 'Marinho', 1400.00, 10.5, 'sim', 1829, 4, NULL, 'Mosasaurus', 'Cinza'),
('Trike 2', 'Terrestre', 6000.00, 3, 'não', 1889, 3, NULL, 'Triceratops', 'Verde');

INSERT INTO jaula (localizacao, capacidade)
VALUES ('Jaula Perigosa', 5);

INSERT INTO dinossauro
(nome, tipo, peso, altura, carnivoro, ano_descoberta, fk_jaula, predador, especie, cor)
VALUES
('Indominus Rex', 'Terrestre', 8000.00, 4.2, 'sim', 1902, NULL, NULL, 'Indominus Rex', 'Branco');

SELECT d.nome, j.localizacao
FROM dinossauro AS d
JOIN jaula AS j ON d.fk_jaula = j.id_jaula
WHERE j.id_jaula = 2;

SELECT d.nome, j.localizacao
FROM dinossauro AS d
JOIN jaula AS j ON d.fk_jaula = j.id_jaula;

SELECT d.nome AS DINOSSAURO, p.nome AS PREDADOR
FROM dinossauro AS d
LEFT JOIN dinossauro AS p ON d.predador = p.id
WHERE p.nome = 'Rex';

SELECT d.nome AS dinossauro, j.localizacao AS jaula
FROM dinossauro AS d
JOIN jaula AS j ON d.fk_jaula = j.id_jaula;

SELECT d.nome, j.localizacao
FROM dinossauro AS d
JOIN jaula AS j ON d.fk_jaula = j.id_jaula;

INSERT INTO dinossauro
(nome, tipo, peso, altura, carnivoro, ano_descoberta, fk_jaula, predador, especie, cor)
VALUES
('Ptera 2', 'aereo', 25.00, 1.2, 'não', 1784, 1, NULL, 'Pteranodon', 'Marrom');

SELECT d.nome, j.localizacao, j.capacidade
FROM dinossauro AS d
LEFT JOIN jaula AS j ON d.fk_jaula = j.id_jaula
WHERE j.capacidade < 3;

SELECT
    d.nome AS DINOSSAURO,
    p.nome AS PARQUE,
    j.localizacao AS JAULA
FROM dinossauro AS d
LEFT JOIN jaula AS j ON d.fk_jaula = j.id_jaula
LEFT JOIN parque AS p ON j.fk_parque = p.id;