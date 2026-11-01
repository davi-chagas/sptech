USE sprint3;

CREATE TABLE instrutor (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(45),
    salario DECIMAL(10, 2)
);

CREATE TABLE area_conhecimento (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(45) NOT NULL
);

CREATE TABLE especialidade_instrutor (
    id INT PRIMARY KEY AUTO_INCREMENT,
    especialidade VARCHAR(45),
    fk_instrutor INT,
    FOREIGN KEY (fk_instrutor) REFERENCES instrutor(id)
);

CREATE TABLE curso (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(45) NOT NULL,
    fk_instrutor INT,
    fk_area_conhecimento INT,
    FOREIGN KEY (fk_instrutor) REFERENCES instrutor(id),
    FOREIGN KEY (fk_area_conhecimento) REFERENCES area_conhecimento(id)
);

CREATE TABLE estudante (
    id INT PRIMARY KEY AUTO_INCREMENT,
    ra CHAR(8),
    nome VARCHAR(45)
);

CREATE TABLE inscricao (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nota DECIMAL(3, 1),
    frequencia INT,
    fk_estudante INT,
    fk_curso INT,
    CONSTRAINT ch_nota CHECK(nota BETWEEN 0 AND 10),
    CONSTRAINT ch_frequencia CHECK(frequencia BETWEEN 0 AND 100),
    FOREIGN KEY (fk_estudante) REFERENCES estudante(id),
    FOREIGN KEY (fk_curso) REFERENCES curso(id)
);

INSERT INTO area_conhecimento (nome) VALUES
('Tecnologia'),
('Idiomas'),
('Artes');

INSERT INTO instrutor (nome, salario) VALUES
('Mariana Souza', 4500.00),
('Carlos Oliveira', 4200.00),
('Fernanda Lima', 4000.00),
('Rafael Santos', 3800.00);

INSERT INTO especialidade_instrutor (especialidade, fk_instrutor) VALUES
('Desenvolvimento Web', 1),
('Línguas Estrangeiras', 2),
('Artes Cênicas', 3);

INSERT INTO curso (nome, fk_instrutor, fk_area_conhecimento) VALUES
('HTML e CSS', 1, 1),
('JavaScript Básico', 1, 1),
('Inglês para Iniciantes', 2, 2),
('Espanhol Intermediário', 2, 2),
('Dança Contemporânea', 3, 3),
('Teatro Básico', 3, 3);

INSERT INTO estudante (ra, nome) VALUES
('20260001', 'Ana Costa'),
('20260002', 'Bruno Pereira'),
('20260003', 'Camila Rocha'),
('20260004', 'Diego Gomes'),
('20260005', 'Eduarda Alves'),
('20260006', 'Felipe Martins'),
('20260007', 'Gabriela Ribeiro'),
('20260008', 'Henrique Fernandes'),
('20260009', 'Isabela Carvalho'),
('20260010', 'João Mendes');

INSERT INTO inscricao (nota, frequencia, fk_estudante, fk_curso) VALUES
(8.5, 90, 1, 1),
(5.0, 85, 2, 1),
(7.0, 60, 3, 1),
(9.0, 95, 4, 2),
(6.5, 80, 5, 2),
(4.0, 70, 6, 2),
(8.0, 90, 7, 3),
(5.5, 90, 8, 3),
(7.5, 70, 9, 3),
(9.5, 100, 10, 4),
(6.0, 75, 1, 4),
(3.5, 50, 2, 4),
(7.0, 85, 3, 5),
(5.0, 60, 4, 5),
(8.0, 95, 5, 5);

-- 1. Exibir os estudantes inscritos em cursos da área de Tecnologia, 
-- apresentando o título do curso, a nota final e a frequência.
SELECT e.nome ESTUDANTE, 
c.nome CURSO, 
i.nota NOTA,
i.frequencia FREQUENCIA
FROM inscricao AS i
JOIN estudante AS e
ON e.id = i.fk_estudante
JOIN curso AS c
ON c.id = i.fk_curso
JOIN area_conhecimento AS a
ON a.id = c.fk_area_conhecimento
WHERE a.nome = 'Tecnologia';

