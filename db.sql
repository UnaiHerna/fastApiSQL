CREATE DATABASE depuradoradb;
USE depuradoradb;

DROP TABLE IF EXISTS usuario;
DROP TABLE IF EXISTS grupoEind;
DROP TABLE IF EXISTS grupoLind;
DROP TABLE IF EXISTS grupoEscritura;
DROP TABLE IF EXISTS grupoLectura;
DROP TABLE IF EXISTS indicador;
DROP TABLE IF EXISTS sample;
DROP TABLE IF EXISTS maquina;
DROP TABLE IF EXISTS depuradora;
CREATE TABLE depuradora (
    id INT,
    nombre VARCHAR(255),
    ubicacion VARCHAR(255),
    capacidad INT
);

CREATE TABLE maquina (
    id INT NOT NULL,
    nombre VARCHAR(255),
    encendida BOOLEAN,
    id_depuradora INT NOT NULL
);

CREATE TABLE sample (
	id INT NOT NULL,
    nombre VARCHAR(255),
    valor FLOAT,
    id_maquina INT NOT NULL
);

CREATE TABLE indicador (
	id INT NOT NULL,
    nombre VARCHAR(255)
);

CREATE TABLE grupoLectura (
    id INT NOT NULL,
    nombre VARCHAR(255),
    id_maquina INT NOT NULL
);

CREATE TABLE grupoEscritura (
    id INT NOT NULL,
    nombre VARCHAR(255),
    id_maquina INT NOT NULL
);

CREATE TABLE grupoLind (
    id_grupo INT NOT NULL,
    id_indicador INT NOT NULL,
    nombre VARCHAR(255)
);

CREATE TABLE grupoEind (
    id_grupo INT NOT NULL,
    id_indicador INT NOT NULL,
    nombre VARCHAR(255)
);

CREATE TABLE usuario (
    id INT NOT NULL,
    username VARCHAR(255),
    nombre VARCHAR(255),
    email VARCHAR(255),
    disabled BOOLEAN,
    password VARCHAR(255),
    id_depuradora INT NOT NULL
);

ALTER TABLE depuradora ADD CONSTRAINT PK_Depuradora PRIMARY KEY (id);
ALTER TABLE maquina ADD CONSTRAINT PK_Maquina PRIMARY KEY (id);
ALTER TABLE sample ADD CONSTRAINT PK_Sample PRIMARY KEY (id);
ALTER TABLE indicador ADD CONSTRAINT PK_Indicador PRIMARY KEY (id);
ALTER TABLE grupoLectura ADD CONSTRAINT PK_GrupoLec PRIMARY KEY (id);
ALTER TABLE grupoEscritura ADD CONSTRAINT PK_GrupoEsc PRIMARY KEY (id);
ALTER TABLE grupoLind ADD CONSTRAINT PK_GruLInd PRIMARY KEY (id_grupo, id_indicador);
ALTER TABLE grupoEind ADD CONSTRAINT PK_GruEInd PRIMARY KEY (id_grupo, id_indicador);
ALTER TABLE usuario ADD CONSTRAINT PK_Usuario PRIMARY KEY (id);

ALTER TABLE maquina ADD CONSTRAINT FK_Maquina
FOREIGN KEY (id_depuradora) REFERENCES depuradora(id);
ALTER TABLE sample ADD CONSTRAINT FK_Sample
FOREIGN KEY (id_maquina) REFERENCES maquina(id);
ALTER TABLE usuario ADD CONSTRAINT FK_Usuario
FOREIGN KEY (id_depuradora) REFERENCES depuradora(id);
ALTER TABLE grupoLectura ADD CONSTRAINT FK_GrupoLec
FOREIGN KEY (id_maquina) REFERENCES maquina(id);
ALTER TABLE grupoEscritura ADD CONSTRAINT FK_GrupoEsc
FOREIGN KEY (id_maquina) REFERENCES maquina(id);
ALTER TABLE grupoLind ADD CONSTRAINT FK_GrupoLind1
FOREIGN KEY (id_grupo) REFERENCES grupoLectura(id);
ALTER TABLE grupoLind ADD CONSTRAINT FK_GrupoLind2
FOREIGN KEY (id_indicador) REFERENCES indicador(id);
ALTER TABLE grupoEind ADD CONSTRAINT FK_GrupoEind1
FOREIGN KEY (id_grupo) REFERENCES grupoEscritura(id);
ALTER TABLE grupoEind ADD CONSTRAINT FK_GrupoEind2
FOREIGN KEY (id_indicador) REFERENCES indicador(id);

-- Modificar la tabla maquina para hacer id autoincrementable
ALTER TABLE maquina MODIFY COLUMN id INT AUTO_INCREMENT;

-- Modificar la tabla usuario para hacer id autoincrementable
ALTER TABLE usuario MODIFY COLUMN id INT AUTO_INCREMENT;

-- Insertar datos en la tabla depuradora
INSERT INTO depuradora (id, nombre, ubicacion, capacidad)
VALUES
    (1, 'Depuradora Ranilla', 'Sevilla, España', 50000),
    (2, 'Depuradora Verde', 'Madrid, España', 70000),
    (3, 'Depuradora Azul', 'Barcelona, España', 60000),
    (4, 'Depuradora Naranja', 'Valencia, España', 55000),
    (5, 'Depuradora Amarilla', 'Bilbao, España', 45000);

