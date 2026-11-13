-- ============================================
--  F1: CALCULAR PLAZAS DISPONIBLES
-- ============================================
DELIMITER //
CREATE OR REPLACE FUNCTION f_plazas_disponibles(p_viajeId INT)
RETURNS INT
BEGIN
    DECLARE v_plazas_vehiculo INT;
    DECLARE v_ocupadas INT;

    -- Obtenemos el total de plazas del vehículo asignado al viaje
    SELECT vh.plazas INTO v_plazas_vehiculo
    FROM viajes v
    JOIN vehiculos vh ON v.vehiculoId = vh.id
    WHERE v.id = p_viajeId;

    -- Contamos las reservas activas (no canceladas)
    SELECT COUNT(*) INTO v_ocupadas
    FROM reservas
    WHERE viajeId = p_viajeId
      AND estado != 'Cancelada';

    RETURN (v_plazas_vehiculo - v_ocupadas);
END //
DELIMITER ;

-- ============================================
--  F2: CALCULAR TASA DE FIABILIDAD
-- ============================================
DELIMITER //
CREATE OR REPLACE FUNCTION f_tasa_fiabilidad(p_conductorId INT)
RETURNS INT
BEGIN
    DECLARE v_resultado INT;
    DECLARE v_viajes_cancelados INT;
    DECLARE v_viajes_finalizados INT;

    SELECT COUNT(*) INTO v_viajes_cancelados
    FROM viajes v
    JOIN vehiculos vh ON v.vehiculoId = vh.id
    WHERE vh.conductorId = p_conductorId
      AND v.estado = 'Cancelado';

    SELECT COUNT(*) INTO v_viajes_finalizados
    FROM viajes v
    JOIN vehiculos vh ON v.vehiculoId = vh.id
    WHERE vh.conductorId = p_conductorId
      AND v.estado = 'Finalizado';

    SET v_resultado = 100 - (v_viajes_cancelados * 10) + v_viajes_finalizados;

    IF v_resultado < -100 THEN
        RETURN -100;
    ELSEIF v_resultado > 100 THEN
        RETURN 100;
    ELSE
        RETURN v_resultado;
    END IF;
END //
DELIMITER ;

-- ============================================
--  F3: CALCULAR PRECIO RECOMENDADO (RI-07)
-- ============================================
DELIMITER //
CREATE OR REPLACE FUNCTION f_precio_recomendado(
    p_distancia DECIMAL(6,2),
    p_consumo DECIMAL(4,2),
    p_extras DECIMAL(5,2)
)
RETURNS DECIMAL(5,2)
BEGIN
    DECLARE v_precio_litro DECIMAL(4,2) DEFAULT 1.50;
    DECLARE v_coste_combustible DECIMAL(6,2);
    DECLARE v_subtotal DECIMAL(6,2);
    DECLARE v_precio_final DECIMAL(5,2);

    -- Coste de combustible según distancia (km) y consumo (l/100km)
    SET v_coste_combustible = ((p_consumo / 100) * p_distancia) * v_precio_litro;
    
    -- Suma de combustible + extras (peajes) + comisión CharlaCar (15%)
    SET v_subtotal = v_coste_combustible + IFNULL(p_extras, 0.00);
    SET v_precio_final = v_subtotal * 1.15;

    RETURN v_precio_final;
END //
DELIMITER ;

-- ============================================
--  F4: OBTENER IMPORTE DEL VIAJE
-- ============================================
DELIMITER //
CREATE OR REPLACE FUNCTION f_importe(p_viajeId INT)
RETURNS DECIMAL(5,2)
BEGIN
    DECLARE v_resultado DECIMAL(5,2);

    SELECT costePlaza INTO v_resultado
    FROM viajes
    WHERE id = p_viajeId;

    RETURN v_resultado;
END //
DELIMITER ;

