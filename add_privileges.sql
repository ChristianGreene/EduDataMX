-- 1. Crear usuario para el Director (Control total)
CREATE USER 'director_admin'@'localhost' IDENTIFIED BY 'AdminPass123!';
GRANT ALL PRIVILEGES ON edudatamx.* TO 'director_admin'@'localhost';

-- 2. Crear usuario para Docentes (Solo lectura de escuela, escritura en evaluación y asistencia)
CREATE USER 'docente_user'@'localhost' IDENTIFIED BY 'Docente2026!';
GRANT SELECT ON edudatamx.estudiante TO 'docente_user'@'localhost';
GRANT SELECT ON edudatamx.materia TO 'docente_user'@'localhost';
GRANT INSERT, UPDATE ON edudatamx.evaluacion TO 'docente_user'@'localhost';
GRANT INSERT, UPDATE ON edudatamx.asistencia TO 'docente_user'@'localhost';

FLUSH PRIVILEGES;
