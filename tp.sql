-- Ejercicio 1: Crear Base de Datos
CREATE DATABASE veterinaria_patitas_felices;

USE veterinaria_patitas_felices;

-- Ejercicio 2: Crear tabla duenos
CREATE TABLE duenos (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(50) NOT NULL,
    apellido VARCHAR(50) NOT NULL,
    telefono VARCHAR(20) NOT NULL,
    direccion VARCHAR(100)
);

-- Ejercicio 3 – Crear tabla mascotas
CREATE TABLE mascotas (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(50) NOT NULL,
    especie VARCHAR(30) NOT NULL,
    fecha_nacimiento DATE,
    id_dueno INT,
    FOREIGN KEY (id_dueno)
        REFERENCES duenos(id)
);

-- Ejercicio 4 – Crear tabla veterinarios
CREATE TABLE veterinarios (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(50) NOT NULL,
    apellido VARCHAR(50) NOT NULL,
    matricula VARCHAR(20) NOT NULL UNIQUE,
    especialidad VARCHAR(50) NOT NULL
);

-- Ejercicio 5 – Crear tabla historial_clinico
CREATE TABLE historial_clinico(
    id INT PRIMARY KEY AUTO_INCREMENT,
    id_mascota INT,
    FOREIGN KEY (id_mascota)
        REFERENCES mascotas(id)
        ON DELETE CASCADE,
    id_veterinario INT,
    FOREIGN KEY (id_veterinario)
        REFERENCES veterinarios(id),
    fecha_registro DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    descripcion VARCHAR(250) NOT NULL
);

-- Ejercicio 6 – Insertar registros
-- 3 dueños con información completa
INSERT INTO duenos (nombre, apellido, telefono, direccion)
VALUES
    ('Silvina', 'Mansilla', '3514332211', 'Avenida General Paz 200, Centro'),
    ('Ricardo', 'Darín', '3515443322', 'Bv. Chacabuco 1500, Nueva Córdoba'),
    ('Natalia', 'Oreiro', '3516554433', 'Calle Belgrano 600, Güemes');

-- 3 mascotas, cada una asociada a un dueño
INSERT INTO mascotas (nombre, especie, fecha_nacimiento, id_dueno)
VALUES
    ('Mushu', 'Cobayo', '2021-10-14', 1),
    ('Chulo', 'Gato', '2024-12-03', 2),
    ('Micha', 'Nutria', '2019-03-25', 3);

-- 2 veterinarios con especialidades distintas
INSERT INTO
    veterinarios (nombre, apellido, matricula, especialidad)
VALUES
    ('Lucas', 'Cabral', 'MV-AR05', 'Clínica General'),
    ('Sofia', 'Gutiérrez', 'MV-AR06', 'Oftalmología');

-- 3 registros de historial clínico
INSERT INTO historial_clinico (id_mascota, id_veterinario, descripcion)
VALUES
    (1, 1, 'Control general de roedor, peso estable, se recomienda cambio de dieta.'),
    (2, 2, 'Revisión ocular por lagrimeo excesivo. Diagnóstico: conjuntivitis leve.'),
    (3, 1, 'Consulta por falta de apetito. Se le suministró vitaminas y antiparasitarios.');

-- Ejercicio 7 – Actualizar registros
-- Cambiar la dirección de un dueño (por ID o nombre)
UPDATE duenos 
SET direccion = 'Calle 25 de Mayo 110, Centro' 
WHERE id = 2;

-- Actualizar la especialidad de un veterinario (por ID o matrícula)
UPDATE veterinarios 
SET especialidad = 'Cirugía Mayor' 
WHERE matricula = 'MV-AR06';

-- Editar la descripción de un historial clínico (por ID)
UPDATE historial_clinico 
SET descripcion = 'Control general de roedor. Se implementó la nueva dieta y el peso es óptimo. Cita de seguimiento en 3 meses.' 
WHERE id = 1;

-- Ejercicio 8 – Eliminar registros
-- Eliminar una mascota (por ID o nombre)
DELETE FROM mascotas 
WHERE id = 3;

-- Verificar que se eliminen automáticamente los registros del historial clínico asociados (ON DELETE CASCADE)
SELECT * FROM historial_clinico 
WHERE id_mascota = 3;

