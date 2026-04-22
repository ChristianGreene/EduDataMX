CREATE TABLE log_calificaciones (
    id_log INT AUTO_INCREMENT PRIMARY KEY,
    id_estudiante INT,
    calificacion_anterior DECIMAL(5,2),
    fecha_cambio TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

DELIMITER //
CREATE TRIGGER auditoria_notas
BEFORE UPDATE ON evaluacion
FOR EACH ROW
BEGIN
    INSERT INTO log_calificaciones (id_estudiante, calificacion_anterior)
    VALUES (OLD.id_estudiante, OLD.calificacion);
END; //
DELIMITER ;
