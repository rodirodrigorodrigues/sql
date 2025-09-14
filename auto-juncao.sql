CREATE TABLE AREA (
    ID INT PRIMARY KEY,
    NOME VARCHAR(100),
    ID_AREA_SUPERIOR INT
);

INSERT INTO AREA (ID, NOME, ID_AREA_SUPERIOR) VALUES
(1, 'Equipe de Recursos Humanos', 3),
(2, 'Escritório de Projetos', 5),
(3, 'Departamento de Administração', 5),
(4, 'Departamento de TI', 5),
(5, 'Direção-Geral', NULL),
(6, 'Equipe de Finanças', 3);

-- Consulta para exibir todas as áreas e suas áreas superiores
SELECT A1.NOME, A2.NOME
FROM AREA AS A1, AREA AS A2
WHERE A1.ID_AREA_SUPERIOR = A2.ID;

-- Consulta para exibir a hierarquia das áreas
SELECT LPAD(' ', LEVEL*2) || NOME AS HIERARQUIA
FROM AREA
START WITH ID_AREA_SUPERIOR IS NULL
CONNECT BY PRIOR ID = ID_AREA_SUPERIOR;