-- 3. Exibir, para cada curso, a quantidade de estudantes inscritos,
--  a menor nota, a maior nota e a média das notas, truncada para uma casa decimal.
SELECT  
c.nome CURSO,
COUNT(i.fk_estudante) QTD_ESTUDANTE_INSCRITO,
MIN(i.nota) MENOR_NOTA,
MAX(i.nota) MAIOR_NOTA,
ROUND(AVG(i.nota)) MEDIA
FROM inscricao AS i
JOIN curso AS c
ON c.id = i.fk_curso
GROUP BY fk_curso;

-- 4. Exibir os cursos que possuem pelo menos três estudantes com nota maior ou igual a 6 e frequência maior ou igual a 75%.
SELECT 
c.nome
FROM inscricao AS i
JOIN curso AS c
ON c.id = i.fk_curso
WHERE i.nota >= 6 AND i.frequencia >= 75
GROUP BY c.id, c.nome
HAVING COUNT(i.fk_estudante ) >= 3;

-- 5. Exibir os instrutores que atuam em mais de um curso,
-- apresentando sua especialidade, a quantidade de cursos e a soma de suas remunerações.

-- Error Code: 1055. Expression #2 of SELECT list is not in GROUP BY clause and contains nonaggregated column 
-- 'sprint3.e.especialidade' which is not functionally dependent on columns in GROUP BY clause; 
-- this is incompatible with sql_mode=only_full_group_by
SELECT 
i.nome,
e.especialidade,
COUNT(c.id) qtd_cursos,
SUM(i.salario) soma_salario
FROM instrutor AS i 
JOIN curso AS c
ON i.id = c.fk_instrutor
JOIN especialidade_instrutor AS e
ON i.id = e.fk_instrutor
GROUP BY i.id, i.nome, e.especialidade
HAVING COUNT(c.id) > 1;

-- Exibir a quantidade de inscrições classificadas em Aprovado, Reprovado por Frequência e Reprovado por Nota.
SELECT 
    SUM(CASE
        WHEN nota >= 6 AND frequencia >= 75 THEN 1
        ELSE 0
    END) AS Aprovados,
    SUM(CASE
        WHEN nota >= 6 AND frequencia < 75 THEN 1
        ELSE 0
    END) AS Reprovados_Frequencia,
    SUM(CASE
        WHEN nota < 6 AND frequencia >= 75 THEN 1
        ELSE 0
    END) AS Reprovados_Nota
FROM
    inscricao;


-- 7. Exibir, por área de conhecimento, a quantidade de cursos, a quantidade de estudantes distintos inscritos,
--  a média das notas e o percentual de aprovações. 
SELECT
    a.nome AS area_conhecimento,
    COUNT(DISTINCT c.id) AS qtd_cursos,
    COUNT(DISTINCT i.fk_estudante) AS qtd_estudantes,
    AVG(i.nota) AS media_notas,
    (
        SUM(CASE
            WHEN i.nota >= 6 AND i.frequencia >= 75 THEN 1
            ELSE 0
        END) * 100.0 / COUNT(i.id)
    ) AS percentual_aprovacoes
FROM area_conhecimento AS a
JOIN curso AS c
    ON a.id = c.fk_area_conhecimento
LEFT JOIN inscricao AS i
    ON c.id = i.fk_curso
GROUP BY a.id, a.nome;

-- INDICE 2

CREATE TABLE regiao (
    id_regiao INT PRIMARY KEY AUTO_INCREMENT,
    nome_regiao VARCHAR(45) NOT NULL
);

CREATE TABLE situacao (
    id_situacao INT PRIMARY KEY AUTO_INCREMENT,
    descricao VARCHAR(45) NOT NULL
);

CREATE TABLE area_atuacao (
    id_area INT PRIMARY KEY AUTO_INCREMENT,
    nome_area VARCHAR(45) NOT NULL
);

CREATE TABLE setor (
    id_setor INT PRIMARY KEY AUTO_INCREMENT,
    nome_setor VARCHAR(45) NOT NULL
);

CREATE TABLE instituicao (
    id_instituicao INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100) NOT NULL,
    cnpj CHAR(18) NOT NULL,
    id_setor INT,
    FOREIGN KEY (id_setor) REFERENCES setor(id_setor)
);

CREATE TABLE voluntario (
    id_voluntario INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL,
    telefone VARCHAR(20)
);

CREATE TABLE projeto (
    id_projeto INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100) NOT NULL,
    orcamento_previsto DECIMAL(12, 2),
    data_inicio DATE,
    data_fim DATE,
    meta_horas INT,
    id_regiao INT,
    id_situacao INT,
    id_area INT,
    FOREIGN KEY (id_regiao) REFERENCES regiao(id_regiao),
    FOREIGN KEY (id_situacao) REFERENCES situacao(id_situacao),
    FOREIGN KEY (id_area) REFERENCES area_atuacao(id_area)
);

