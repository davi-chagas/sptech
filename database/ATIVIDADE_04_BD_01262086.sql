use sprint1;

CREATE TABLE aluguel (
	id INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(45),
    sobrenome VARCHAR(45),
    valor_total DECIMAL(5, 2), -- 000.00
    status VARCHAR(12)
);

TRUNCATE aluguel;

INSERT INTO aluguel (nome, sobrenome, valor_total, status) VALUES 
('Davi', 'Chagas', 505, 'finalizado'),
('Ana Carollini', 'Rossi', 950, 'finalizado'),
('Ramon', 'Coelho', 500, 'em_andamento'),
('Luis', 'Favariz', 400, 'em_andamento'),
('Vitoria', 'Lucena', 150, 'qlqr_coisa');

SELECT 
CONCAT(nome , ' ' , sobrenome) AS cliente,
valor_total as 'valor total',
CASE
	WHEN status = 'finalizado' THEN  'Concluido'
	WHEN status = 'em_andamento' THEN  'Em andamento'
	WHEN status != 'finalizando' OR status != 'em_andamento' THEN 'Cancelado'
    END AS situacao
FROM aluguel ORDER BY nome;