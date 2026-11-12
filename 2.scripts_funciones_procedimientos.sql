-- ============================================
--  F1: CALCULAR PLAZAS DISPONIBLES
-- ============================================
DELIMITER //
CREATE OR REPLACE FUNCTION f_plazas_disponibles(p_viajeId INT)
RETURNS INT
BEGIN
	DECLARE v_total INT;
	DECLARE v_ocupadas INT;
   DECLARE v_cancelada_id INT;
   
   SELECT id INTO v_cancelada_id FROM EstadosReserva WHERE nombre = 'Cancelada';
	
	SELECT plazasTotales INTO v_total
	FROM Viajes WHERE Id = p_viajeId;
	
	SELECT COUNT(*) INTO v_ocupadas 
   FROM Reservas 
   WHERE viajeId = p_viajeId AND estadoId != v_cancelada_id;

   RETURN (v_total - v_ocupadas);
END//
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
   FROM Viajes v
   JOIN Vehiculos ON v.vehiculoId = Vehiculos.id
   JOIN EstadosViaje ON v.estadoId = EstadosViaje.id
   WHERE Vehiculos.conductorId = p_conductorId
      AND EstadosViaje.nombre = "Cancelado";

   SELECT COUNT(*) INTO v_viajes_finalizados
   FROM Viajes v
   JOIN Vehiculos ON v.vehiculoId = Vehiculos.id
   JOIN EstadosViaje ON v.estadoId = EstadosViaje.id
   WHERE Vehiculos.conductorId = p_conductorId
      AND EstadosViaje.nombre = "Finalizado";

   SET v_resultado = 100 - (v_viajes_cancelados * 10) + v_viajes_finalizados;
  
   IF v_resultado < -100 THEN 
      RETURN -100;
   ELSEIF v_resultado > 100 THEN
   	RETURN 100;
	ELSE 
      RETURN v_resultado;
   END IF;
END//
DELIMITER ;
-- ============================================
--  F3: CALCULAR PRECIO RECOMENDADO
-- ============================================
DELIMITER //
CREATE OR REPLACE FUNCTION f_precio_recomendado(p_distancia DECIMAL(6,2), p_consumo DECIMAL(5,2))
RETURNS DECIMAL(5,2)
BEGIN
    DECLARE v_coste_base DECIMAL(5,2);
    DECLARE v_precio_final DECIMAL(5,2);
    DECLARE v_precio_litro DECIMAL(4,2) DEFAULT 1.50; 
    DECLARE v_extras DECIMAL(4,2) DEFAULT 2.00;       

    -- Coste combustible
    SET v_coste_base = ((p_consumo / 100) * p_distancia) * v_precio_litro;
    
    -- Sumar extras y Comisión (15%)
    SET v_coste_base = v_coste_base + v_extras;
    SET v_precio_final = v_coste_base * 1.15;

    RETURN v_precio_final;
END //
DELIMITER ;
-- ============================================
--  F4: IGUALAR IMPORTE A COSTE_PLAZA
-- ============================================
DELIMITER //
CREATE OR REPLACE FUNCTION f_importe(p_viajeId INT)
RETURNS DECIMAL(5,2)
BEGIN
   DECLARE v_resultado DECIMAL(5,2);
    
   SELECT costePlaza INTO v_resultado
   FROM Viajes WHERE id = p_viajeId;
	
	RETURN v_resultado;
END //
DELIMITER ;



-- ============================================
--  P1: CREAR VIAJE
-- ============================================
DELIMITER //
CREATE OR REPLACE PROCEDURE pCrearViaje(
    IN fs DATETIME, 
    IN fl DATETIME,
    IN ds VARCHAR(50),
    IN dl VARCHAR(50),
    IN c DECIMAL(5,2),
    IN p INT,
    IN d DECIMAL(6,2))
BEGIN 
    DECLARE v_vehiculoId INT DEFAULT 1; 
    DECLARE v_origenId INT DEFAULT 1;
    DECLARE v_destinoId INT DEFAULT 2;
    DECLARE v_estado ENUM('Pendiente', 'Encurso', 'Finalizado', 'Cancelado') DEFAULT 'Pendiente';

    INSERT INTO Viajes (
        vehiculoId, localidadSalidaId, localidadLlegadaId, estadoId,
        fechaHoraSalida, fechaHoraLlegada, direccionSalida, direccionLlegada,
        costePlaza, plazasTotales, distancia
    ) VALUES (
        v_vehiculoId, v_origenId, v_destinoId, v_estado,
        fs, fl, ds, dl, c, p, d
    );
END //
DELIMITER ;