CREATE TABLE participacao (
    id_participacao INT PRIMARY KEY AUTO_INCREMENT,
    id_projeto INT,
    id_voluntario INT,
    horas_trabalhadas INT,
    data_registro DATE,
    FOREIGN KEY (id_projeto) REFERENCES projeto(id_projeto),
    FOREIGN KEY (id_voluntario) REFERENCES voluntario(id_voluntario)
);

CREATE TABLE apoio_financeiro (
    id_apoio INT PRIMARY KEY AUTO_INCREMENT,
    id_projeto INT,
    id_instituicao INT,
    valor DECIMAL(12, 2),
    data_apoio DATE,
    FOREIGN KEY (id_projeto) REFERENCES projeto(id_projeto),
    FOREIGN KEY (id_instituicao) REFERENCES instituicao(id_instituicao)
);

INSERT INTO regiao (id_regiao, nome_regiao) VALUES
(1, 'Zona Sul'),
(2, 'Zona Norte'),
(3, 'Zona Leste'),
(4, 'Zona Oeste'),
(5, 'Centro');

INSERT INTO situacao (id_situacao, descricao) VALUES
(1, 'Ativo'),
(2, 'Concluído'),
(3, 'Suspenso'),
(4, 'Em planejamento');

INSERT INTO area_atuacao (id_area, nome_area) VALUES
(1, 'Reflorestamento'),
(2, 'Educação Ambiental'),
(3, 'Reciclagem'),
(4, 'Recursos Hídricos'),
(5, 'Proteção Animal');

INSERT INTO setor (id_setor, nome_setor) VALUES
(1, 'Terceiro Setor'),
(2, 'Privado'),
(3, 'Governamental'),
(4, 'Acadêmico');

INSERT INTO instituicao (id_instituicao, nome, cnpj, id_setor) VALUES
(1, 'Fundação Verde Paulista', '12.345.678/0001-01', 1),
(2, 'Instituto Mata Atlântica', '23.456.789/0001-02', 1),
(3, 'Banco Paulista S.A.', '34.567.890/0001-03', 2),
(4, 'Secretaria do Verde e Meio Ambiente', '45.678.901/0001-04', 3),
(5, 'Universidade São Paulo Tech', '56.789.012/0001-05', 4);

INSERT INTO voluntario (id_voluntario, nome, email, telefone) VALUES
(1, 'Ana Souza', 'ana.souza@email.com', '(11) 98111-0001'),
(2, 'Bruno Lima', 'bruno.lima@email.com', '(11) 98111-0002'),
(3, 'Carla Mendes', 'carla.mendes@email.com', '(11) 98111-0003'),
(4, 'Diego Rocha', 'diego.rocha@email.com', '(11) 98111-0004'),
(5, 'Elisa Prado', 'elisa.prado@email.com', '(11) 98111-0005'),
(6, 'Felipe Nunes', 'felipe.nunes@email.com', '(11) 98111-0006'),
(7, 'Gabriela Alves', 'gabriela.alves@email.com', '(11) 98111-0007'),
(8, 'Henrique Dias', 'henrique.dias@email.com', '(11) 98111-0008'),
(9, 'Isabela Castro', 'isabela.castro@email.com', '(11) 98111-0009'),
(10, 'João Ramos', 'joao.ramos@email.com', '(11) 98111-0010');

INSERT INTO projeto (
    id_projeto,
    nome,
    orcamento_previsto,
    data_inicio,
    data_fim,
    meta_horas,
    id_regiao,
    id_situacao,
    id_area
) VALUES
(1, 'Refloresta Sul', 50000.00, '2026-02-01', '2026-12-20', 120, 1, 1, 1),
(2, 'Horta Norte', 18000.00, '2026-03-10', '2026-11-30', 80, 2, 1, 2),
(3, 'Recicla Leste', 32000.00, '2026-01-15', '2026-12-15', 150, 3, 1, 3),
(4, 'Águas do Oeste', 45000.00, '2026-04-01', '2027-03-31', 100, 4, 1, 4),
(5, 'Educa Centro', 12000.00, '2025-08-01', '2026-06-30', 60, 5, 2, 2),
(6, 'Mata Ciliar Sul', 60000.00, '2026-02-20', '2027-02-19', 200, 1, 1, 1),
(7, 'Fauna Norte', 25000.00, '2026-05-05', '2026-10-05', 90, 2, 3, 5),
(8, 'Praças Leste', 15000.00, '2026-09-01', '2027-08-31', 100, 3, 4, 2);

