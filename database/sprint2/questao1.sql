CREATE TABLE area (
	id INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100) 
);

CREATE TABLE funcionario(
id INT PRIMARY KEY AUTO_INCREMENT,
 nome VARCHAR(100),
 area_id INT,
 CONSTRAINT fk_area_id FOREIGN KEY (area_id) REFERENCES area(id), 
 supervisor_id INT, CONSTRAINT fk_supervisor_id FOREIGN KEY (supervisor_id) REFERENCES funcionario(id)
 );
 

INSERT INTO area (nome) VALUES
('Marketing'),
('Financeiro'), 
('TI');

 INSERT INTO funcionario (nome, area_id,supervisor_id) VALUES
 ('Carla', 3, 1),
 ('Diego', 3, 1),
 ('Lia', 3, 1),
 ('Ana', 1, 1),
 ('Bruno', 1, 4),
 ('Paulo', 2, 1),
 ('Rita', 2, 6);
 
 SELECT * FROM fu	ncionario;
 
 SELECT
 f.nome NOME_FUNCIONARIO,
 a.nome NOME_AREA,
 s.nome NOME_SUPERVISOR
 FROM funcionario AS f
 JOIN area AS a
 ON f.area_id = a.id
 JOIN funcionario AS s
 ON f.supervisor_id = s.id;
 
 SELECT
f.nome AS NOME_FUNCIONARIO,
a.nome AS NOME_AREA,
CASE
WHEN s.id = f.id THEN 'Chefia'
ELSE 'Equipe'
END AS papel
FROM funcionario AS f
JOIN area AS a
ON f.area_id = a.id
LEFT JOIN funcionario AS s
ON s.supervisor_id = f.id;
    
    SELECT * FROM funcionario;
 
 CREATE TABLE usuario(
	id INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100),
    gerente_id INT,
    CONSTRAINT fk_gerente_usuario FOREIGN KEY (gerente_id) REFERENCES usuario(id)
 );
 
 CREATE TABLE email (
	id INT PRIMARY KEY AUTO_INCREMENT,
    usuario_id INT,
    CONSTRAINT fk_usuario_email FOREIGN KEY (usuario_id) REFERENCES usuario_2(id),
	endereco VARCHAR(150),
    tipo VARCHAR(50)
 );
 
 INSERT INTO usuario (nome, gerente_id) VALUES
 ('Helena', 1),
 ('Ana', 1),
 ('Bruno', 1),
 ('Caio', 2),
 ('Duda', 2),
 ('Eva', 3);
 
 INSERT INTO email (usuario_id, endereco, tipo) VALUES
 (1, 'helena@gmail.com', 'pessoal'),
 (1, 'helena@sptech.com', 'corporativo'),
 (2, 'ana@gmail.com', 'pessoal'),
 (2, 'ana@sptech.com', 'corporativo'),
 (3, 'bruno@sptech.com', 'corporativo'),
 (4, 'caio@sptech.com', 'corporativo'),
 (5, 'duda@gmail.com', 'pessoal'),
 (5, 'duda@sptech.com', 'corporativo'),
 (6, 'eva@sptech.com', 'corporativo');
 
 SELECT * FROM email;
 
SELECT 
u.nome AS NOME_USUARIO,
g.nome AS NOME_GERENTE,
CASE
	WHEN g.id = u.id THEN 'Topo'
	ELSE 'Equipe'
END AS nivel,
CASE
	WHEN e2.usuario_id IS NOT NULL THEN 'Multiplos Emails'
        ELSE 'Email Único'
    END AS perfil_emails
FROM usuario_2 AS u
JOIN usuario_2 AS g
ON u.gerente_id = g.id
JOIN email AS e
ON e.usuario_id = u.id
LEFT JOIN email AS e2
ON e2.usuario_id = u.id
AND e2.id <> e.id;
 
 Error Code: 1054. Unknown column 'u.gerente_id' in 'where clause'

 
 
 
 