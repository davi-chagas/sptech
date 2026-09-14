/*
	Recapitulando os conceitos
    
    UPDATE - Atualizar dados - DML
    DELETE - Exclui um registro - DML 
    
    ALTER TABLE - Altera a tabela - DDL 
		MODIFY - Modifica um atributo 
        ADD - Adiciona um atributo
        DROP - Apaga um atributo
        RENAME - Troca o nome do atributo
        
	DROP TABLE - Elimina a tabela - DDL
    TRUNCATE - Apaga os dados - DDL
    CONSTRAINT - Restrição de um atributo
		CHECK - Restringir uma entrada  (valida) -- DDL
        
	DESCRIBE - Descrever os metadados da tabela 
    
    SELECT
		IFNULL() - Função para validar dados nulos
*/

-- USE sprint1;

CREATE TABLE sprint1.usuario (
	id INT PRIMARY KEY AUTO_INCREMENT, -- funciona apenas com tipos númericos inteiros 
	nome VARCHAR(45) NOT NULL,
    email VARCHAR(100) UNIQUE, 
	dtNasc DATE,
    peso DECIMAL (4,1), -- 000,0
    altura FLOAT,
    plano VARCHAR(45),
    CONSTRAINT chPlano CHECK(plano IN ('Mensal', 'Semanal', 'Avulso')),-- conjunto de palavras em formato de lista
	nivel INT,
    CONSTRAINT chNivel CHECK(nivel >=1 AND nivel <=5),
    dtCadastro DATETIME DEFAULT CURRENT_TIMESTAMP -- pega o horário do servidor
) AUTO_INCREMENT = 500; -- definir que comece a partir do 500Contudo, as desvantagens apontam para a rigidez do esquema, que dificita a adaptação a mudanças rápidas nos requisitos de dados, e a escalabilidade vertical limitada, que pode tornar o custo de hardware elevado para grandes volumes

DESC sprint1.usuario;

INSERT INTO usuario (nome, dtNasc, peso, altura, plano, nivel, email) VALUES 
('Jorge', '2000-06-09', 75.5, 1.85, 'Mensal', 2, 'jorge@email.com'),
('Maria', '2009-07-10', 56.5, 1.65, 'Avulso', 1, 'maria@email.com'),
('Carlos', '1998-10-05', 87.3, 1.72, 'Semanal', 5, 'carlos@email.com'),
('Adriana', '2010-04-07', 60.1, 1.65, 'Mensal', 4, 'dri@email.com');

-- Exibir os dados da tabela
SELECT * FROM usuario;

-- Exibir apenas os nome e a data de cadastro e formatar o nome da coluna para enviar 
SELECT nome AS 'Nome do usuário', -- AS == alias - apelidando o nome da coluna **não muda a estrutura da tabela**
 dtCadastro AS Data_Cadastro
 FROM usuario;
 
 -- Concatenar duas informações
 SELECT
 CONCAT('O aluno ', nome, ' utiliza o plano ', plano) AS info
 FROM usuario;
 
 -- IF e ELSE no MySQL
 -- Usamos o CASE
 SELECT 
 nome,
 CASE 
	WHEN nivel = 1 THEN 'Nível baby'
    WHEN Nivel = 2 THEN 'Nível mini monster'
    ELSE 'Nível Monster'
END	AS Nivel
FROM usuario;

-- Exibir dois usuários 
SELECT * FROM usuario WHERE id IN(501,503);

-- Não Exibir os usuários entre
SELECT * FROM usuario WHERE id NOT IN(501,503);

-- Exibir usuários entre
SELECT * FROM usuario WHERE id > 500 AND  id < 504;

-- Exibir usuários entre (similar se colocar o >= e <=)
SELECT * FROM usuario WHERE id BETWEEN 500 AND 505;

-- Exibir usuários nascidos acima de 2000
SELECT *FROM usuario  WHERE dtNasc > '2000-01-01';

TRUNCATE usuario;

DESC usuario;

SELECT *FROM usuario;


