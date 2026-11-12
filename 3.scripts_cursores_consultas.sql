-- ============================================
--  CO1: CONSULTAS DE VIAJES
-- ============================================

SELECT 
	v.fechaHoraSalida,
    v.fechaHoraLlegada,
	po.direccion AS direccionSalida,
    po.localidad AS localidadSalida,
    pd.direccion AS direccionLlegada,
    pd.localidad AS localidadLlegada,
    v.costePlaza,
    v.plazasDisponibles,
    u.nombre AS conductor
FROM Viajes v
JOIN PuntoFisico po ON v.puntoSalidaId = po.id
JOIN PuntoFisico pd ON v.puntoLlegadaId = pd.id
JOIN Vehiculos vh ON v.vehiculoId = vh.id
JOIN Conductores c ON vh.conductorId = c.id
JOIN Usuarios u ON c.usuarioId = u.id
WHERE v.fechaHoraSalida > NOW()
  AND v.estado = 'Programado'
  AND v.plazasDisponibles > 0
ORDER BY v.fechaHoraSalida ASC;

-- ============================================
--  CO2: CONSULTAS DE CANCELACIONES
-- ============================================

SELECT
    v.fechaHoraSalida,
    v.estado,
    v.id AS viajeId,
    po.localidad AS origen,
    pd.localidad AS destino,
FROM Viajes v
JOIN PuntoFisico po ON v.puntoSalidaId = po.id
JOIN PuntoFisico pd ON v.puntoLlegadaId = pd.id
WHERE v.fechaHoraSalida > NOW()
  AND v.estado = 'Programado'
ORDER BY v.fechaHoraSalida ASC; 

-- ============================================
--  CO3: CONSULTAS DE RESERVAS
-- ============================================

SELECT 
	v.fechaHoraSalida,
    v.plazasDisponibles,
    v.id AS viajeId
    r.fechaHora,
    r.id AS reservaId,
    r.fechaHora AS fechaHoraReserva,
    r.estado AS estadoReserva,
    u.nombre AS pasajero
FROM Viajes v
LEFT JOIN Reservas r ON v.id = r.viajeId
LEFT JOIN Pasajeros p ON r.pasajeroId = p.id
LEFT JOIN Usuarios u ON p.usuarioId = u.id
WHERE v.plazasDisponibles > 0
ORDER BY v.fechaHoraSalida ASC;

-- ============================================
--  CO4: CONSULTAS DE MENSAJES
-- ============================================

SELECT 
    m.viajeId,
    up.nombre AS pasajero,
    uc.nombre AS conductor,
    m.contenido
FROM Mensajes m
JOIN Pasajeros p ON m.pasajeroId = p.id
JOIN Usuarios up ON p.usuarioId = up.id
JOIN Conductores c ON m.conductorId = c.id
JOIN Usuarios uc ON c.usuarioId = uc.id
WHERE p.id = 1 AND c.id = 1
ORDER BY m.fechaHora ASC;

-- ============================================
--  CO5: CONSULTAS DE VALORACIONES
-- ============================================

SELECT
    up.nombre AS pasajero,
    uc.nombre AS conductor,
    val.estrellas,
    val.contenido,
    val.fechaHora
FROM Valoraciones val
JOIN Conductores c ON m.conductorId = c.id
JOIN Usuarios uc ON c.usuarioId = uc.id
JOIN Pasajeros p ON m.pasajeroId = p.id
JOIN Usuarios up ON p.usuarioId = up.id
WHERE c.id = 1
ORDER BY val.fechaHora DESC
LIMIT 3;


-- ============================================
--  CO6: CONSULTAS DE PAGOS
-- ============================================

SELECT 
    u.nombre AS pasajero,
    pg.importe,
    pg.estado AS estadoPago,
    pg.fechaHora AS fechaHoraPago,
    po.localidad AS origen,
    pd.localidad AS destino
FROM Pagos pg
JOIN Reservas r ON pg.reservaId = r.id
JOIN Pasajeros p ON r.pasajeroId = p.id
JOIN Usuarios u ON p.usuarioId = u.id
JOIN Viajes v ON r.viajeId = v.id
JOIN PuntoFisico po ON v.puntoSalidaId = po.id
JOIN PuntoFisico pd ON v.puntoLlegadaId = pd.id
WHERE r.pasajeroId = 1
  AND pg.estado IN ('Exitoso', 'Pendiente', 'Reembolsado')
ORDER BY pg.fechaHora DESC;