INSERT INTO participacao (
    id_participacao,
    id_projeto,
    id_voluntario,
    horas_trabalhadas,
    data_registro
) VALUES
(1, 1, 1, 30, '2026-02-15'),
(2, 1, 2, 40, '2026-02-20'),
(3, 1, 6, 25, '2026-03-02'),
(4, 2, 3, 50, '2026-03-18'),
(5, 2, 8, 45, '2026-03-25'),
(6, 3, 3, 60, '2026-01-28'),
(7, 3, 7, 40, '2026-02-10'),
(8, 3, 8, 30, '2026-02-22'),
(9, 4, 4, 55, '2026-04-12'),
(10, 4, 8, 50, '2026-04-28'),
(11, 5, 1, 35, '2025-09-05'),
(12, 6, 2, 70, '2026-03-08'),
(13, 6, 6, 60, '2026-03-22'),
(14, 7, 5, 20, '2026-05-20');

INSERT INTO apoio_financeiro (
    id_apoio,
    id_projeto,
    id_instituicao,
    valor,
    data_apoio
) VALUES
(1, 1, 1, 20000.00, '2026-02-10'),
(2, 1, 3, 15000.00, '2026-03-05'),
(3, 3, 2, 12000.00, '2026-01-20'),
(4, 3, 4, 10000.00, '2026-02-15'),
(5, 3, 1, 8000.00, '2026-03-01'),
(6, 4, 3, 25000.00, '2026-04-10'),
(7, 5, 5, 5000.00, '2025-08-15'),
(8, 6, 1, 30000.00, '2026-03-01'),
(9, 6, 2, 20000.00, '2026-03-20');

-- 2. Adicionar à tabela de projetos um campo para meta de horas de voluntariado com valor padrão de 100 e restrição para
--  impedir valores negativos.
ALTER TABLE projeto ADD COLUMN meta_horas_voluntariado INT DEFAULT 100 
CONSTRAINT meta_horas_voluntariado CHECK(meta_horas_voluntariado >= 0);

-- Exibir os projetos ativos cuja região contenha a letra “s”, apresentando a 
-- quantidade de voluntários participantes e o total de horas trabalhadas.
SELECT
p.nome,
COUNT(pa.id_voluntario) QTD_VOLUNTARIOS,
TIMESTAMPDIFF(HOUR, p.data_inicio, data_fim) TOTAL_HORAS
FROM participacao AS pa
JOIN projeto AS p
ON pa.id_projeto = p.id_projeto
JOIN situacao AS s
ON p.id_situacao = s.id_situacao
JOIN regiao AS r
ON p.id_regiao = r.id_regiao
WHERE s.descricao = 'Ativo'
AND r.nome_regiao LIKE '%s%'
GROUP BY p.id_projeto, p.nome;

-- Exibir as instituições que apoiaram pelo menos dois projetos, apresentando setor, 
-- valor total contribuído e média de contribuição.
SELECT 
i.nome NOME_INSTITUICAO, 
s.nome_setor NOME_SETOR,
SUM(a.valor) VALOR_CONTRIBUIDO,
AVG(a.valor) MEDIA_CONTRIBUIDO
FROM apoio_financeiro AS a
JOIN projeto AS p
ON a.id_projeto = p.id_projeto
JOIN instituicao AS i
ON a.id_instituicao = i.id_instituicao
JOIN setor AS s
ON s.id_setor = i.id_instituicao
GROUP BY i.id_instituicao, i.nome
HAVING COUNT(a.id_projeto) > 2;

-- Exibir, para cada projeto, o orçamento previsto, o valor total recebido e o percentual de cobertura do orçamento.
SELECT DISTINCT
	p.nome AS NOME_PROJETO,
	p.orcamento_previsto AS ORCAMENTO_PREVISTO,
	SUM(a.valor) AS VALOR_TOTAL,
	SUM(a.valor * 100) / orcamento_previsto AS percentual
FROM apoio_financeiro AS a
	JOIN projeto AS p
	ON a.id_projeto = p.id_projeto