-- ============================================
--  P1: CREAR VIAJE (RN-01, RN-03, RI-03)
-- ============================================
DELIMITER //
CREATE OR REPLACE PROCEDURE p_crear_viaje(
    IN p_vehiculoId INT,
    IN p_origenId INT,
    IN p_destinoId INT,
    IN p_fechaHoraSalida DATETIME,
    IN p_fechaHoraLlegada DATETIME,
    IN p_costePlaza DECIMAL(5,2),
    IN p_distancia DECIMAL(6,2)
)
BEGIN
    DECLARE v_verificado BOOLEAN;
    DECLARE v_plazas_totales INT;

    -- RI-03: Origen y destino no pueden ser el mismo punto físico
    IF p_origenId = p_destinoId THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Error (RI-03): El punto de origen y destino no pueden ser iguales.';
    END IF;

    -- RN-01: Fecha de salida futura y llegada posterior a salida
    IF p_fechaHoraSalida <= NOW() THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Error (RN-01): La fecha de salida debe ser futura.';
    END IF;

    IF p_fechaHoraLlegada <= p_fechaHoraSalida THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Error (RN-01): La fecha de llegada debe ser posterior a la de salida.';
    END IF;

    -- RN-03: Comprobar que el conductor tiene el carnet verificado
    SELECT c.carnetVerificado, vh.plazas
    INTO v_verificado, v_plazas_totales
    FROM vehiculos vh
    JOIN conductores c ON vh.conductorId = c.id
    WHERE vh.id = p_vehiculoId;

    IF v_verificado IS NULL THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Error: El vehículo especificado no existe.';
    END IF;

    IF v_verificado = FALSE THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Error (RN-03): El conductor no tiene el carnet verificado.';
    END IF;

    -- Insertar viaje en estado 'Programado' con todas las plazas del vehículo disponibles
    INSERT INTO viajes (
        vehiculoId, origenId, destinoId, plazasDisponibles,
        fechaHoraSalida, estado, distancia, fechaHoraLlegada,
        costePlaza, plazasReservadas
    ) VALUES (
        p_vehiculoId, p_origenId, p_destinoId, v_plazas_totales,
        p_fechaHoraSalida, 'Programado', p_distancia, p_fechaHoraLlegada,
        p_costePlaza, 0
    );
END //
DELIMITER ;

-- ============================================
--  P2: VALIDAR CONDUCTOR (RN-03, RN-04)
-- ============================================
DELIMITER //
CREATE OR REPLACE PROCEDURE p_validar_conductor(
    IN p_conductorId INT
)
BEGIN
    DECLARE v_foto VARCHAR(255);
    DECLARE v_fecha_nac DATE;

    SELECT c.fotoCarnet, u.fechaNacimiento
    INTO v_foto, v_fecha_nac
    FROM conductores c
    JOIN usuarios u ON c.usuarioId = u.id
    WHERE c.id = p_conductorId;

    IF v_fecha_nac IS NULL THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Error: El conductor no existe.';
    END IF;

    -- RN-03: Debe ser mayor de edad (18 años)
    IF TIMESTAMPDIFF(YEAR, v_fecha_nac, CURDATE()) < 18 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Error (RN-03): El conductor debe ser mayor de edad.';
    END IF;

    -- Comprobar foto del carnet subida
    IF v_foto IS NULL OR TRIM(v_foto) = '' THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Error: No se puede validar si no hay foto del carnet.';
    END IF;

    UPDATE conductores
    SET carnetVerificado = TRUE
    WHERE id = p_conductorId;
END //
DELIMITER ;

-- ============================================
--  P3: REALIZAR RESERVA (RF-03)
-- ============================================
DELIMITER //
CREATE OR REPLACE PROCEDURE p_realizar_reserva(
    IN p_viajeId INT,
    IN p_pasajeroId INT
)
BEGIN
    DECLARE v_plazas_libres INT;
    DECLARE v_estado_viaje VARCHAR(20);

    SELECT estado INTO v_estado_viaje
    FROM viajes
    WHERE id = p_viajeId;

    IF v_estado_viaje IS NULL OR v_estado_viaje != 'Programado' THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Error: El viaje no existe o no está disponible para reservar.';
    END IF;

    -- RF-03: Consultar si hay plazas disponibles
    SET v_plazas_libres = f_plazas_disponibles(p_viajeId);

    IF v_plazas_libres <= 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Error (RF-03): No hay plazas disponibles en este viaje.';
    END IF;

    -- Insertar reserva en estado 'Solicitada'
    INSERT INTO reservas (pasajeroId, viajeId, fechaHora, estado)
    VALUES (p_pasajeroId, p_viajeId, NOW(), 'Solicitada');

    -- Actualizar contadores de plazas en viajes
    UPDATE viajes
    SET plazasDisponibles = plazasDisponibles - 1,
        plazasReservadas = plazasReservadas + 1
    WHERE id = p_viajeId;
