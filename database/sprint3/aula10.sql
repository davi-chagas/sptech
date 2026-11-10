CREATE DATABASE sprint3;

USE sprint3;

CREATE TABLE medico (
    id_medico INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100),
    crm VARCHAR(20),
    especialidade VARCHAR(100)
);

CREATE TABLE paciente (
    id_paciente INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100),
    cpf VARCHAR(14),
    data_nasc DATE,
    genero CHAR(1),
    CONSTRAINT chk_genero CHECK (genero IN ('M', 'F', 'O'))
);

CREATE TABLE consulta (
    id_consulta INT AUTO_INCREMENT,
    fk_medico INT,
    fk_paciente INT,
    data_hora DATETIME,
    diagnostico VARCHAR(255),

    PRIMARY KEY (id_consulta, fk_medico, fk_paciente),

    FOREIGN KEY (fk_medico) REFERENCES medico(id_medico),
    FOREIGN KEY (fk_paciente) REFERENCES paciente(id_paciente)
);
-- INSERTS - Observar e descrever oque aconteceu
-- Faça os comandos abaixo, um de cada vez, e sempre confira os dados nas tabelas

INSERT INTO medico (nome, crm, especialidade) VALUES
('Dr. Carlos Almeida', 'CRM-SP 123456', 'Cardiologia'),
('Dra. Fernanda Lima', 'CRM-SP 234567', 'Pediatria'),
('Dr. Roberto Souza', 'CRM-RJ 345678', 'Ortopedia');

/*
*** Faça a consulta e coloque a descrição do que aconteceu em um comentário como esse
Na tabela médico foi inserido os doutores e seus respectivos dados
Repita para todos os comandos - Tire essas observações dos comentários***
*/


INSERT INTO paciente (nome, cpf, data_nasc, genero) VALUES
('João Silva',    '123.456.789-00', '1985-03-12', 'M'),
('Maria Santos',  '987.654.321-00', '1992-07-25', 'F'),
('Alex Pereira',  '111.222.333-44', '2000-11-01', 'O');


/* na tabela paciente foi inserido os pacientes e seus respectivos dados*/

INSERT INTO consulta (fk_medico, fk_paciente, data_hora, diagnostico) VALUES
(1, 1, '2026-01-10 09:00:00', 'Hipertensão leve'),
(2, 2, '2026-01-11 14:30:00', 'Gripe comum'),
(3, 3, '2026-01-12 16:00:00', 'Entorse de tornozelo'),
(1, 2, '2026-01-15 10:00:00', 'Check-up cardíaco');


/*na tabela associativa consulta, foi inserido o médico, o paciente e os dados da consulta*/

INSERT INTO paciente (nome, cpf, data_nasc, genero)
VALUES ('Pedro Gênero Inválido', '444.555.666-77', '1990-05-05', 'X');


/* Nesse insert, houve um erro no registro do genêro pois ele viola a check da tabela paciente sobre gênero. */

INSERT INTO consulta (fk_medico, fk_paciente, data_hora)
VALUES (99, 1, '2026-02-01 08:00:00');


/* Insert inválido, pois esse id_medico não foi cadastrado no sistema*/

INSERT INTO consulta (id_consulta, fk_medico, fk_paciente, data_hora)
VALUES (1, 1, 1, '2026-02-04 08:00:00');


/* Insert inválido, já existe uma consula (id_consulta) com o fk_medico 1 e paciente 1, por conta disso
é retratado um erro de duplicate*/

INSERT INTO consulta (fk_medico, fk_paciente, data_hora)
VALUES (1, NULL, '2026-02-06 08:00:00');


/*Insert inválido, não é possível registrar uma consulta sem um paciente*/

INSERT INTO medico (id_medico, nome, crm, especialidade)
VALUES (1, 'Dr. Hugo Tavares', 'CRM-SP 999999', 'Neurologia');


/*Insert inválido, já existe um médico com Id 1, por conta disso, erro de duplicate*/

