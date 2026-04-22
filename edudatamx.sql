CREATE DATABASE edudatamx;
USE edudatamx;
-- Tabla escuela
CREATE TABLE escuela (
  id_escuela INT AUTO_INCREMENT PRIMARY KEY,
  nombre VARCHAR(120),
  direccion VARCHAR(200),
  ciudad VARCHAR(80),
  telefono VARCHAR(20)
);

-- Tabla periodo
CREATE TABLE periodo (
  id_periodo INT AUTO_INCREMENT PRIMARY KEY,
  nombre VARCHAR(50),
  fecha_inicio DATE,
  fecha_fin DATE
);

-- Tabla materia
CREATE TABLE materia (
  id_materia INT AUTO_INCREMENT PRIMARY KEY,
  nombre VARCHAR(100)
);

-- Tabla docente
CREATE TABLE docente (
  id_docente INT AUTO_INCREMENT PRIMARY KEY,
  nombre VARCHAR(100),
  correo VARCHAR(100),
  id_escuela INT,
  FOREIGN KEY (id_escuela) REFERENCES escuela(id_escuela)
);

-- Tabla estudiante
CREATE TABLE estudiante (
  id_estudiante INT AUTO_INCREMENT PRIMARY KEY,
  nombre VARCHAR(100),
  matricula VARCHAR(50),
  id_escuela INT,
  FOREIGN KEY (id_escuela) REFERENCES escuela(id_escuela)
);

-- Tabla grupo
CREATE TABLE grupo (
  id_grupo INT AUTO_INCREMENT PRIMARY KEY,
  nombre VARCHAR(100),
  id_materia INT,
  id_docente INT,
  id_periodo INT,
  FOREIGN KEY (id_materia) REFERENCES materia(id_materia),
  FOREIGN KEY (id_docente) REFERENCES docente(id_docente),
  FOREIGN KEY (id_periodo) REFERENCES periodo(id_periodo)
);

-- Tabla inscripcion
CREATE TABLE inscripcion (
  id_inscripcion INT AUTO_INCREMENT PRIMARY KEY,
  id_estudiante INT,
  id_grupo INT,
  FOREIGN KEY (id_estudiante) REFERENCES estudiante(id_estudiante),
  FOREIGN KEY (id_grupo) REFERENCES grupo(id_grupo)
);

-- Tabla evaluacion
CREATE TABLE evaluacion (
  id_evaluacion INT AUTO_INCREMENT PRIMARY KEY,
  id_estudiante INT,
  id_grupo INT,
  calificacion DECIMAL(5,2),
  FOREIGN KEY (id_estudiante) REFERENCES estudiante(id_estudiante),
  FOREIGN KEY (id_grupo) REFERENCES grupo(id_grupo)
);

-- Tabla sesion_clase
CREATE TABLE sesion_clase (
  id_sesion INT AUTO_INCREMENT PRIMARY KEY,
  id_grupo INT,
  fecha DATE,
  FOREIGN KEY (id_grupo) REFERENCES grupo(id_grupo)
);

-- Tabla asistencia
CREATE TABLE asistencia (
  id_asistencia INT AUTO_INCREMENT PRIMARY KEY,
  id_sesion INT,
  id_estudiante INT,
  estado VARCHAR(20),
  FOREIGN KEY (id_sesion) REFERENCES sesion_clase(id_sesion),
  FOREIGN KEY (id_estudiante) REFERENCES estudiante(id_estudiante)
);

--
-- Escuela
INSERT INTO escuela (nombre, direccion, ciudad, telefono)
VALUES ('Secundaria Técnica 7', 'Av Principal', 'Villahermosa', '9930000000');

-- Periodo
INSERT INTO periodo (nombre, fecha_inicio, fecha_fin)
VALUES ('2026-1', '2026-01-15', '2026-06-30');

-- Materias
INSERT INTO materia (nombre) VALUES
('Matematicas'),
('Español'),
('Ciencias');

