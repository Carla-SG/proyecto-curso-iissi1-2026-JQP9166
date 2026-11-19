DROP TABLE IF EXISTS usuarios;
DROP TABLE IF EXISTS administradores;
DROP TABLE IF EXISTS pasajeros;
DROP TABLE IF EXISTS conductores;
DROP TABLE IF EXISTS reservas;
DROP TABLE IF EXISTS pagos;
DROP TABLE IF EXISTS valoraciones;
DROP TABLE IF EXISTS mensajes;
DROP TABLE IF EXISTS vehiculos;
DROP TABLE IF EXISTS viajes;
DROP TABLE IF EXISTS puntosfisicos;

CREATE TABLE usuarios (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(100) NOT NULL,
    apellidos VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    telefono VARCHAR(15) NOT NULL,
    contrasena VARCHAR(255) NOT NULL,
    fechaNacimiento DATE NOT NULL,
    fotoDNI VARCHAR(255) NOT NULL
    );

CREATE TABLE administradores (
    id INT PRIMARY KEY AUTO_INCREMENT,
    usuarioId INT NOT NULL,
    FOREIGN KEY (usuarioId) REFERENCES usuarios(id)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

CREATE TABLE pasajeros (
    id INT PRIMARY KEY AUTO_INCREMENT,
    usuarioId INT NOT NULL,
    FOREIGN KEY (usuarioId) REFERENCES usuarios(id)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

CREATE TABLE conductores (
    id INT PRIMARY KEY AUTO_INCREMENT,
    usuarioId INT NOT NULL,
    carnetVerificado BOOLEAN NOT NULL DEFAULT FALSE,
    fotoCarnet VARCHAR(255) NOT NULL,
    valoracionMedia DECIMAL(4,2) NOT NULL DEFAULT 0.00 CHECK(valoracionMedia BETWEEN 0 AND 10), 
    FOREIGN KEY (usuarioId) REFERENCES usuarios(id)
        ON DELETE CASCADE
        ON UPDATE CASCADE 
);

CREATE TABLE vehiculos (
    id INT PRIMARY KEY AUTO_INCREMENT,
    conductorId INT NOT NULL, 
    matricula VARCHAR(15) UNIQUE NOT NULL,
    marca VARCHAR(50) NOT NULL,
    modelo VARCHAR(50) NOT NULL,
    color VARCHAR(30) NOT NULL,
    plazas INT NOT NULL,
    consumoMedio DECIMAL(4,2) NOT NULL,
    FOREIGN KEY (conductorId) REFERENCES conductores(id)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

CREATE TABLE puntosfisicos (
    id INT PRIMARY KEY AUTO_INCREMENT,
    direccion VARCHAR(255) NOT NULL,
    localidad VARCHAR(100) NOT NULL,
    provincia VARCHAR(100) NOT NULL,
    pais VARCHAR(100) NOT NULL,
    codigoPostal VARCHAR(10) NOT NULL
);

CREATE TABLE viajes (
    id INT PRIMARY KEY AUTO_INCREMENT,
    vehiculoId INT NOT NULL,
    origenId INT NOT NULL,
    destinoId INT NOT NULL,
    plazasDisponibles INT,
    fechaHoraSalida DATETIME NOT NULL,
    estado ENUM('Programado', 'EnCurso', 'Finalizado', 'Cancelado') NOT NULL,
    distancia DECIMAL(6,2) NOT NULL,
    fechaHoraLlegada DATETIME NOT NULL,
    costePlaza DECIMAL(5,2) NOT NULL,
    plazasReservadas INT NOT NULL,
    FOREIGN KEY (vehiculoId) REFERENCES vehiculos(id)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    FOREIGN KEY (origenId) REFERENCES puntosfisicos(id)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    FOREIGN KEY (destinoId) REFERENCES puntosfisicos(id)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

CREATE TABLE reservas (
    id INT PRIMARY KEY AUTO_INCREMENT,
    pasajeroId INT NOT NULL,
    viajeId INT NOT NULL,
    fechaHora DATETIME NOT NULL,
    estado ENUM('Solicitada', 'Aceptada', 'Cancelada') NOT NULL,
    FOREIGN KEY (pasajeroId) REFERENCES pasajeros(id)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    FOREIGN KEY (viajeId) REFERENCES viajes(id)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

CREATE TABLE pagos (
    id INT PRIMARY KEY AUTO_INCREMENT,
    reservaId INT NOT NULL,
    importe DECIMAL(5,2) NOT NULL,
    estado ENUM('Pendiente', 'Exitoso', 'Reembolsado') NOT NULL,
    fechaHora DATETIME NOT NULL,
    FOREIGN KEY (reservaId) REFERENCES reservas(id)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

CREATE TABLE valoraciones (
    id INT PRIMARY KEY AUTO_INCREMENT,
    pasajeroEmisorId INT,
    pasajeroReceptorId INT,
    conductorEmisorId INT,
    conductorReceptorId INT,
    estrellas INT NOT NULL CHECK(estrellas BETWEEN 0 and 5), 
    comentario TEXT,
    fechaHora DATETIME NOT NULL,
    FOREIGN KEY (pasajeroEmisorId) REFERENCES pasajeros(id)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    FOREIGN KEY (pasajeroReceptorId) REFERENCES pasajeros(id)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    FOREIGN KEY (conductorEmisorId) REFERENCES conductores(id)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    FOREIGN KEY (conductorReceptorId) REFERENCES conductores(id)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

CREATE TABLE mensajes (
    id INT PRIMARY KEY AUTO_INCREMENT,
    pasajeroEmisorId INT,
    pasajeroReceptorId INT,
    conductorEmisorId INT,
    conductorReceptorId INT,
    contenido TEXT NOT NULL,
    fechaHora DATETIME NOT NULL,
    FOREIGN KEY (pasajeroEmisorId) REFERENCES pasajeros(id)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    FOREIGN KEY (pasajeroReceptorId) REFERENCES pasajeros(id)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    FOREIGN KEY (conductorEmisorId) REFERENCES conductores(id)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    FOREIGN KEY (conductorReceptorId) REFERENCES conductores(id)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);