INSERT INTO medico (nome, crm, especialidade)
VALUES ('Dra. Ana Beatriz', 'CRM-SP 123456789012345678901', 'Dermatologia');


/*Insert inválido, CRM excede o limite do metadado char(20)*/

INSERT INTO consulta (fk_medico, fk_paciente, data_hora, diagnostico) VALUES
(1, 3, '2026-10-23 09:00:00', 'Hipertensão leve'),
(2, 1, '2026-01-11 14:30:00', 'Gripe comum'),
(2, 3, '2026-07-28 16:00:00', 'Entorse de tornozelo'),
(1, 2, '2026-02-15 16:00:00', 'Check-up cardíaco');


/*Insert válido! cada consulta possui um id diferente e dados válidos (além de que, nenhum dos médico repete o paciente neste caso)*/

INSERT INTO paciente (nome, cpf, data_nasc, genero)
VALUES ('Diogo Queiroz', '123.456.789-000', '1991-04-04', 'M');


/*Insert inválido! o campo cpf excede o limite de 14*/

INSERT INTO paciente (nome, cpf, data_nasc, genero)
VALUES ('Mônica Aguiar', '888.999.000-11', '1990-02-30', 'O');


/*Insert inválido! não existe o dia 30 de fevereiro*/

INSERT INTO consulta (fk_medico, fk_paciente, data_hora, diagnostico)
VALUES (1, 1, '31/12/2026 10:00', 'Dores nas costas');


/*Insert inválido! maneira de inputar os dados de datetime seguindo uma sintáxe errada.*/

DELETE FROM medico WHERE id_medico = 1;


/*Delete inválido! por conta do médico estar relacionado a uma consulta, faz com que não consiga apagar o registro dele, sem antes apagar a consulta*/

DELETE FROM paciente WHERE id_paciente = 1;


/*Delete inválido! por conta do paciente estar relacionado a uma consulta, faz com que não consiga apagar o registro dele, sem antes apagar a consulta*/


UPDATE medico SET id_medico = 100 WHERE id_medico = 1;


/*Update inválido! por conta do paciente estar relacionado a uma consulta, faz com que não consiga atualizar o registro de id dele, seria necessário atualizar na consulta também*/


UPDATE paciente SET genero = 'Z' WHERE id_paciente = 1;


/*Update inválido! gênero Z viola as regras do check genêro*/


-- TREINO DE SELECTS

-- Traga os dados dos médicos e suas consultas
SELECT 
m.nome,
c.id_consulta,
c.fk_paciente
FROM consulta AS c
JOIN medico AS m
ON m.id_medico = c.fk_medico;

-- Traga os dados dos pacientes e suas consultas
SELECT 
p.nome,
c.id_consulta,
c.fk_medico
FROM consulta AS c
JOIN paciente AS p
ON p.id_paciente = c.fk_paciente;

-- Traga os dados das consultas junto com o médico e o paciente
SELECT 
c.id_consulta,
m.nome,
p.nome,
c.data_hora,
c.diagnostico
FROM consulta c
JOIN medico m
ON m.id_medico = c.fk_medico
JOIN paciente p
ON p.id_paciente = c.fk_paciente;

-- Liberdade criativa, elabore um select com que aprendeu até o momento.

SELECT COUNT(*) 'Quantidade de Consultas'
FROM consulta;

SELECT 
DAY(data_hora) 'Dia mês',
COUNT(*) 'Quantidade de consultas'
FROM consulta
GROUP BY DAY (data_hora);

SELECT 
fk_medico,
COUNT(*) 'Quantidade de consultas'
FROM consulta 
GROUP BY fk_medico;

SELECT * FROM consulta;

-- esse aqui não deu certo ://///

-- Error Code: 1055. Expression #1 of SELECT list is not in GROUP BY clause and contains nonaggregated column 'sprint3.m.nome' which is not functionally dependent on columns in GROUP BY clause; this is incompatible with sql_mode=only_full_group_by