END //
DELIMITER ;

-- ============================================
--  P4: CANCELAR RESERVA - PASAJERO (RN-02)
-- ============================================
DELIMITER //
CREATE OR REPLACE PROCEDURE p_cancelar_reserva(
    IN p_reservaId INT,
    IN p_pasajeroId INT
)
BEGIN
    DECLARE v_viajeId INT;
    DECLARE v_estado_reserva VARCHAR(20);
    DECLARE v_fecha_salida DATETIME;
    DECLARE v_horas_antelacion INT;
    DECLARE v_importe_pagado DECIMAL(5,2);

    SELECT r.viajeId, r.estado, v.fechaHoraSalida
    INTO v_viajeId, v_estado_reserva, v_fecha_salida
    FROM reservas r
    JOIN viajes v ON r.viajeId = v.id
    WHERE r.id = p_reservaId
      AND r.pasajeroId = p_pasajeroId;

    IF v_viajeId IS NULL THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Error: La reserva no existe o no pertenece a este pasajero.';
    END IF;

    IF v_estado_reserva = 'Cancelada' THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Error: La reserva ya estaba cancelada.';
    END IF;

    -- Cancelar reserva y liberar plaza
    UPDATE reservas
    SET estado = 'Cancelada'
    WHERE id = p_reservaId;

    UPDATE viajes
    SET plazasDisponibles = plazasDisponibles + 1,
        plazasReservadas = plazasReservadas - 1
    WHERE id = v_viajeId;

    -- RN-02: Política de reembolso según antelación
    SET v_horas_antelacion = TIMESTAMPDIFF(HOUR, NOW(), v_fecha_salida);

    SELECT importe INTO v_importe_pagado
    FROM pagos
    WHERE reservaId = p_reservaId AND estado = 'Exitoso'
    LIMIT 1;

    IF v_importe_pagado IS NOT NULL THEN
        IF v_horas_antelacion >= 24 THEN
            -- Reembolso 100%
            UPDATE pagos SET estado = 'Reembolsado' WHERE reservaId = p_reservaId AND estado = 'Exitoso';
        ELSEIF v_horas_antelacion > 0 AND v_horas_antelacion < 24 THEN
            -- Reembolso 50%
            UPDATE pagos
            SET estado = 'Reembolsado',
                importe = v_importe_pagado * 0.50
            WHERE reservaId = p_reservaId AND estado = 'Exitoso';
        END IF;
        -- Si v_horas_antelacion <= 0 (iniciado o pasado), no se reembolsa nada
    END IF;
END //
DELIMITER ;

-- ============================================
--  P5: CANCELAR VIAJE - CONDUCTOR (RF-02, RN-02)
-- ============================================
DELIMITER //
CREATE OR REPLACE PROCEDURE p_cancelar_viaje(
    IN p_viajeId INT,
    IN p_conductorId INT
)
BEGIN
    DECLARE v_estado_actual VARCHAR(20);
    DECLARE v_es_propietario INT;

    SELECT COUNT(*) INTO v_es_propietario
    FROM viajes v
    JOIN vehiculos vh ON v.vehiculoId = vh.id
    WHERE v.id = p_viajeId
      AND vh.conductorId = p_conductorId;

    IF v_es_propietario = 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Error: No puedes cancelar este viaje porque no eres el conductor asignado.';
    END IF;

    SELECT estado INTO v_estado_actual
    FROM viajes
    WHERE id = p_viajeId;

    -- RF-02: Solo se puede cancelar si no ha comenzado ni está ya cancelado
    IF v_estado_actual != 'Programado' THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Error (RF-02): Solo se pueden cancelar viajes en estado Programado.';
    END IF;

    UPDATE viajes
    SET estado = 'Cancelado'
    WHERE id = p_viajeId;

    -- Cancelar reservas asociadas y reembolsar pagos exitosos
    UPDATE reservas
    SET estado = 'Cancelada'
    WHERE viajeId = p_viajeId AND estado != 'Cancelada';

    UPDATE pagos p
    JOIN reservas r ON p.reservaId = r.id
    SET p.estado = 'Reembolsado'
    WHERE r.viajeId = p_viajeId AND p.estado = 'Exitoso';