-- ============================================
--  P2: EDITAR VIAJE
-- ============================================
DELIMITER //
CREATE OR REPLACE PROCEDURE p_editar_viaje(
	IN p_viajeId INT,
	IN p_nueva_fecha DATETIME,
	IN p_nuevo_coste DECIMAL(5, 2),
	IN p_nuevas_plazas INT
)
BEGIN
	DECLARE v_fecha_actual DATETIME;
   DECLARE v_fecha_viaje DATETIME;
   DECLARE v_duracion_minutos INT;

   SELECT fechaHoraSalida, 
           TIMESTAMPDIFF(MINUTE, fechaHoraSalida, fechaHoraLlegada) 
    INTO v_fecha_viaje, v_duracion_minutos
    FROM Viajes WHERE id = p_viajeId;

    SET v_fecha_actual = NOW();

    IF v_fecha_viaje < v_fecha_actual THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Error: No se puede editar un viaje que ya ha pasado o comenzado.';
    ELSE
        -- Actualizamos Salida Y CALCULAMOS la nueva Llegada sumando la duración
        UPDATE Viajes 
        SET fechaHoraSalida = p_nueva_fecha,
            fechaHoraLlegada = DATE_ADD(p_nueva_fecha, INTERVAL v_duracion_minutos MINUTE),
            costePlaza = p_nuevo_coste, 
            plazasTotales = p_nuevas_plazas
        WHERE id = p_viajeId;
    END IF;
END //
DELIMITER ;
	
	 

-- ============================================
--  P3: VALIDAR CONDUCTOR
-- ============================================
DELIMITER //
CREATE OR REPLACE PROCEDURE p_validar_conductor(
    IN p_conductorId INT
)
BEGIN
    DECLARE v_foto VARCHAR(255);
    SELECT fotoCarnet INTO v_foto FROM Conductores WHERE id = p_conductorId;
    IF v_foto IS NULL OR v_foto = '' THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Error: No se puede validar si no hay foto del carnet.';
    END IF;
    UPDATE Conductores 
    SET carnetVerificado = TRUE 
    WHERE id = p_conductorId;
END //
DELIMITER ;



-- ============================================
--  P4: REALIZAR RESERVA
-- ============================================
DELIMITER //
CREATE OR REPLACE PROCEDURE p_realizar_reserva(
	IN p_viajeId INT,
	IN p_pasajeroId INT
)
BEGIN
	DECLARE v_plazas_libres INT;
   DECLARE v_estado_confirmada INT;
	
	SET v_plazas_libres = f_plazas_disponibles(p_viajeId);

   IF v_plazas_libres <= 0 THEN
   	SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Error: No hay suficientes plazas disponibles para esta reserva.';
   END IF;


   SELECT id INTO v_estado_confirmada 
   FROM EstadoReserva 
   WHERE nombre = 'Solicitada' LIMIT 1;

	
	
	INSERT INTO Reservas (
      viajeId, 
      pasajeroId,  
      estadoId, 
      fechaHora
   ) 
   VALUES (
      p_viajeId, 
      p_pasajeroId, 
      v_estado_confirmada, 
      NOW()
   );
END //

DELIMITER ;


-- ============================================
--  P5: CANCELAR RESERVA(PASAJERO)
-- ============================================
DELIMITER //
CREATE OR REPLACE PROCEDURE p_cancelar_reserva(
   IN p_reservaId INT,
   IN p_pasajeroId INT
)
BEGIN
   DECLARE v_estado_cancelada INT;
    
   SELECT id INTO v_estado_cancelada 
   FROM EstadoReserva 
   WHERE nombre = 'Cancelada' LIMIT 1;
    
   UPDATE Reservas 
   SET estadoId = v_estado_cancelada
   WHERE id = p_reservaId 
   	AND pasajeroId = p_pasajeroId; 
   IF ROW_COUNT() = 0 THEN
      SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Error: La reserva no existe o no pertenece a este usuario.';
   END IF;

END //

DELIMITER ;


-- ============================================
--  P6: CANCELAR VIAJE(CONDUCTOR)
-- ============================================
DELIMITER //
CREATE OR REPLACE PROCEDURE p_cancelar_viaje(
	IN p_viajeId INT,
   IN p_conductorId INT
)
BEGIN
   DECLARE v_estado_cancelado INT;
   DECLARE v_es_propietario INT;

   SELECT COUNT(*) INTO v_es_propietario
   FROM Viajes v
   JOIN Vehiculos ve ON v.vehiculoId = ve.Id 
   WHERE v.id = p_viajeId 
   	AND ve.conductorId = p_conductorId;  

   IF v_es_propietario = 0 THEN
   	SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Error: No puedes cancelar este viaje porque no eres el conductor asignado.';
   ELSE
   	SELECT Id INTO v_estado_cancelado 
      FROM EstadoViaje 
      WHERE nombre = 'Cancelado' LIMIT 1;

      UPDATE Viajes 
      SET estadoId = v_estado_cancelado
      WHERE id = p_viajeId;
        
   END IF;
