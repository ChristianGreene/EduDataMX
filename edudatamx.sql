-- 1. Crear Base de Datos
CREATE DATABASE IF NOT EXISTS `edudatamx` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `edudatamx`;

-- Desactivar revisión de llaves foráneas para evitar errores de orden
SET FOREIGN_KEY_CHECKS = 0;

-- 2. Tablas Maestras (No dependen de nadie)
DROP TABLE IF EXISTS `escuela`;
CREATE TABLE `escuela` (
  `id_escuela` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(120) DEFAULT NULL,
  `direccion` varchar(200) DEFAULT NULL,
  `ciudad` varchar(80) DEFAULT NULL,
  `telefono` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`id_escuela`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

DROP TABLE IF EXISTS `periodo`;
CREATE TABLE `periodo` (
  `id_periodo` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(50) DEFAULT NULL,
  `fecha_inicio` date DEFAULT NULL,
  `fecha_fin` date DEFAULT NULL,
  PRIMARY KEY (`id_periodo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

DROP TABLE IF EXISTS `materia`;
CREATE TABLE `materia` (
  `id_materia` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id_materia`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- 3. Tablas de Segundo Nivel (Dependen de Escuela)
DROP TABLE IF EXISTS `docente`;
CREATE TABLE `docente` (
  `id_docente` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(100) DEFAULT NULL,
  `correo` varchar(100) DEFAULT NULL,
  `id_escuela` int DEFAULT NULL,
  PRIMARY KEY (`id_docente`),
  CONSTRAINT `docente_ibfk_1` FOREIGN KEY (`id_escuela`) REFERENCES `escuela` (`id_escuela`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

DROP TABLE IF EXISTS `estudiante`;
CREATE TABLE `estudiante` (
  `id_estudiante` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(100) DEFAULT NULL,
  `matricula` varchar(50) DEFAULT NULL,
  `id_escuela` int DEFAULT NULL,
  PRIMARY KEY (`id_estudiante`),
  CONSTRAINT `estudiante_ibfk_1` FOREIGN KEY (`id_escuela`) REFERENCES `escuela` (`id_escuela`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- 4. Tabla Grupos (Depende de Materia, Docente y Periodo)
DROP TABLE IF EXISTS `grupo`;
CREATE TABLE `grupo` (
  `id_grupo` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(100) DEFAULT NULL,
  `id_materia` int DEFAULT NULL,
  `id_docente` int DEFAULT NULL,
  `id_periodo` int DEFAULT NULL,
  PRIMARY KEY (`id_grupo`),
  CONSTRAINT `grupo_ibfk_1` FOREIGN KEY (`id_materia`) REFERENCES `materia` (`id_materia`),
  CONSTRAINT `grupo_ibfk_2` FOREIGN KEY (`id_docente`) REFERENCES `docente` (`id_docente`),
  CONSTRAINT `grupo_ibfk_3` FOREIGN KEY (`id_periodo`) REFERENCES `periodo` (`id_periodo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- 5. Tablas de Registro (Inscripciones, Evaluaciones, Sesiones)
DROP TABLE IF EXISTS `inscripcion`;
CREATE TABLE `inscripcion` (
  `id_inscripcion` int NOT NULL AUTO_INCREMENT,
  `id_estudiante` int DEFAULT NULL,
  `id_grupo` int DEFAULT NULL,
  PRIMARY KEY (`id_inscripcion`),
  CONSTRAINT `inscripcion_ibfk_1` FOREIGN KEY (`id_estudiante`) REFERENCES `estudiante` (`id_estudiante`),
  CONSTRAINT `inscripcion_ibfk_2` FOREIGN KEY (`id_grupo`) REFERENCES `grupo` (`id_grupo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

DROP TABLE IF EXISTS `evaluacion`;
CREATE TABLE `evaluacion` (
  `id_evaluacion` int NOT NULL AUTO_INCREMENT,
  `id_estudiante` int DEFAULT NULL,
  `id_grupo` int DEFAULT NULL,
  `calificacion` decimal(5,2) DEFAULT NULL,
  PRIMARY KEY (`id_evaluacion`),
  CONSTRAINT `evaluacion_ibfk_1` FOREIGN KEY (`id_estudiante`) REFERENCES `estudiante` (`id_estudiante`),
  CONSTRAINT `evaluacion_ibfk_2` FOREIGN KEY (`id_grupo`) REFERENCES `grupo` (`id_grupo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

DROP TABLE IF EXISTS `sesion_clase`;
CREATE TABLE `sesion_clase` (
  `id_sesion` int NOT NULL AUTO_INCREMENT,
  `id_grupo` int DEFAULT NULL,
  `fecha` date DEFAULT NULL,
  PRIMARY KEY (`id_sesion`),
  CONSTRAINT `sesion_clase_ibfk_1` FOREIGN KEY (`id_grupo`) REFERENCES `grupo` (`id_grupo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

DROP TABLE IF EXISTS `asistencia`;
CREATE TABLE `asistencia` (
  `id_asistencia` int NOT NULL AUTO_INCREMENT,
  `id_sesion` int DEFAULT NULL,
  `id_estudiante` int DEFAULT NULL,
  `estado` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`id_asistencia`),
  CONSTRAINT `asistencia_ibfk_1` FOREIGN KEY (`id_sesion`) REFERENCES `sesion_clase` (`id_sesion`),
  CONSTRAINT `asistencia_ibfk_2` FOREIGN KEY (`id_estudiante`) REFERENCES `estudiante` (`id_estudiante`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- 6. Insertar Datos
INSERT INTO `escuela` VALUES (1,'Secundaria Técnica 7','Av Principal','Villahermosa','9930000000');
INSERT INTO `periodo` VALUES (1,'2026-1','2026-01-15','2026-06-30');
INSERT INTO `materia` VALUES (1,'Matematicas'),(2,'Español'),(3,'Ciencias');
INSERT INTO `docente` VALUES (1,'Maria Lopez','maria@mail.com',1),(2,'Juan Perez','juan@mail.com',1),(3,'Ana Ruiz','ana@mail.com',1);
INSERT INTO `estudiante` VALUES (1,'Luis Hernandez','A001',1),(2,'Karla Sanchez','A002',1),(3,'Diego Martinez','A003',1),(4,'Fernanda Cruz','A004',1),(5,'Jose Ramirez','A005',1),(6,'Valeria Torres','A006',1),(7,'Carlos Mendez','A007',1),(8,'Daniela Gomez','A008',1),(9,'Miguel Flores','A009',1),(10,'Sofia Castillo','A010',1);
INSERT INTO `grupo` VALUES (1,'2A Mate',1,1,1),(2,'2A Español',2,2,1),(3,'2A Ciencias',3,3,1);
INSERT INTO `inscripcion` VALUES (1,1,1),(2,2,1),(3,3,1),(4,4,1),(5,5,1),(6,6,1),(7,7,1),(8,8,1),(9,9,1),(10,10,1),(11,1,2),(12,2,2),(13,3,2),(14,4,2),(15,5,2),(16,6,2),(17,7,2),(18,8,2),(19,9,2),(20,10,2),(21,1,3),(22,2,3),(23,3,3),(24,4,3),(25,5,3),(26,6,3),(27,7,3),(28,8,3),(29,9,3),(30,10,3);
INSERT INTO `evaluacion` VALUES (1,1,1,85.00),(2,2,1,90.00),(3,3,1,58.00),(4,4,1,70.00),(5,5,1,60.00),(6,6,1,88.00),(7,7,1,55.00),(8,8,1,78.00),(9,9,1,92.00),(10,10,1,65.00);
INSERT INTO `sesion_clase` VALUES (1,1,'2026-02-01'),(2,1,'2026-02-03'),(3,1,'2026-02-05');
INSERT INTO `asistencia` VALUES (1,1,1,'Presente'),(2,1,2,'Presente'),(3,1,3,'Ausente'),(4,1,4,'Presente'),(5,1,5,'Presente'),(6,1,6,'Presente'),(7,1,7,'Ausente'),(8,1,8,'Presente'),(9,1,9,'Presente'),(10,1,10,'Presente'),(11,2,1,'Presente'),(12,2,2,'Presente'),(13,2,3,'Ausente'),(14,2,4,'Presente'),(15,2,5,'Presente'),(16,2,6,'Presente'),(17,2,7,'Ausente'),(18,2,8,'Presente'),(19,2,9,'Presente'),(20,2,10,'Presente'),(21,3,1,'Presente'),(22,3,2,'Presente'),(23,3,3,'Ausente'),(24,3,4,'Presente'),(25,3,5,'Presente'),(26,3,6,'Presente'),(27,3,7,'Ausente'),(28,3,8,'Presente'),(29,3,9,'Presente'),(30,3,10,'Presente');

-- Reactivar revisión de llaves
SET FOREIGN_KEY_CHECKS = 1;