-- Insertar datos en la tabla maquina
INSERT INTO maquina (nombre, encendida, id_depuradora)
VALUES
    ('EDAR SEDATEX', true, 1),
    ('Máquina Limpia', false, 2),
    ('Máquina Eficiente', true, 1),
    ('Máquina Pura', true, 3),
    ('Máquina Eco', false, 2);

-- Insertar datos en la tabla sample
INSERT INTO sample (id, nombre, valor, id_maquina)
VALUES
    (1, 'Muestra A', 10.5, 1),
    (2, 'Muestra B', 8.2, 2),
    (3, 'Muestra C', 15.3, 3),
    (4, 'Muestra D', 12.1, 4),
    (5, 'Muestra E', 9.8, 5),
    (6, 'Muestra F', 7.5, 2),
    (7, 'Muestra G', 11.2, 3),
    (8, 'Muestra H', 9.1, 1),
    (9, 'Muestra I', 14.8, 4),
    (10, 'Muestra J', 6.9, 5),
    (11, 'Muestra K', 13.2, 3),
    (12, 'Muestra L', 10.6, 2),
    (13, 'Muestra M', 8.4, 1),
    (14, 'Muestra N', 11.9, 4),
    (15, 'Muestra O', 9.7, 5),
    (16, 'Muestra P', 12.5, 2),
    (17, 'Muestra Q', 7.8, 3),
    (18, 'Muestra R', 10.3, 1),
    (19, 'Muestra S', 13.7, 4),			
    (20, 'Muestra T', 8.6, 5),
    (21, 'Muestra U', 11.5, 3),
    (22, 'Muestra V', 9.2, 2),
    (23, 'Muestra W', 14.3, 1),
    (24, 'Muestra X', 6.7, 4),
    (25, 'Muestra Y', 12.8, 5);

-- Insertar datos en la tabla indicador
INSERT INTO indicador (id, nombre)
VALUES
    (1, 'Indicador de pH'),
    (2, 'Indicador de Temperatura'),
    (3, 'Indicador de Oxígeno'),
    (4, 'Indicador de Sólidos'),
    (5, 'Indicador de Turbidez');

-- Insertar datos en la tabla grupoLectura
INSERT INTO grupoLectura (id, nombre, id_maquina)
VALUES
    (1, 'Grupo Lectura 1', 1),
    (2, 'Grupo Lectura 2', 2),
    (3, 'Grupo Lectura 3', 3),
    (4, 'Grupo Lectura 4', 4),
    (5, 'Grupo Lectura 5', 5);

-- Insertar datos en la tabla grupoEscritura
INSERT INTO grupoEscritura (id, nombre, id_maquina)
VALUES
    (1, 'Grupo Escritura A', 1),
    (2, 'Grupo Escritura B', 2),
    (3, 'Grupo Escritura C', 3),
    (4, 'Grupo Escritura D', 4),
    (5, 'Grupo Escritura E', 5);

-- Insertar datos en la tabla grupoLind
INSERT INTO grupoLind (id_grupo, id_indicador, nombre)
VALUES
    (1, 1, 'GrupoLind 1'),
    (1, 2, 'GrupoLind 2'),
    (2, 3, 'GrupoLind 3'),
    (3, 4, 'GrupoLind 4'),
    (4, 5, 'GrupoLind 5');

-- Insertar datos en la tabla grupoEind
INSERT INTO grupoEind (id_grupo, id_indicador, nombre)
VALUES
    (1, 1, 'GrupoEind A'),
    (2, 2, 'GrupoEind B'),
    (3, 3, 'GrupoEind C'),
    (4, 4, 'GrupoEind D'),
    (5, 5, 'GrupoEind E');

-- Insertar datos en la tabla usuario
INSERT INTO usuario (username, nombre, email, disabled, password, id_depuradora)
VALUES
    ('jazeme', 'Juan Antero Asumu Azeme Efiri', 'juanan@example.com', false, '$2b$12$l8kuC/HL2CZqyXkKzq5UdO8LjFu0KWSxJDFYRRJAM1U7mu.7obKky', 1),
    ('anita23', 'Ana María Pérez', 'anita23@gmail.com', false, '$2b$12$Ou3QZ9fYsTSi3f.1oQoJHeRS4Xe/zTcoSuMf8NkzYiCGQ1Xk69A8G', 2),
    ('pepe89', 'José López', 'pepe89@hotmail.com', false, '$2b$12$B5xFv8n64VeD7nu3/RbPrur6j1Xr6GbsDQ2.hHcWb5ml1nzxgAsaK', 3),
    ('laurita', 'Laura Fernández', 'laurita@outlook.com', true, '$2b$12$QsAL4VW1A7U57AZBV1h8PONz5/x4e4aUldqBFLMQyH3hVyeF8fYkC', 4),
    ('carlos72', 'Carlos Martínez', 'carlos72@yahoo.com', false, '$2b$12$Uyl9nXjG0RqV.fqUuMm1Xu9SOed..nxpsBsc1ZJZfSmQpUf0GJQ1G', 5);

SELECT m.nombre, s.nombre, s.valor
FROM maquina m
JOIN sample s ON s.id_maquina = m.id
WHERE s.valor > 10;