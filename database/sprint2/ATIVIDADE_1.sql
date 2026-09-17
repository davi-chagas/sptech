USE liga_pokemon;

-- criando tabela
CREATE TABLE treinador (
	id INT PRIMARY KEY AUTO_INCREMENT,
	nome VARCHAR(60) NOT NULL,
    idade TINYINT,
    telefone VARCHAR(20), 
    data_cadastro DATETIME
);

-- Alterar a tabela treinador para que o AUTO_INCREMENT comece a partir do número 100.
ALTER TABLE treinador AUTO_INCREMENT = 100;

INSERT INTO treinador (nome, idade, telefone, data_cadastro) VALUES
('Ash Ketchum', 12, '11956482366', NOW()),
('Misty', 12, NULL , NOW()),
('Brock', 15, '11925626366', NOW()),
('Lance', 60, NULL, NOW()),
('Serena', 14, '11923487512', NOW());

-- Exibir todos os dados da tabela treinador.
SELECT * FROM treinador;

-- Exibir o nome e a data_cadastro formatada no padrão DD/MM/AAAA usando DATE_FORMAT() com o alias data_cadastro.
SELECT nome,
DATE_FORMAT(data_cadastro, '%d/%m/%y') AS data_cadastro
FROM treinador;

-- Criar uma consulta que exiba: nome, o ano atual (usando YEAR(NOW())),
-- o ano do cadastro (YEAR(data_cadastro)), o mês (MONTH(data_cadastro)) e o dia (DAY(data_cadastro)) de cada treinador.
SELECT nome,
YEAR(NOW()) AS ano_atual,
YEAR(data_cadastro) AS ano_cadastro,	
MONTH(data_cadastro) AS mes_cadastro,
DAY(data_cadastro) AS dia_cadastro
from treinador;

-- Usar CURDATE() para exibir a data atual do sistema (sem hora) ao lado do nome de cada treinador.
SELECT nome,
CURDATE() AS data_atual_sistema
FROM treinador;

-- Usar TIMESTAMPDIFF() para calcular, a partir da data de cadastro de cada treinador: a diferença em dias, em meses e em anos até uma data futura de sua escolha.
SELECT nome,
TIMESTAMPDIFF(YEAR, data_cadastro, '2032-03-03') AS diff_anos,
TIMESTAMPDIFF(MONTH, data_cadastro, '2026-12-22') AS diff_meses,
TIMESTAMPDIFF(DAY, data_cadastro, '2026-10-11') AS diff_dias
FROM treinador;

-- Usar DATEDIFF() para calcular a diferença em dias entre a data atual e uma data de nascimento (ex.: '2006-11-28').
SELECT
DATEDIFF(NOW(), '2005-07-18') AS diff_dias_nascimento;

-- Exibir apenas o nome dos treinadores cujo campo telefone é nulo (use IS NULL).
SELECT nome
FROM treinador
WHERE telefone IS NULL;

-- Exibir todos os dados dos treinadores cujo campo telefone não é nulo (use IS NOT NULL).
SELECT * FROM treinador
WHERE telefone IS NOT NULL;

-- Exibir o nome e o telefone de cada treinador, substituindo valores nulos por 'Telefone não informado' usando IFNULL().
SELECT nome,
IFNULL(telefone, 'Telefone não informado') AS telefone
FROM treinador
WHERE telefone IS NULL;

-- Exibir o nome e o resultado de ISNULL(telefone) como alias semTelefone — observe que retorna 1 para nulo e 0 para preenchido.
SELECT nome,
ISNULL(telefone) AS semTelefone
FROM treinador; 

-- Exibir o nome e o resultado de NULLIF(idade, 12) como alias idade_diferente_de_12 — observe que retorna NULL quando a idade for 12 e o valor normal caso contrário.
SELECT nome,
NULLIF(idade, 12) AS idade_diferente_de_12
FROM treinador;

-- Alterar a tabela treinador em uma única instrução para: adicionar a coluna cidade (VARCHAR(50)) e remover a coluna telefone. Separe as ações com vírgula.
ALTER TABLE treinador 
ADD COLUMN cidade VARCHAR(50),
DROP COLUMN telefone;
                    
DESC treinador;

-- Atualizar, em uma única instrução UPDATE, o nome para 'Ash', a idade para 13 e a cidade para 'Pallet' do treinador com id_treinador = 100. Valide com SELECT antes.
UPDATE treinador
SET nome = 'Ash',
idade = 13,
cidade = 'Pallet'
WHERE id = 100;

SELECT * FROM treinador;