GROUP BY a.id_projeto, p.nome;

-- 6. Exibir os projetos cujo total de horas trabalhadas seja inferior à meta cadastrada, apresentando a diferença de horas e 
-- o percentual atingido.
SELECT
    p.nome,
    p.meta_horas,
    SUM(pa.horas_trabalhadas) AS total_horas_trabalhadas,
    p.meta_horas - SUM(pa.horas_trabalhadas) AS diferenca_horas,
    SUM(pa.horas_trabalhadas) * 100.0 / p.meta_horas AS percentual_atingido
FROM projeto AS p
JOIN participacao AS pa
    ON p.id_projeto = pa.id_projeto
GROUP BY p.id_projeto, p.nome, p.meta_horas
HAVING SUM(pa.horas_trabalhadas) < p.meta_horas;


-- 7. Exibir todos os projetos com quantidade de voluntários, total de horas, quantidade de instituições apoiadoras,
-- recursos recebidos e sua classificação financeira.
SELECT
    p.nome,
    COUNT(DISTINCT pa.id_voluntario) AS qtd_voluntarios,
    SUM(pa.horas_trabalhadas) AS total_horas_trabalhadas,
    COUNT(DISTINCT a.id_instituicao) AS qtd_instituicoes_apoiadoras,
    SUM(a.valor) AS recursos_recebidos
FROM projeto AS p
LEFT JOIN participacao AS pa
    ON p.id_projeto = pa.id_projeto
LEFT JOIN apoio_financeiro AS a
    ON p.id_projeto = a.id_projeto
GROUP BY p.id_projeto, p.nome;

-- INDICE 3

CREATE TABLE gm_pais (
    id_pais INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(60) NOT NULL
);

CREATE TABLE gm_situacao (
    id_situacao INT PRIMARY KEY AUTO_INCREMENT,
    descricao VARCHAR(45) NOT NULL
);

CREATE TABLE gm_especialidade (
    id_especialidade INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(60) NOT NULL
);

CREATE TABLE gm_area_atuacao (
    id_area INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(60) NOT NULL
);

CREATE TABLE gm_organizacao_parceira (
    id_organizacao INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100) NOT NULL,
    tipo VARCHAR(45) NOT NULL
);

CREATE TABLE gm_profissional (
    id_profissional INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100) NOT NULL,
    custo_hora DECIMAL(10, 2),
    id_especialidade INT,
    id_coordenador INT,
    FOREIGN KEY (id_especialidade) REFERENCES gm_especialidade(id_especialidade),
    FOREIGN KEY (id_coordenador) REFERENCES gm_profissional(id_profissional)
);

CREATE TABLE gm_missao (
    id_missao INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100) NOT NULL,
    orcamento_previsto DECIMAL(12, 2),
    data_inicio DATE,
    data_fim DATE,
    id_pais INT,
    id_situacao INT,
    FOREIGN KEY (id_pais) REFERENCES gm_pais(id_pais),
    FOREIGN KEY (id_situacao) REFERENCES gm_situacao(id_situacao)
);

CREATE TABLE gm_missao_area (
    id_missao INT,
    id_area INT,
    PRIMARY KEY (id_missao, id_area),
    FOREIGN KEY (id_missao) REFERENCES gm_missao(id_missao),
    FOREIGN KEY (id_area) REFERENCES gm_area_atuacao(id_area)
);

CREATE TABLE gm_participacao (
    id_participacao INT PRIMARY KEY AUTO_INCREMENT,
    id_missao INT,
    id_profissional INT,
    horas_trabalhadas INT,
    nota_desempenho DECIMAL(4, 2),
    FOREIGN KEY (id_missao) REFERENCES gm_missao(id_missao),
    FOREIGN KEY (id_profissional) REFERENCES gm_profissional(id_profissional)
);

CREATE TABLE gm_financiamento (
    id_financiamento INT PRIMARY KEY AUTO_INCREMENT,
    id_missao INT,
    id_organizacao INT,
    valor DECIMAL(12, 2),
    data_financiamento DATE,
    FOREIGN KEY (id_missao) REFERENCES gm_missao(id_missao),
    FOREIGN KEY (id_organizacao) REFERENCES gm_organizacao_parceira(id_organizacao)
);

INSERT INTO gm_pais (id_pais, nome) VALUES
(1, 'Brasil'),
(2, 'Haiti'),
(3, 'Quênia'),
(4, 'Nepal'),
(5, 'Síria'),
(6, 'Filipinas');

