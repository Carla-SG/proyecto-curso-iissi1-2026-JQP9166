-- ============================================
--  CO1: CONSULTAS DE VIAJES
-- ============================================

SELECT
    v.id AS viajeId,
    v.fechaHoraSalida,
    v.fechaHoraLlegada,
    po.direccion AS direccionSalida,
    po.localidad AS localidadSalida,
    pd.direccion AS direccionLlegada,
    pd.localidad AS localidadLlegada,
    v.costePlaza,
    v.plazasDisponibles,
    CONCAT(u.nombre, ' ', u.apellidos) AS conductor,
    c.valoracionMedia
FROM viajes v
JOIN puntosfisicos po ON v.origenId = po.id
JOIN puntosfisicos pd ON v.destinoId = pd.id
JOIN vehiculos vh ON v.vehiculoId = vh.id
JOIN conductores c ON vh.conductorId = c.id
JOIN usuarios u ON c.usuarioId = u.id
WHERE v.fechaHoraSalida > NOW()
  AND v.estado NOT IN ('Finalizado', 'Cancelado')
  AND (@origen IS NULL OR po.localidad = @origen)
  AND (@destino IS NULL OR pd.localidad = @destino)
ORDER BY v.fechaHoraSalida ASC;

-- ============================================
--  CO2: CONSULTAS DE CANCELACIONES
-- ============================================

SELECT
    v.id AS viajeId,
    v.fechaHoraSalida,
    v.estado,
    po.localidad AS origen,
    pd.localidad AS destino,
    v.plazasReservadas
FROM viajes v
JOIN puntosfisicos po ON v.origenId = po.id
JOIN puntosfisicos pd ON v.destinoId = pd.id
JOIN vehiculos vh ON v.vehiculoId = vh.id
WHERE vh.conductorId = @conductorId
  AND v.estado = 'Programado'
  AND v.fechaHoraSalida > NOW()
ORDER BY v.fechaHoraSalida ASC;


-- ============================================
--  CO3: CONSULTAS DE RESERVAS
-- ============================================

SELECT
    v.id AS viajeId,
    v.plazasDisponibles,
    (v.plazasDisponibles > 0
        AND v.estado = 'Programado'
        AND v.fechaHoraSalida > NOW()) AS permiteReserva
FROM viajes v
WHERE v.id = @viajeId;

-- ============================================
--  CO4: CONSULTAS DE MENSAJES
-- ============================================

SELECT
    m.fechaHora,
    CASE WHEN m.pasajeroEmisorId IS NOT NULL
         THEN 'Pasajero' ELSE 'Conductor' END AS emisor,
    up.nombre AS pasajero,
    uc.nombre AS conductor,
    m.contenido
FROM mensajes m
JOIN pasajeros p ON p.id = COALESCE(m.pasajeroEmisorId, m.pasajeroReceptorId)
JOIN usuarios up ON p.usuarioId = up.id
JOIN conductores c ON c.id = COALESCE(m.conductorEmisorId, m.conductorReceptorId)
JOIN usuarios uc ON c.usuarioId = uc.id
WHERE p.id = @pasajeroId
  AND c.id = @conductorId
ORDER BY m.fechaHora ASC;


-- ============================================
--  CO5: CONSULTAS DE VALORACIONES (CONDUCTOR)
-- ============================================

(SELECT
    val.fechaHora,
    val.estrellas,
    val.comentario,
    up.nombre AS valoradoPor
 FROM valoraciones val
 JOIN pasajeros p ON val.pasajeroEmisorId = p.id
 JOIN usuarios up ON p.usuarioId = up.id
 WHERE val.conductorReceptorId = @conductorId
 ORDER BY val.fechaHora 
UNION ALL
(SELECT NULL, NULL, 'El usuario aún no tiene valoraciones', NULL
 FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM valoraciones
                   WHERE conductorReceptorId = @conductorId));

