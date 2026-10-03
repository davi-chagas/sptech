CREATE DATABASE cafeteria;

USE cafeteria;

CREATE TABLE cliente (
    id INT NOT NULL AUTO_INCREMENT,
    nome VARCHAR(45),
    email VARCHAR(45),
    telefone CHAR(11),
    PRIMARY KEY (id)
);

CREATE TABLE categoria (
    id INT NOT NULL AUTO_INCREMENT,
    descricao VARCHAR(45),
    PRIMARY KEY (id)
);

CREATE TABLE produtos (
    id INT NOT NULL AUTO_INCREMENT,
    nome VARCHAR(45),
    preco DECIMAL(10,2),
    estoque INT,
    fk_categoria INT NOT NULL,
    PRIMARY KEY (id),

    CONSTRAINT fk_produtos_categoria
        FOREIGN KEY (fk_categoria)
        REFERENCES categoria(id)
);

CREATE TABLE pedidos (
    id INT NOT NULL AUTO_INCREMENT,
    qtd_produtos INT,
    dt_pedido DATE,
    fk_cliente INT NOT NULL,
    fk_produto INT NOT NULL,
    PRIMARY KEY (id),

    CONSTRAINT fk_pedidos_cliente
        FOREIGN KEY (fk_cliente)
        REFERENCES cliente(id),

    CONSTRAINT fk_pedidos_produto
        FOREIGN KEY (fk_produto)
        REFERENCES produtos(id)
);


INSERT INTO cliente (nome, email, telefone) VALUES
('Ana Souza', 'ana.souza@email.com', '11987654321'),
('Bruno Oliveira', 'bruno.oliveira@email.com', '11976543210'),
('Carla Santos', 'carla.santos@email.com', '11965432109'),
('Daniel Lima', 'daniel.lima@email.com', '11954321098'),
('Eduarda Costa', 'eduarda.costa@email.com', '11943210987'),
('Felipe Almeida', 'felipe.almeida@email.com', '11932109876'),
('Gabriela Rocha', 'gabriela.rocha@email.com', '11921098765'),
('Henrique Martins', 'henrique.martins@email.com', '11910987654');


INSERT INTO categoria (descricao) VALUES
('Café'),
('Salgado'),
('Doce'),
('Bebida');


INSERT INTO produtos (nome, preco, estoque, fk_categoria) VALUES
('Café Espresso', 6.50, 100, 1),
('Cappuccino', 9.00, 80, 1),
('Café Latte', 10.00, 70, 1),
('Mocha', 11.50, 60, 1),
('Pão de Queijo', 5.00, 120, 2),
('Croissant', 8.50, 50, 2),
('Bolo de Chocolate', 9.00, 40, 3),
('Cheesecake', 12.00, 30, 3),
('Brownie', 8.00, 45, 3),
('Chá Gelado', 7.00, 65, 4);


INSERT INTO pedidos
    (qtd_produtos, dt_pedido, fk_cliente, fk_produto)
VALUES
(2, '2026-09-01', 1, 1),
(1, '2026-09-01', 2, 2),
(3, '2026-09-02', 3, 5),
(1, '2026-09-02', 1, 7),
(2, '2026-09-03', 4, 3),
(1, '2026-09-03', 5, 8),
(2, '2026-09-04', 2, 1),
(1, '2026-09-04', 6, 6),
(3, '2026-09-05', 7, 9),
(1, '2026-09-05', 8, 4),
(2, '2026-09-06', 3, 2),
(1, '2026-09-06', 4, 10),
(2, '2026-09-07', 5, 5),
(1, '2026-09-07', 1, 3),
(2, '2026-09-08', 6, 7),
(1, '2026-09-08', 7, 1),
(3, '2026-09-09', 8, 2),
(1, '2026-09-09', 2, 9),
(2, '2026-09-10', 3, 6),
(1, '2026-09-10', 5, 8);

SELECT * FROM pedidos;

-- faturamento do produto por dia em uma semana
SELECT 
p.id,
p.nome,
CONCAT('R$', p.preco * pedido.qtd_produtos )
AS faturamento_produto_semanal,
pedido.dt_pedido
FROM produtos AS p
JOIN pedidos AS pedido
ON pedido.fk_produto = p.id
WHERE dt_pedido BETWEEN '2026-09-01' AND '2026-09-08';

-- quantidade de pedidos de cada produto por dia
SELECT 
p.id,
p.nome,
pedido.qtd_produtos,
pedido.dt_pedido
FROM produtos AS p
JOIN pedidos AS pedido
ON pedido.fk_produto = p.id
WHERE dt_pedido BETWEEN '2026-09-01' AND '2026-09-08';