-- Docentes
INSERT INTO docente (nombre, correo, id_escuela) VALUES
('Maria Lopez','maria@mail.com',1),
('Juan Perez','juan@mail.com',1),
('Ana Ruiz','ana@mail.com',1);

-- Estudiantes
INSERT INTO estudiante (nombre, matricula, id_escuela) VALUES
('Luis Hernandez','A001',1),
('Karla Sanchez','A002',1),
('Diego Martinez','A003',1),
('Fernanda Cruz','A004',1),
('Jose Ramirez','A005',1),
('Valeria Torres','A006',1),
('Carlos Mendez','A007',1),
('Daniela Gomez','A008',1),
('Miguel Flores','A009',1),
('Sofia Castillo','A010',1);

-- Grupos
INSERT INTO grupo (nombre, id_materia, id_docente, id_periodo) VALUES
('2A Mate',1,1,1),
('2A Español',2,2,1),
('2A Ciencias',3,3,1);

-- Inscripciones
INSERT INTO inscripcion (id_estudiante, id_grupo) VALUES
(1,1),(2,1),(3,1),(4,1),(5,1),(6,1),(7,1),(8,1),(9,1),(10,1),
(1,2),(2,2),(3,2),(4,2),(5,2),(6,2),(7,2),(8,2),(9,2),(10,2),
(1,3),(2,3),(3,3),(4,3),(5,3),(6,3),(7,3),(8,3),(9,3),(10,3);

-- Calificaciones
INSERT INTO evaluacion (id_estudiante, id_grupo, calificacion) VALUES
(1,1,85),(2,1,90),(3,1,58),(4,1,70),(5,1,60),
(6,1,88),(7,1,55),(8,1,78),(9,1,92),(10,1,65);

SELECT * FROM estudiante;

SELECT 
e.nombre,
AVG(ev.calificacion) AS promedio
FROM estudiante e
JOIN evaluacion ev ON e.id_estudiante = ev.id_estudiante
GROUP BY e.nombre
HAVING promedio < 70;

-- Sesiones de clase
INSERT INTO sesion_clase (id_grupo, fecha) VALUES
(1,'2026-02-01'),
(1,'2026-02-03'),
(1,'2026-02-05');

-- Asistencias
INSERT INTO asistencia (id_sesion, id_estudiante, estado) VALUES
(1,1,'Presente'),(1,2,'Presente'),(1,3,'Ausente'),(1,4,'Presente'),(1,5,'Presente'),
(1,6,'Presente'),(1,7,'Ausente'),(1,8,'Presente'),(1,9,'Presente'),(1,10,'Presente'),

(2,1,'Presente'),(2,2,'Presente'),(2,3,'Ausente'),(2,4,'Presente'),(2,5,'Presente'),
(2,6,'Presente'),(2,7,'Ausente'),(2,8,'Presente'),(2,9,'Presente'),(2,10,'Presente'),

(3,1,'Presente'),(3,2,'Presente'),(3,3,'Ausente'),(3,4,'Presente'),(3,5,'Presente'),
(3,6,'Presente'),(3,7,'Ausente'),(3,8,'Presente'),(3,9,'Presente'),(3,10,'Presente');

SELECT 
e.nombre,
ROUND(100 * SUM(a.estado = 'Presente') / COUNT(*),2) AS asistencia
FROM asistencia a
JOIN estudiante e ON e.id_estudiante = a.id_estudiante
GROUP BY e.nombre
HAVING asistencia < 80;

SELECT 
e.nombre,
ROUND(AVG(ev.calificacion),2) AS promedio,
ROUND(100 * SUM(a.estado = 'Presente') / COUNT(*),2) AS asistencia
FROM estudiante e
JOIN evaluacion ev ON e.id_estudiante = ev.id_estudiante
JOIN asistencia a ON e.id_estudiante = a.id_estudiante
GROUP BY e.nombre
ORDER BY promedio ASC;