INSERT INTO gm_situacao (id_situacao, descricao) VALUES
(1, 'Em andamento'),
(2, 'Concluída'),
(3, 'Suspensa'),
(4, 'Planejada');

INSERT INTO gm_especialidade (id_especialidade, nome) VALUES
(1, 'Médico'),
(2, 'Enfermeiro'),
(3, 'Engenheiro Civil'),
(4, 'Logística'),
(5, 'Psicólogo'),
(6, 'Nutricionista');

INSERT INTO gm_area_atuacao (id_area, nome) VALUES
(1, 'Saúde'),
(2, 'Alimentação'),
(3, 'Saneamento e Água'),
(4, 'Educação'),
(5, 'Abrigo e Reconstrução');

INSERT INTO gm_organizacao_parceira (id_organizacao, nome, tipo) VALUES
(1, 'Cruz Azul Internacional', 'ONG'),
(2, 'Fundo Mundial Solidário', 'Fundação'),
(3, 'Fundação Horizonte', 'Fundação'),
(4, 'Banco Global de Desenvolvimento', 'Banco multilateral'),
(5, 'Instituto Saúde para Todos', 'ONG'),
(6, 'Agência de Cooperação Europeia', 'Governamental');

INSERT INTO gm_profissional
(id_profissional, nome, custo_hora, id_especialidade, id_coordenador) VALUES
(1, 'Marina Teixeira', 120.00, 1, NULL),
(2, 'Rafael Moreira', 110.00, 3, NULL),
(3, 'Helena Duarte', 90.00, 4, NULL),
(4, 'Lucas Ferreira', 70.00, 2, 1),
(5, 'Beatriz Nogueira', 115.00, 1, 1),
(6, 'Thiago Barros', 100.00, 3, 2),
(7, 'Camila Ribeiro', 85.00, 5, 1),
(8, 'Otávio Lacerda', 80.00, 4, 3),
(9, 'Larissa Campos', 75.00, 6, 3),
(10, 'Pedro Azevedo', 68.00, 2, 1),
(11, 'Sofia Albuquerque', 105.00, 3, 2),
(12, 'Daniel Cardoso', 82.00, 5, 2);

INSERT INTO gm_missao
(id_missao, nome, orcamento_previsto, data_inicio, data_fim, id_pais, id_situacao) VALUES
(1, 'Água Limpa Haiti', 80000.00, '2025-01-10', '2025-06-30', 2, 2),
(2, 'Socorro Enchentes Sul', 60000.00, '2025-03-01', '2025-05-15', 1, 2),
(3, 'Nutrição Quênia', 70000.00, '2025-02-01', '2025-08-30', 3, 2),
(4, 'Reconstrução Nepal', 150000.00, '2025-09-01', '2026-09-30', 4, 1),
(5, 'Saúde Síria', 120000.00, '2025-10-01', '2026-12-31', 5, 1),
(6, 'Escola Itinerante Filipinas', 40000.00, '2025-04-01', '2025-10-31', 6, 2),
(7, 'Corredor Humanitário Síria', 90000.00, '2026-01-15', '2026-12-15', 5, 3),
(8, 'Resposta Rápida Brasil', 30000.00, '2026-11-01', '2027-02-28', 1, 4);

INSERT INTO gm_missao_area (id_missao, id_area) VALUES
(1, 3),
(1, 1),
(2, 5),
(2, 1),
(2, 2),
(3, 2),
(3, 1),
(4, 5),
(4, 3),
(5, 1),
(6, 4),
(7, 2),
(8, 5);

INSERT INTO gm_participacao
(id_participacao, id_missao, id_profissional, horas_trabalhadas, nota_desempenho) VALUES
(1, 1, 2, 120, 8.5),
(2, 1, 6, 100, 9.0),
(3, 1, 4, 80, 7.5),
(4, 2, 1, 60, 9.2),
(5, 2, 4, 70, 8.0),
(6, 2, 8, 90, 7.8),
(7, 3, 9, 150, 8.8),
(8, 3, 5, 110, 9.5),
(9, 3, 8, 100, 8.2),
(10, 4, 2, 200, 8.9),
(11, 4, 6, 180, 8.4),
(12, 4, 3, 90, 7.9),
(13, 5, 1, 160, 9.1),
(14, 5, 5, 140, 9.3),
(15, 5, 7, 120, 8.6),
(16, 6, 7, 80, 8.7),
(17, 6, 10, 100, 7.6),
(18, 7, 3, 40, 7.0);

