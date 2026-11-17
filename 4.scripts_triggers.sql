-- =============================================================================
--  1. EDAD MINIMA DEL USUARIO > 16 AÑOS (RN-04)
-- =============================================================================
DELIMITER //

DROP TRIGGER IF EXISTS usuario_edad_insert;
CREATE TRIGGER usuario_edad_insert BEFORE INSERT ON usuarios
FOR EACH ROW
BEGIN
    IF TIMESTAMPDIFF(YEAR, NEW.fechaNacimiento, CURDATE()) <= 16 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'RN-04: El usuario debe tener más de 16 años.';
    END IF;
END //

DELIMITER ;



-- =============================================================================
--  2. CONDUCTOR MAYOR DE EDAD (RN-03)
-- =============================================================================
DELIMITER //

DROP TRIGGER IF EXISTS conductor_mayor_edad;
CREATE TRIGGER conductor_mayor_edad BEFORE INSERT ON conductores
FOR EACH ROW
BEGIN
    DECLARE fechaNac DATE;
    SELECT fechaNacimiento INTO fechaNac
    FROM usuarios WHERE id = NEW.usuarioId;

    IF TIMESTAMPDIFF(YEAR, fechaNac, CURDATE()) < 18 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'RN-03: El conductor debe ser mayor de edad.';
    END IF;
END //
DELIMITER ;



-- =============================================================================
--  3. FECHAS VIAJE COHERENTES (RN-01)
--     (FHACTUAL < FHSALIDA, solo si está Programado) AND (FHSALIDA < FHLLEGADA)
-- =============================================================================
DELIMITER //

DROP TRIGGER IF EXISTS viaje_fechas_insert;
CREATE TRIGGER viaje_fechas_insert BEFORE INSERT ON viajes
FOR EACH ROW
BEGIN
    IF NEW.estado = 'Programado' AND NEW.fechaHoraSalida <= NOW() THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'RN-01: La fecha de salida debe ser futura.';
    END IF;

    IF NEW.fechaHoraLlegada <= NEW.fechaHoraSalida THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'RN-01: La fecha de llegada debe ser posterior a la de salida.';
    END IF;
END //

DELIMITER ;



-- =============================================================================
--  4. SOLO CONDUCTORES VERIFICADOS PUEDEN PUBLICAR VIAJES (RN-03)
-- =============================================================================
DELIMITER //

DROP TRIGGER IF EXISTS viaje_conductor_verificado;
CREATE TRIGGER viaje_conductor_verificado BEFORE INSERT ON viajes
FOR EACH ROW
BEGIN
    DECLARE verificado BOOLEAN;
    SELECT c.carnetVerificado INTO verificado
    FROM vehiculos ve
    JOIN conductores c ON ve.conductorId = c.id
    WHERE ve.id = NEW.vehiculoId;

    IF verificado = 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'RN-03: El conductor no tiene el carnet verificado.';
    END IF;
END //
DELIMITER ;



-- =============================================================================
--  5. VALORACION SOLO TRAS UN VIAJE FINALIZADO JUNTOS (RI-05, RN-06)
-- =============================================================================
DELIMITER //

DROP TRIGGER IF EXISTS valoracion_validar;
CREATE TRIGGER valoracion_validar BEFORE INSERT ON valoraciones
FOR EACH ROW
BEGIN
    DECLARE viajesTerminados INT;

    IF NEW.estrellas < 1 OR NEW.estrellas > 5 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Error: Las estrellas deben ser de 1 a 5.';
    END IF;
    SELECT COUNT(*) INTO viajesTerminados
    FROM viajes v
    JOIN vehiculos ve ON v.vehiculoId = ve.id
    JOIN reservas r ON r.viajeId = v.id
    WHERE ve.conductorId = COALESCE(NEW.conductorEmisorId, NEW.conductorReceptorId)
      AND r.pasajeroId = COALESCE(NEW.pasajeroEmisorId, NEW.pasajeroReceptorId)
      AND r.estado = 'Aceptada'
      AND v.estado = 'Finalizado';

    IF viajesTerminados = 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'RN-06: No puedes valorar. No habéis completado ningún viaje juntos.';
    END IF;
END //
DELIMITER ;