-- Atualizar a cidade para 'Pallet' dos treinadores com id_treinador IN (101, 103). Valide com SELECT antes.
UPDATE treinador
SET cidade = 'Pallet'
WHERE id IN (101, 103);

-- Atualizar a cidade para 'São Paulo' de todos os treinadores onde o campo cidade é NULL (use WHERE cidade IS NULL). Valide com SELECT antes.
UPDATE treinador
SET cidade = 'São Paulo'
WHERE cidade IS NULL;

-- Exibir todos os treinadores com id_treinador BETWEEN 101 AND 103 OR id_treinador = 100 para verificar as atualizações.
SELECT id, nome
FROM treinador
WHERE id BETWEEN 101 AND 103 OR id = 100;

CREATE TABLE pokemon (
	id INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(45) NOT NULL,
    tipo VARCHAR(45) DEFAULT 'Água',
	nivel TINYINT,
    hp INT,
    atk INT	
);

INSERT INTO pokemon (nome, nivel, hp, atk) VALUES 
('Squirtle',  2, 30, 10),
('Greninja',  50, 120, 140),
('Lapras',  40, 90, 100);

SELECT * FROM pokemon;

INSERT INTO pokemon(nome, tipo, nivel, hp, atk) VALUES
('Pikachu', 'Elétrico', 100, 100, 70),
('Zapdos', 'Elétrico', 70, 500, 300),
('Alakazam', 'Psíquico', 25, 120, 70);

-- Exibir o nome e o resultado de hp + atk com alias 'poder_total'.
SELECT nome,
hp + atk AS poder_total
FROM pokemon;

-- Exibir o nome e o resultado de hp - atk com alias 'total'.
SELECT nome,
hp - atk AS total
FROM pokemon;

-- Exibir o nome, o dobro do hp (hp * 2 com alias 'dobra_da_vida'), o ataque reduzido à metade (atk / 2 com alias 'ataque_reduzido') e o atk original.
SELECT nome,
hp * 2 AS dobra_da_vida,
atk / 2 AS ataque_reduzido,
atk
FROM pokemon;

-- Alterar a tabela pokemon em uma única instrução para: adicionar a coluna tipo (VARCHAR(20)),
-- remover a coluna nivel e adicionar novamente a coluna nivel como INT. Separe cada ação com vírgula.
ALTER TABLE pokemon
MODIFY COLUMN tipo VARCHAR(20),
DROP COLUMN nivel,
ADD COLUMN nivel INT;

DESC pokemon;

-- 2. Livraria
USE sprint2;

CREATE TABLE autores (
	id_autor INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100) NOT NULL,
    nacionalidade VARCHAR(20),
	CONSTRAINT chNacionalidade CHECK (nacionalidade IN ('Brasileiro', 'Estrangeiro'))
);

CREATE TABLE livros (
	id_livro INT PRIMARY KEY AUTO_INCREMENT,
    titulo VARCHAR(150) NOT NULL UNIQUE,
    genero VARCHAR(50),
    ano_publicacao INT,
    fk_autor INT,
    CONSTRAINT chFkAutor FOREIGN KEY (fk_autor) REFERENCES autores(id_autor)
);

CREATE TABLE vendas (
	id_venda INT PRIMARY KEY AUTO_INCREMENT,
    data_venda DATE NOT NULL,
    quantidade INT DEFAULT 1,
    valor_total DECIMAL(10, 2)
    CONSTRAINT chValorTotal CHECK (valor_total > 0),
    fk_livro INT,
    CONSTRAINT chFkLivro FOREIGN KEY (fk_livro) REFERENCES livros(id_livro)
);

INSERT INTO autores (nome, nacionalidade) VALUES
('Eichiro Oda', 'Estrangeiro'),
('Akira Toriyama', 'Estrangeiro'),
('Monteiro Lobato', 'Brasileiro'),
('Mauricio de Souza', 'Brasileiro');

-- Inserir pelo menos 6 livros na tabela livros, associando cada livro a um autor existente via fk_autor.
INSERT INTO livros (titulo, genero, ano_publicacao, fk_autor) VALUES
('One Piece', 'Fantasia', 1998, 1),
('Hunter x Hunter', 'Fantasia', 1999, 1),
('Dragon Ball', 'Luta', 1984, 2),
('Naruto', 'Comédia', 2000, 2),
('Sitio do pica pau amarelo', 'Fantasia', 1990, 3),
('Turma da Monica', 'Comédia', 1960, 4);