INSERT INTO gm_financiamento
(id_financiamento, id_missao, id_organizacao, valor, data_financiamento) VALUES
(1, 1, 1, 40000.00, '2025-01-05'),
(2, 1, 2, 30000.00, '2025-01-20'),
(3, 2, 1, 25000.00, '2025-02-25'),
(4, 2, 2, 20000.00, '2025-03-05'),
(5, 3, 1, 35000.00, '2025-02-10'),
(6, 3, 3, 20000.00, '2025-02-18'),
(7, 4, 1, 50000.00, '2025-09-10'),
(8, 4, 4, 60000.00, '2025-09-15'),
(9, 4, 2, 25000.00, '2025-10-01'),
(10, 5, 5, 45000.00, '2025-10-10'),
(11, 5, 4, 30000.00, '2025-11-05'),
(12, 6, 6, 15000.00, '2025-03-25');

-- 2. Exibir o nome de cada profissional, sua especialidade, seu coordenador, a quantidade de missões concluídas 
-- e a média das notas de desempenho.
SELECT	
	p.nome NOME,
	e.nome ESPECIALIDADE,
	c.nome COORDENADOR,
	COUNT(m.id_missao) QTD_MISSAO,
	AVG(pa.nota_desempenho) MEDIA
FROM gm_participacao AS pa
	JOIN gm_profissional AS p
    ON pa.id_profissional = p.id_profissional
    LEFT JOIN gm_profissional AS c
    ON p.id_coordenador = c.id_profissional
    JOIN gm_especialidade AS e
    ON p.id_especialidade = e.id_especialidade
    JOIN gm_missao AS m
    ON pa.id_missao = m.id_missao
GROUP BY pa.id_profissional, p.nome;

-- 3. Exibir, para cada área de atuação, a quantidade de missões concluídas relacionadas, a quantidade de profissionais distintos
--  e o total de horas trabalhadas.
SELECT 
	a.nome AREA_ATUACAO,
	COUNT(m.id_missao) QTD_MISSAO,
	COUNT(DISTINCT id_profissional) QTD_PROFISSIONAL,
    SUM(pa.horas_trabalhadas) HORAS_TRABALHADAS
FROM gm_participacao pa
	JOIN gm_missao_area m
    ON pa.id_missao = m.id_missao
	JOIN gm_area_atuacao a
    ON a.id_area = m.id_area
GROUP BY a.id_area;

-- 4. Exibir as organizações parceiras que financiaram pelo menos três missões diferentes.
SELECT 
	op.nome,
    COUNT(m.id_missao) qtd_missao
FROM gm_financiamento f
	JOIN gm_organizacao_parceira op
	ON op.id_organizacao = f.id_organizacao
	JOIN gm_missao m
	ON f.id_missao = m.id_missao
GROUP BY f.id_organizacao
HAVING COUNT(m.id_missao) > 2;

-- 5. Exibir, para cada missão, a quantidade de profissionais participantes, o total de horas trabalhadas,
--  o custo do pessoal, a quantidade de financiadores e os recursos recebidos.
-- não consegui professora :(	

-- 6. Exibir, para cada coordenador, a quantidade de profissionais supervisionados, a quantidade de missões em que atuaram, o custo total e a média de desempenho.

SELECT
    c.nome AS coordenador,
    COUNT(p.id_profissional) AS qtd_profissionais_supervisionados,
    COUNT(pa.id_missao) AS qtd_missoes,
    SUM(pa.horas_trabalhadas * p.custo_hora) AS custo_total,
    AVG(pa.nota_desempenho) AS media_desempenho
FROM gm_profissional AS c
	LEFT JOIN gm_profissional AS p
    ON c.id_profissional = p.id_coordenador
	LEFT JOIN gm_participacao AS pa
    ON p.id_profissional = pa.id_profissional
GROUP BY c.id_profissional, c.nome
HAVING COUNT(DISTINCT p.id_profissional) > 0;

-- 7. Desenvolver um relatório geral por missão contendo país, situação, quantidade de áreas de atuação, profissionais participantes, organizações financiadoras, horas trabalhadas, custo total, recursos recebidos, percentual de cobertura orçamentária e classificação financeira.
-- não consegui professora :(