END //
DELIMITER ;

-- ============================================
--  P6: BUSCAR VIAJES (RF-01, RF-09, RF-12)
-- ============================================
DELIMITER //
CREATE OR REPLACE PROCEDURE p_buscar_viajes(
    IN p_localidad_origen VARCHAR(100),
    IN p_localidad_destino VARCHAR(100),
    IN p_fecha DATE
)
BEGIN
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
        v.distancia,
        v.estado,
        u.nombre AS nombreConductor,
        c.valoracionMedia,
        f_tasa_fiabilidad(c.id) AS tasaFiabilidad
    FROM viajes v
    JOIN puntosfisicos po ON v.origenId = po.id
    JOIN puntosfisicos pd ON v.destinoId = pd.id
    JOIN vehiculos vh ON v.vehiculoId = vh.id
    JOIN conductores c ON vh.conductorId = c.id
    JOIN usuarios u ON c.usuarioId = u.id
    WHERE po.localidad LIKE CONCAT('%', p_localidad_origen, '%')
      AND pd.localidad LIKE CONCAT('%', p_localidad_destino, '%')
      AND (p_fecha IS NULL OR DATE(v.fechaHoraSalida) = p_fecha)
      AND v.estado = 'Programado'
      AND v.plazasDisponibles > 0
    ORDER BY v.fechaHoraSalida ASC;
END //
DELIMITER ;

-- ============================================
--  P7: VER HISTORIAL DE VIAJES (RI-02, RI-04)
-- ============================================
DELIMITER //
CREATE OR REPLACE PROCEDURE p_historial_viajes(
    IN p_usuarioId INT
)
BEGIN
    -- Historial como CONDUCTOR (RI-02: incluye realizados y cancelados)
    SELECT
        'Conductor' AS rol,
        v.id AS viajeId,
        v.fechaHoraSalida,
        v.fechaHoraLlegada,
        po.localidad AS origen,
        pd.localidad AS destino,
        v.distancia,
        v.estado AS estadoViaje,
        NULL AS estadoReserva
    FROM viajes v
    JOIN puntosfisicos po ON v.origenId = po.id
    JOIN puntosfisicos pd ON v.destinoId = pd.id
    JOIN vehiculos vh ON v.vehiculoId = vh.id
    JOIN conductores c ON vh.conductorId = c.id
    WHERE c.usuarioId = p_usuarioId

    UNION ALL

    -- Historial como PASAJERO (RI-04: si un viaje se cancela, desaparece del listado)
    SELECT
        'Pasajero' AS rol,
        v.id AS viajeId,
        v.fechaHoraSalida,
        v.fechaHoraLlegada,
        po.localidad AS origen,
        pd.localidad AS destino,
        v.distancia,
        v.estado AS estadoViaje,
        r.estado AS estadoReserva
    FROM reservas r
    JOIN pasajeros p ON r.pasajeroId = p.id
    JOIN viajes v ON r.viajeId = v.id
    JOIN puntosfisicos po ON v.origenId = po.id
    JOIN puntosfisicos pd ON v.destinoId = pd.id
    WHERE p.usuarioId = p_usuarioId
      AND v.estado != 'Cancelado'
    ORDER BY fechaHoraSalida DESC;
END //
DELIMITER ;

