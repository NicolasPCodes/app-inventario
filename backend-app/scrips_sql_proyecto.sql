CREATE TABLE usuarios (
    id_usuario INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100),
    apellido VARCHAR(100), 
    fecha_creacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    estado_usuario ENUM('activo','inactivo','suspendido') DEFAULT 'activo',
    rol ENUM('encargado','jefe_tienda','auditor','admin') NOT NULL,
    password_hash VARCHAR(255) NOT NULL
);

CREATE TABLE productos (
    sku VARCHAR(20) PRIMARY KEY,
    id_producto INT UNIQUE AUTO_INCREMENT,
    nombre VARCHAR(150),
    descripcion VARCHAR(255),
    categoria VARCHAR(100)
);

CREATE TABLE orden_compra (
    id_oc INT AUTO_INCREMENT PRIMARY KEY,
    numero_oc VARCHAR(50) UNIQUE,
    sku VARCHAR(20),
    tienda VARCHAR(50),
    cantidad INT,
    FOREIGN KEY (sku) REFERENCES productos(sku)
);

CREATE TABLE recepcion (
    id_recepcion INT AUTO_INCREMENT PRIMARY KEY,
    id_oc INT,
    usuario INT,
    fecha TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    cantidad_recibida INT,
    estado_recepcion ENUM('pendiente','completa','incompleta') DEFAULT 'pendiente',
    comentario TEXT,
    FOREIGN KEY (id_oc) REFERENCES orden_compra(id_oc),
    FOREIGN KEY (usuario) REFERENCES usuarios(id_usuario)
);

CREATE TABLE discrepancias (
    id_discrepancia INT AUTO_INCREMENT PRIMARY KEY,
    id_recepcion INT,
    diferencia INT,
    estado ENUM('pendiente','resuelto') DEFAULT 'pendiente',
    fecha_discrepancia TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    comentario TEXT,
    FOREIGN KEY (id_recepcion) REFERENCES recepcion(id_recepcion)
);