-- Inserir pelo menos 5 vendas na tabela vendas, associando cada venda a um livro existente via fk_livro. Em algumas vendas, não informe a quantidade para testar o valor DEFAULT.
INSERT INTO vendas (data_venda, quantidade, valor_total, fk_livro) VALUES
('2005-12-06', 1000, 2500.50, 7),
('2024-05-03', 250, 550.32, 8),
('2000-01-22', 3700, 10500, 9),
('1979-02-05', 3000, 5500.50, 10),
('1995-12-02', 100, 250, 11);

-- Tentar inserir um autor com nacionalidade = 'Europeu' e observar o erro da restrição CHECK.
INSERT INTO autores (nome, nacionalidade) VALUES
('Rick Jordan', 'Europeu');

-- Tentar inserir uma venda com valor_total = -50.00 e observar o erro da restrição CHECK.
INSERT INTO vendas (data_venda	, valor_total) VALUES
('2005-07-18', -50.00);

-- Tentar inserir um livro com fk_autor de um autor que não existe e observar o erro da FOREIGN KEY.
INSERT INTO livros (titulo, genero, ano_publicacao, fk_autor) VALUES
('Bleach', 'Shounen', 2002, 403);

-- Atualizar o nome de um autor específico pelo seu id_autor.
UPDATE autores
SET nome = 'Oda Eichiro'
WHERE id_autor = 1;

-- Atualizar a nacionalidade de um autor específico pelo seu id_autor.
UPDATE autores
SET nacionalidade = 'Brasileiro'
WHERE id_autor = 1;

-- Atualizar o genero e o ano_publicacao de um livro em uma única instrução UPDATE.
UPDATE livros
SET genero = 'Shounen', ano_publicacao = 2002
WHERE id_livro = 7;

-- Atualizar o fk_autor (trocar o autor) de um livro específico.
UPDATE livros
SET fk_autor = 2
WHERE id_livro = 7;

-- Atualizar a quantidade de uma venda específica pelo id_venda.
UPDATE vendas 
SET quantidade = 200.00
WHERE id_venda = 6;

-- Atualizar o valor_total de duas vendas de uma vez usando WHERE id_venda IN (1, 3).
UPDATE vendas
SET valor_total = 1500.00
WHERE id_venda IN (8, 9);

-- Atualizar o genero de todos os livros de um determinado autor usando o fk_autor.
UPDATE livros
SET genero = 'Shounen'
WHERE fk_autor = 2;

SELECT * FROM livros;
SELECT * FROM autores;
SELECT * FROM vendas;

-- Atualizar a data_venda de todas as vendas cuja quantidade seja maior que 2.
UPDATE vendas
SET data_venda = NOW()
WHERE quantidade > 2;

-- Atualizar o valor_total para o dobro do valor atual de uma venda específica (use expressão aritmética no SET: SET valor_total = valor_total * 2).
UPDATE vendas
SET valor_total = valor_total * 2
WHERE id_venda = 6;

-- Perigo: Executar um UPDATE sem cláusula WHERE na tabela livros, alterando o genero de todos para 'Ficção'. Observe o efeito e discuta os riscos.
UPDATE livros
SET genero = 'Ficção';

-- Deletar uma venda específica pelo seu id_venda.
DELETE FROM vendas
WHERE id_venda = 6;

-- Deletar todas as vendas com quantidade = 1 (valor padrão).
DELETE FROM vendas
WHERE quantidade = 1;

-- Deletar todas as vendas com valor_total menor que R$ 50,00.
DELETE FROM vendas
WHERE valor_total < 50.00;

-- Deletar um livro específico pelo id_livro — lembre-se de deletar as vendas relacionadas primeiro.
DELETE FROM vendas
WHERE id_venda = 7;

DELETE FROM livros
WHERE id_livro = 7;

-- Tentar deletar um autor que ainda possui livros associados e observar o erro de FOREIGN KEY. Em seguida, fazer o processo correto: deletar os livros do autor primeiro e depois deletar o autor.
DELETE FROM livros
WHERE id_livro = 8;

DELETE FROM autores
WHERE id_autor = 1;

SELECT * FROM livros;
SELECT * FROM autores;
SELECT * FROM vendas;

-- Deletar todos os livros de um determinado genero usando WHERE genero = '...'.
DELETE FROM livros
WHERE genero = '...';

-- Deletar os livros publicados antes do ano 2000.
DELETE FROM livros
WHERE ano_publicacao < 2000;

-- Deletar registros usando WHERE id_venda IN (2, 4) para remover dois registros de uma vez.
DELETE FROM vendas
WHERE id_venda IN (8, 10);

-- Perigo: Executar um DELETE sem cláusula WHERE na tabela vendas. Observe o efeito e discuta os riscos.
DELETE FROM vendas;