END //

DELIMITER ;


-- ============================================
--  P7: BUSCAR VIAJES
-- ============================================
DELIMITER //
CREATE OR REPLACE PROCEDURE p_buscar_viajes(
	IN p_origen VARCHAR(50),
	IN p_destino VARCHAR(50),
	IN p_fecha DATETIME
)
BEGIN 
	SELECT 
		v.fechaHoraSalida,
		v.fechaHoraLlegada,
   	    v.direccionSalida,
   	    v.direccionLlegada, 
   	    v.costePlaza,
		v.plazasTotales,
		v.distancia,
		ev.nombre,		
		f_plazas_disponibles(v.id) AS plazas_disponibles
	FROM Viajes v	    
	JOIN Vehiculos vh ON 	v.vehiculoId = vh.id
	JOIN Conductores c ON vh.conductorId = c.id
	JOIN EstadosViaje ev ON v.estadoId = ev.id
   WHERE 
		v.direccionSalida LIKE CONCAT('%', p_origen, '%')
		AND v.direccionLlegada LIKE CONCAT('%', p_destino, '%')
		AND DATE(v.fechaHoraSalida) = p_fecha
		AND ev.nombre != 'Cancelado'
		AND f_plazas_disponibles(v.id) > 0;
END//
DELIMITER ;

-- ============================================
--  P8: VER HISTORIAL VIAJES
-- ============================================
DELIMITER //
CREATE OR REPLACE PROCEDURE p_historial_viajes(
	IN p_usuarioId INT
)
BEGIN
	-- Historial como CONDUCTOR
	SELECT
		'Conductor' AS rol,
		v.fechaHoraSalida,
		v.fechaHoraLlegada,
   	    v.direccionSalida,
    	v.direccionLlegada, 
   	    v.distancia,
		ev.nombre
	FROM Viajes v
	JOIN Vehiculos vh ON v.vehiculoId = vh.id
	JOIN Conductores c ON vh.conductorId = c.id
	JOIN EstadosViaje ev ON v.estadoId = ev.id
	WHERE 
		c.usuarioId = p_usuarioId 

	UNION
	
	-- Historial como PASAJERO
	SELECT
		'Pasajero' AS rol,
		v.fechaHoraSalida,
		v.fechaHoraLlegada,
   	    v.direccionSalida,
   	    v.direccionLlegada, 
   	    v.distancia,
		er.nombre
	FROM Reservas r
	JOIN Pasajeros p ON r.pasajeroId = p.Id 
	JOIN Viajes v ON r.viajeId = v.Id
	JOIN EstadosReserva er ON r.estadoId = er.Id
	WHERE 
		p.usuarioId = p_usuarioId 
	ORDER BY fechaHoraSalida DESC;
END //
DELIMITER ;

-- ============================================
--  P9: ENVIAR MENSAJE
-- ============================================
DELIMITER //
CREATE OR REPLACE PROCEDURE p_enviar_mensaje(
	IN p_conductor_emisorId INT,
	IN p_conductor_receptorId INT,
	IN p_pasajero_emisorId INT,
	IN p_pasajero_receptorId INT,
	IN p_contenido TEXT
)
BEGIN
	INSERT INTO Mensajes (fechaHora, contenido, conductorEmisorId, conductorReceptorId, pasajeroEmisorId, pasajeroReceptorId)
	VALUES (NOW(), p_contenido, p_conductor_emisorId, p_conductor_receptorId, p_pasajero_emisorId, p_pasajero_receptorId);	
END //
DELIMITER ;

-- ============================================
--  P10: CREAR VALORACION
-- ============================================
DELIMITER //
CREATE OR REPLACE PROCEDURE p_crear_valoracion(
   IN p_conductor_emisorId INT,
	IN p_conductor_receptorId INT,
	IN p_pasajero_emisorId INT,
	IN p_pasajero_receptorId INT,
	IN p_estrellas INT,
	IN p_contenido TEXT
)
BEGIN 
	INSERT INTO Valoraciones (estrellas, contenido, fechaHora, conductorEmisorId, conductorReceptorId, pasajeroEmisorId, pasajeroReceptorId)
	VALUES (p_estrellas,p_contenido, NOW(),p_conductor_emisorId, p_conductor_receptorId, p_pasajero_emisorId, p_pasajero_receptorId );
END //
DELIMITER ;