CREATE DATABASE db_taller_mecanico;

USE db_taller_mecanico;


CREATE TABLE persona(
    id_persona int IDENTITY(1,1) PRIMARY KEY NOT NULL,
    documento VARCHAR(10) NOT NULL,
    nombre VARCHAR(50)NOT NULL,
    apellido VARCHAR(50)NOT NULL,
    fecha_nacimiento DATETIME NOT NULL,
    telefono VARCHAR(10) NOT NULL
);
CREATE TABLE usuario(
    id_usuario int IDENTITY(1,1) PRIMARY KEY NOT NULL,
    usuario VARCHAR(50) UNIQUE NOT NULL,
    contrasena VARCHAR(100) NOT NULL,
    tipo_usuario VARCHAR(50) NOT NULL,
    id_persona int UNIQUE NOT NULL
);
CREATE TABLE mecanico(
    id_mecanico int IDENTITY(1,1) PRIMARY KEY NOT NULL,
    id_persona int UNIQUE NOT NULL,
    direccion VARCHAR(100) NOT NULL,
    nivel_educacion VARCHAR(100) NOT NULL
);
CREATE TABLE propietario(
    id_propietario int IDENTITY(1,1) PRIMARY KEY NOT NULL,
    id_persona int UNIQUE NOT NULL,
    ciudad_residencia VARCHAR(100) NOT NULL,
    correo VARCHAR(50) NOT NULL
);
CREATE TABLE vehiculo(
    id_vehiculo int IDENTITY(1,1) PRIMARY KEY NOT NULL,
    id_propietario int NOT NULL,
    placa VARCHAR(6) UNIQUE NOT NULL,
    modelo VARCHAR(4) NOT NULL,
    capacidad_pasajeros VARCHAR(2) NOT NULL,
    cilindraje VARCHAR(4) NOT NULL,
    ciudad_origen VARCHAR(100) NOT NULL,
    descripcion VARCHAR(400) NOT NULL
);
CREATE TABLE seguro(
    id_seguro int IDENTITY(1,1) PRIMARY KEY NOT NULL,
    id_vehiculo int NOT NULL,
    fecha_inicio DATETIME NOT NULL,
    fecha_final DATETIME NOT NULL,
    numero_poliza VARCHAR(50)  NOT NULL,
    tipo_seguro VARCHAR(100) NOT NULL
);
CREATE TABLE revision(
    id_revision int IDENTITY(1,1) PRIMARY KEY NOT NULL,
    id_vehiculo int NOT NULL,
    id_mecanico int NOT NULL,
    fecha_revision DATETIME NOT NULL,
    hora VARCHAR(6) NOT NULL
);
CREATE TABLE niveles_vehiculo(
    id_estado_vehiculo int IDENTITY(1,1) PRIMARY KEY NOT NULL,
    nivel_refrigerante VARCHAR(6),
    nivel_liquido_freno VARCHAR(6) NOT NULL,
    nivel_liquido_direccion VARCHAR(6),
    nivel_aceite VARCHAR(6) NOT NULL,
    id_revision int NOT NULL,
    id_estado int NOT NULL
);
CREATE TABLE estado(
    id_estado int IDENTITY(1,1) PRIMARY KEY NOT NULL,
    tipo_estado VARCHAR(30)
);
--Creacion Llaves Foraneas

ALTER TABLE usuario ADD FOREIGN KEY (id_persona) REFERENCES persona(id_persona);
ALTER TABLE mecanico ADD FOREIGN KEY (id_persona) REFERENCES persona(id_persona);
ALTER TABLE propietario ADD FOREIGN KEY (id_persona) REFERENCES persona(id_persona);
ALTER TABLE vehiculo ADD FOREIGN KEY (id_propietario) REFERENCES propietario(id_propietario);
ALTER TABLE seguro ADD FOREIGN KEY (id_vehiculo) REFERENCES vehiculo(id_vehiculo);
ALTER TABLE revision ADD FOREIGN KEY (id_vehiculo) REFERENCES vehiculo(id_vehiculo);
ALTER TABLE revision ADD FOREIGN KEY (id_mecanico) REFERENCES mecanico(id_mecanico);
ALTER TABLE niveles_vehiculo ADD FOREIGN KEY (id_revision) REFERENCES revision(id_revision);
ALTER TABLE niveles_vehiculo ADD FOREIGN KEY (id_estado) REFERENCES estado(id_estado);

--Insertar Datos
INSERT INTO estado(tipo_estado)VALUES('Registrada'),('Registrando');
INSERT INTO persona(documento,nombre,apellido,fecha_nacimiento,telefono)VALUES('123456789','Juan','Prueba',2022-09-09,'3123123123');
INSERT INTO usuario('Admin','1234','Administrador',1);