-- ============================================
--  P8: ENVIAR MENSAJE (RI-06)
-- ============================================
DELIMITER //
CREATE OR REPLACE PROCEDURE p_enviar_mensaje(
    IN p_viajeId INT,
    IN p_conductor_emisorId INT,
    IN p_conductor_receptorId INT,
    IN p_pasajero_emisorId INT,
    IN p_pasajero_receptorId INT,
    IN p_contenido TEXT
)
BEGIN
    DECLARE v_estado_viaje VARCHAR(20);

    SELECT estado INTO v_estado_viaje
    FROM viajes
    WHERE id = p_viajeId;

    IF v_estado_viaje IS NULL THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Error: El viaje no existe.';
    END IF;

    -- RI-06: No se podrán enviar mensajes si el viaje ha finalizado
    IF v_estado_viaje = 'Finalizado' THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Error (RI-06): No se pueden enviar mensajes en un viaje ya finalizado.';
    END IF;

    INSERT INTO mensajes (
        pasajeroEmisorId, pasajeroReceptorId,
        conductorEmisorId, conductorReceptorId,
        contenido, fechaHora
    ) VALUES (
        p_pasajero_emisorId, p_pasajero_receptorId,
        p_conductor_emisorId, p_conductor_receptorId,
        p_contenido, NOW()
    );
END //
DELIMITER ;

-- ============================================
--  P9: CREAR VALORACION (RI-05, RN-06)
-- ============================================
DELIMITER //
CREATE OR REPLACE PROCEDURE p_crear_valoracion(
    IN p_viajeId INT,
    IN p_conductor_emisorId INT,
    IN p_conductor_receptorId INT,
    IN p_pasajero_emisorId INT,
    IN p_pasajero_receptorId INT,
    IN p_estrellas INT,
    IN p_comentario TEXT
)
BEGIN
    DECLARE v_estado_viaje VARCHAR(20);
    DECLARE v_participacion INT DEFAULT 0;

    -- Validar rango de estrellas (1 a 5)
    IF p_estrellas < 1 OR p_estrellas > 5 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Error: La puntuación debe estar entre 1 y 5 estrellas.';
    END IF;

    SELECT estado INTO v_estado_viaje
    FROM viajes
    WHERE id = p_viajeId;

    -- RI-05 / RN-06: Solo se puede valorar tras finalizar el viaje
    IF v_estado_viaje IS NULL OR v_estado_viaje != 'Finalizado' THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Error (RI-05): Solo se pueden publicar valoraciones cuando el viaje ha finalizado.';
    END IF;

    -- RN-06: Comprobar que conductor y pasajero han compartido ese viaje
    SELECT COUNT(*) INTO v_participacion
    FROM viajes v
    JOIN vehiculos vh ON v.vehiculoId = vh.id
    JOIN reservas r ON r.viajeId = v.id
    WHERE v.id = p_viajeId
      AND r.estado = 'Aceptada'
      AND (
          (vh.conductorId = p_conductor_emisorId AND r.pasajeroId = p_pasajero_receptorId)
          OR
          (r.pasajeroId = p_pasajero_emisorId AND vh.conductorId = p_conductor_receptorId)
      );

    IF v_participacion = 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Error (RN-06): Solo puedes valorar a usuarios con los que hayas compartido este viaje.';
    END IF;

    INSERT INTO valoraciones (
        pasajeroEmisorId, pasajeroReceptorId,
        conductorEmisorId, conductorReceptorId,
        estrellas, comentario, fechaHora
    ) VALUES (
        p_pasajero_emisorId, p_pasajero_receptorId,
        p_conductor_emisorId, p_conductor_receptorId,
        p_estrellas, p_comentario, NOW()
    );

    -- Actualizar valoracionMedia del conductor si fue el receptor
    IF p_conductor_receptorId IS NOT NULL THEN
        UPDATE conductores
        SET valoracionMedia = (
            SELECT IFNULL(AVG(estrellas), 0)
            FROM valoraciones
            WHERE conductorReceptorId = p_conductor_receptorId
        )
        WHERE id = p_conductor_receptorId;
    END IF;
END //
DELIMITER ;