-- ============================================
--  CO5: CONSULTAS DE VALORACIONES (PASAJERO)
-- ============================================
(SELECT
    val.fechaHora,
    val.estrellas,
    val.comentario,
    uc.nombre AS valoradoPor
 FROM valoraciones val
 JOIN conductores c ON val.conductorEmisorId = c.id
 JOIN usuarios uc ON c.usuarioId = uc.id
 WHERE val.pasajeroReceptorId = @pasajeroId
 ORDER BY val.fechaHora DESC;
UNION ALL
(SELECT NULL, NULL, 'El usuario aún no tiene valoraciones', NULL
 FROM DUAL
 WHERE NOT EXISTS (SELECT 1 FROM valoraciones
                   WHERE pasajeroReceptorId = @pasajeroId));

-- ============================================
--  CO6: CONSULTAS DE PAGOS
-- ============================================

SELECT
    pg.id AS pagoId,
    pg.importe,
    pg.estado AS estadoPago,
    pg.fechaHora AS fechaHoraPago,
    po.localidad AS origen,
    pd.localidad AS destino,
    v.fechaHoraSalida
FROM pagos pg
JOIN reservas r ON pg.reservaId = r.id
JOIN viajes v ON r.viajeId = v.id
JOIN puntosfisicos po ON v.origenId = po.id
JOIN puntosfisicos pd ON v.destinoId = pd.id
WHERE r.pasajeroId = @pasajeroId
ORDER BY pg.fechaHora DESC;


-- ============================================
--  CO7: CONSULTAS DE USUARIOS
-- ============================================
SELECT
    u.id,
    u.nombre,
    u.apellidos,
    u.email,
    u.telefono,
    CASE
        WHEN a.id IS NOT NULL THEN 'Administrador'
        WHEN c.id IS NOT NULL THEN 'Conductor'
        WHEN p.id IS NOT NULL THEN 'Pasajero'
        ELSE 'Sin rol'
    END AS rol
FROM usuarios u
LEFT JOIN administradores a ON a.usuarioId = u.id
LEFT JOIN conductores c ON c.usuarioId = u.id
LEFT JOIN pasajeros p ON p.usuarioId = u.id
ORDER BY u.apellidos, u.nombre;


-- ============================================
--  CO8: CONSULTAS DE VEHÍCULOS
-- ============================================
SELECT
    vh.id AS vehiculoId,
    vh.matricula,
    vh.marca,
    vh.modelo,
    vh.color,
    vh.plazas
FROM vehiculos vh
JOIN conductores c ON vh.conductorId = c.id
WHERE vh.conductorId = @conductorId
  AND c.carnetVerificado = TRUE
  AND REPLACE(vh.matricula, ' ', '') REGEXP '^[0-9]{4}[BCDFGHJKLMNPRSTVWXYZ]{3}$'
  AND NOT EXISTS (
        SELECT 1
        FROM viajes v
        WHERE v.vehiculoId = vh.id
          AND v.estado <> 'Cancelado'
          AND v.fechaHoraSalida < @llegada
          AND v.fechaHoraLlegada > @salida
      );


-- ============================================
--  CO9: CONSULTAS MOTIVOS DE CANCELACIÓN
-- ============================================

SELECT
    v.id AS viajeId,
    v.fechaHoraSalida,
    po.localidad AS origen,
    pd.localidad AS destino,
    v.motivoCancelacion,
    r.id AS reservaId,
    r.estado AS estadoReserva,
    CONCAT(uc.nombre, ' ', uc.apellidos) AS conductor
FROM reservas r
JOIN viajes v ON r.viajeId = v.id
JOIN puntosfisicos po ON v.origenId = po.id
JOIN puntosfisicos pd ON v.destinoId = pd.id
JOIN vehiculos vh ON v.vehiculoId = vh.id
JOIN conductores c ON vh.conductorId = c.id
JOIN usuarios uc ON c.usuarioId = uc.id
WHERE r.pasajeroId = @pasajeroId
  AND v.estado = 'Cancelado'
ORDER BY v.fechaHoraSalida DESC;

-- ============================================
--  C10: CONSULTAS DE VIAJE POR RANGO DE FECHAS
-- ============================================
SELECT
    v.id AS viajeId,
    v.fechaHoraSalida,
    po.localidad AS origen,
    pd.localidad AS destino,
    v.costePlaza,
    v.plazasDisponibles
FROM viajes v
JOIN puntosfisicos po ON v.origenId = po.id
JOIN puntosfisicos pd ON v.destinoId = pd.id
WHERE @fechaInicio <= @fechaFin
  AND DATE(v.fechaHoraSalida) BETWEEN @fechaInicio AND @fechaFin
  AND v.fechaHoraSalida > NOW()
  AND v.estado NOT IN ('Finalizado', 'Cancelado')
ORDER BY v.fechaHoraSalida ASC;


-- ============================================
--  C11: CONSULTAS DE VIAJES POR LOCALIDAD ORIGEN
-- ============================================
SELECT
    v.id AS viajeId,
    v.fechaHoraSalida,
    po.direccion AS direccionSalida,
    po.localidad AS origen,
    pd.localidad AS destino,
    v.costePlaza,
    v.plazasDisponibles
FROM viajes v
JOIN puntosfisicos po ON v.origenId = po.id
JOIN puntosfisicos pd ON v.destinoId = pd.id
WHERE po.localidad = @origen
  AND v.fechaHoraSalida > NOW()
  AND v.estado NOT IN ('Finalizado', 'Cancelado')
ORDER BY v.fechaHoraSalida ASC;

SELECT 'No hay viajes que salgan de esa localidad' AS mensaje
FROM DUAL
WHERE NOT EXISTS (
    SELECT 1
    FROM viajes v
    JOIN puntosfisicos po ON v.origenId = po.id
    WHERE po.localidad = @origen
      AND v.fechaHoraSalida > NOW()
      AND v.estado NOT IN ('Finalizado', 'Cancelado')
);

-- ============================================
--  CU1: RANKING CONDUCTORES
-- ============================================
DELIMITER //

CREATE OR REPLACE PROCEDURE p_asignar_medallas()
BEGIN
    DECLARE done INT DEFAULT FALSE;
    DECLARE v_nombre VARCHAR(50);
    DECLARE v_apellido VARCHAR(50);
    DECLARE v_fiabilidad INT;
    DECLARE v_medalla VARCHAR(100);

    DECLARE cur_medallas CURSOR FOR 
        SELECT u.nombre, u.apellidos, c.tasaFiabilidad 
        FROM Conductores c
        JOIN Usuarios u ON c.usuarioId = u.id;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;
    DROP TEMPORARY TABLE IF EXISTS ResumenMedallas;
    CREATE TEMPORARY TABLE ResumenMedallas (
        Conductores VARCHAR(100),
        Puntos INT,
        Distincion VARCHAR(100)
    );
    
    OPEN cur_medallas;
    read_loop: LOOP
        FETCH cur_medallas INTO v_nombre, v_apellido, v_fiabilidad;

        IF done THEN
            LEAVE read_loop;
        END IF;

        IF v_fiabilidad >= 90 THEN
            SET v_medalla = 'As del Asfalto';
        ELSEIF v_fiabilidad >= 70 THEN
            SET v_medalla = 'Maestro de la Ruta';
        ELSEIF v_fiabilidad >= 30 THEN
            SET v_medalla = 'Conductor Fiable';
         ELSEIF v_fiabilidad >= 0 THEN
            SET v_medalla = 'Conductor Estandar';
         else
         	SET v_medalla = 'Conductor de Riesgo';
        END IF;

        INSERT INTO ResumenMedallas (Conductores, Puntos, Distincion)
        VALUES (CONCAT(v_nombre, ' ', v_apellido), v_fiabilidad, v_medalla);

    END LOOP;
    CLOSE cur_medallas;
    SELECT * FROM ResumenMedallas ORDER BY Puntos DESC;
    DROP TEMPORARY TABLE ResumenMedallas;
END //
DELIMITER ;