-- Usar TRUNCATE na tabela vendas e comparar com o DELETE sem WHERE — observe o comportamento do AUTO_INCREMENT.
TRUNCATE vendas;

-- Adicionar na tabela vendas a coluna forma_pagamento (VARCHAR(10)) com valor padrão DEFAULT 'Dinheiro'.
ALTER TABLE vendas ADD COLUMN forma_pagamento VARCHAR(10) DEFAULT 'Dinheiro';

-- Criar uma restrição CHECK na coluna forma_pagamento para permitir apenas os valores 'Dinheiro', 'Cartão' ou 'Pix'.
ALTER TABLE vendas 
ADD CONSTRAINT chFormaPagamento CHECK (forma_pagamento IN('Dinheiro', 'Cartão', 'Pix'));

-- Adicionar uma restrição UNIQUE na coluna nacionalidade da tabela autores.
ALTER TABLE autores ADD CONSTRAINT uq_nacionalidade UNIQUE (nacionalidade);

-- Verificar a estrutura das tabelas com DESC após cada alteração.
DESC autores;

-- Testar as novas constraints: tentar inserir uma venda com forma_pagamento = 'Boleto' e observar o erro.
INSERT INTO vendas (data_venda	, valor_total, forma_pagamento) VALUES
('2005-07-18', -50.00, 'Boleto');

-- Remover NOT NULL: Modificar o campo data_venda da tabela vendas para aceitar valores nulos (remover NOT NULL).
ALTER TABLE vendas
MODIFY COLUMN data_venda DATE;

-- Remover UNIQUE: Remover a restrição UNIQUE da coluna nacionalidade da tabela autores.
SHOW INDEX FROM vendas;

-- Alterar DEFAULT: Remover o valor padrão do campo forma_pagamento da tabela vendas (ou alterar o DEFAULT para outro valor).
ALTER TABLE vendas MODIFY COLUMN forma_pagamento VARCHAR(20) DEFAULT 'boleto';

-- Remover CHECK: Deletar a restrição CHECK do campo forma_pagamento da tabela vendas.
ALTER TABLE vendas
DROP CHECK chFormaPagemento;

-- Remover CHECK do valor_total: Deletar a restrição CHECK que impede valor_total menor ou igual a zero.
ALTER TABLE vendas
DROP CHECK chValorTotal;

-- Remover FOREIGN KEY: Deletar a FOREIGN KEY da tabela vendas que referencia livros. Após isso, verificar que é possível inserir um fk_livro com um id que não existe.
ALTER TABLE vendas
DROP FOREIGN KEY chFklivro;

INSERT INTO vendas (data_venda, quantidade, valor_total, fk_livro) VALUES
('2005-12-06', 1000, 2500.50, 1);

-- Remover FOREIGN KEY: Deletar a FOREIGN KEY da tabela livros que referencia autores.
ALTER TABLE livros
DROP FOREIGN KEY chFkAutor;

-- Após remover todas as constraints, verificar a estrutura final das três tabelas com DESC.
DESC livros;
DESC autores;
DESC vendas;

-- Exibir o título do livro e o nome do seu autor fazendo um JOIN entre livros e autores.
SELECT titulo, autores.nome FROM livros
JOIN autores ON autores.id_autor = livros.fk_autor;

-- Exibir o título do livro, a data da venda e o valor total fazendo um JOIN entre livros e vendas.
SELECT titulo, data_venda FROM livros
JOIN vendas ON vendas.id_venda = vendas.fk_livro;

-- Fazer um JOIN entre as três tabelas (autores, livros e vendas) para exibir: nome do autor, título do livro,
-- data da venda e valor total.
SELECT nome, titulo, data_venda, valor_total FROM livros
JOIN autores ON autores.id_autor = livros.fk_autor
JOIN vendas ON vendas.id_venda = vendas.fk_livro;

-- Usar CONCAT para exibir uma coluna 'informações' no formato "Título - Autor - Gênero".
SELECT
CONCAT('Titulo: ', titulo, ' - Autor: ', nome, ' - Gênero: ', genero) AS informacoes
FROM livros
JOIN autores ON autores.id_autor = livros.fk_autor
JOIN vendas ON vendas.id_venda = vendas.fk_livro;

-- Fazer um LEFT JOIN de livros com vendas para exibir todos os livros, inclusive os que nunca foram vendidos (com IFNULL no valor_total exibindo 'Sem vendas').
SELECT *, IFNULL(valor_total, 'Sem vendas') AS vendas FROM livros
LEFT JOIN vendas ON vendas.id_venda = vendas.fk_livro;

