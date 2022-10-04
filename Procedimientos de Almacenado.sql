USE db_taller_mecanico;
--Creacion de los Procedimientos de Almacenado
--TABLA PESONA
 
---ObtenerPersona
CREATE procedure [dbo].[proc_obtener_persona](
@id_persona int 
) 
as
begin
select * from persona where  id_persona = @id_persona
END

---ListarPersona
CREATE PROCEDURE [dbo].[proc_listar_persona]
AS
BEGIN
SELECT * FROM persona
END

---EditarPersona
CREATE PROCEDURE [dbo].[proc_editar_persona](
@id_persona int,
@documento VARCHAR(10),
@nombre VARCHAR(50),
@apellido VARCHAR(50),
@fecha_nacimiento DATETIME,
@telefono VARCHAR(10)
)
as
begin
update persona set documento=@documento,nombre=@nombre,apellido=@apellido,fecha_nacimiento=@fecha_nacimiento,telefono=@telefono where id_persona=@id_persona
end

--TABLA USUARIO

---ObtenerUsuario
CREATE procedure [dbo].[proc_obtener_usuario](
@id_usuario int 
) 
as 
begin 
select * from usuario where  id_usuario = @id_usuario
END

---ListarUsuario
CREATE PROCEDURE [dbo].[proc_listar_usuario]
AS
BEGIN
SELECT * from persona 
INNER JOIN usuario  on  usuario.id_persona = persona.id_persona
END

---GuardarUsuario
CREATE PROCEDURE [dbo].[proc_guardar_usuario](
@usuario VARCHAR(50),
@contrasena VARCHAR(100),
@tipo_usuario VARCHAR(50),
@documento VARCHAR(10)
)
AS
BEGIN
DECLARE @id_per int= (SELECT persona.id_persona FROM persona WHERE persona.documento=@documento)
INSERT INTO usuario(usuario,contrasena,tipo_usuario,id_persona) VALUES (@usuario,@contrasena,@tipo_usuario,@id_per)
END

---EditarUsuario
CREATE PROCEDURE [dbo].[proc_editar_usuario](
@id_usuario int,
@usuario VARCHAR(50),
@contrasena VARCHAR(100),
@tipo_usuario VARCHAR(50)
)
as
begin
update usuario set usuario=@usuario,contrasena=@contrasena,tipo_usuario=@tipo_usuario where id_usuario=@id_usuario
end

---EliminarUsuario
CREATE PROCEDURE [dbo].[proc_eliminar_usuario](
@id_usuario int
)
as
begin
    delete from usuario where id_usuario=@id_usuario
end

--TABLA MECANICO

--ObtenerMecanico
CREATE PROCEDURE [dbo].[proc_obtener_mecanico](
@id_mecanico int
)
as
begin
DECLARE @id_per int= (SELECT persona.id_persona FROM persona INNER JOIN mecanico ON persona.id_persona=mecanico.id_persona WHERE mecanico.id_mecanico=@id_mecanico)
SELECT * FROM persona INNER JOIN mecanico ON persona.id_persona=mecanico.id_persona where  persona.id_persona = @id_per
end

--ListarMecanico
CREATE PROCEDURE [dbo].[proc_listar_mecanico]
AS
BEGIN
SELECT * FROM persona INNER JOIN mecanico ON persona.id_persona=mecanico.id_persona
END

--GuardarMecanico
CREATE PROCEDURE [dbo].[proc_guardar_mecanico](
--persona
@documento VARCHAR(10),
@nombre VARCHAR(50),
@apellido VARCHAR(50),
@fecha_nacimiento DATETIME,
@telefono VARCHAR(10),
--mecanico
@direccion VARCHAR(100),
@nivel_educacion VARCHAR(100)
)
AS
BEGIN
INSERT INTO persona (documento,nombre,apellido,fecha_nacimiento,telefono) VALUES (@documento,@nombre,@apellido,@fecha_nacimiento,@telefono)
DECLARE @id VARCHAR(5) = (SELECT MAX(id_persona) FROM persona)
--mecanico
INSERT INTO mecanico (id_persona,direccion,nivel_educacion) VALUES (@id,@direccion,@nivel_educacion)
END

---EditarMecanico
CREATE PROCEDURE [dbo].[proc_editar_mecanico](
--persona
@id_mecanico int,
@documento VARCHAR(10),
@nombre VARCHAR(50),
@apellido VARCHAR(50),
@fecha_nacimiento DATETIME,
@telefono VARCHAR(10),
--mecanico
@direccion VARCHAR(100),
@nivel_educacion VARCHAR(100)
)
as
begin
DECLARE @id_per int= (SELECT persona.id_persona FROM persona INNER JOIN mecanico ON persona.id_persona=mecanico.id_persona WHERE mecanico.id_mecanico=@id_mecanico)
update persona set documento=@documento,nombre=@nombre,apellido=@apellido,fecha_nacimiento=@fecha_nacimiento, telefono=@telefono
where id_persona=@id_per
UPDATE mecanico set direccion = @direccion, nivel_educacion =@nivel_educacion WHERE mecanico.id_mecanico=@id_mecanico
end

---EliminarMecanico
CREATE PROCEDURE [dbo].[proc_eliminar_mecanico](
@id_mecanico int
)
as
begin
DECLARE @id_per int= (SELECT persona.id_persona FROM persona INNER JOIN mecanico ON persona.id_persona=mecanico.id_persona WHERE mecanico.id_mecanico=@id_mecanico)
    DELETE from mecanico WHERE id_mecanico=@id_mecanico
    DELETE from persona WHERE id_persona = @id_per
end

--TABLA PROPIETARIO

--ObtenerPropietario
CREATE PROCEDURE [dbo].[proc_obtener_propietario](
@id_propietario int
)
as
begin
DECLARE @id_per int= (SELECT persona.id_persona FROM persona INNER JOIN propietario ON persona.id_persona=propietario.id_persona WHERE propietario.id_propietario=@id_propietario)
SELECT * FROM persona INNER JOIN propietario ON persona.id_persona=propietario.id_persona where  persona.id_persona = @id_per
end

--ListarPropietario
CREATE PROCEDURE [dbo].[proc_listar_propietario]
AS
BEGIN
SELECT * FROM persona INNER JOIN propietario ON persona.id_persona=propietario.id_persona
END

--GuardarPropietario
CREATE PROCEDURE [dbo].[proc_guardar_propietario](
--persona
@documento VARCHAR(10),
@nombre VARCHAR(50),
@apellido VARCHAR(50),
@fecha_nacimiento DATETIME,
@telefono VARCHAR(10),
--propietario
@ciudad_residencia VARCHAR(100),
@correo VARCHAR(50)
)
AS
BEGIN
INSERT INTO persona (documento,nombre,apellido,fecha_nacimiento,telefono) VALUES (@documento,@nombre,@apellido,@fecha_nacimiento,@telefono)
DECLARE @id VARCHAR(5) = (SELECT MAX(id_persona) FROM persona)
--propietario
INSERT INTO propietario (id_persona,ciudad_residencia,correo) VALUES (@id,@ciudad_residencia,@correo)
END

---EditarPropietario
CREATE PROCEDURE [dbo].[proc_editar_propietario](
--persona
@id_propietario int,
@documento VARCHAR(10),
@nombre VARCHAR(50),
@apellido VARCHAR(50),
@fecha_nacimiento DATETIME,
@telefono VARCHAR(10),
--propietario
@ciudad_residencia VARCHAR(100),
@correo VARCHAR(50)
)
as
begin
DECLARE @id_per int= (SELECT persona.id_persona FROM persona INNER JOIN propietario ON persona.id_persona=propietario.id_persona WHERE propietario.id_propietario=@id_propietario)
update persona set documento=@documento,nombre=@nombre,apellido=@apellido,fecha_nacimiento=@fecha_nacimiento, telefono=@telefono
where id_persona=@id_per
UPDATE propietario set ciudad_residencia = @ciudad_residencia, correo = @correo WHERE propietario.id_propietario=@id_propietario
end

---EliminarPropietario
CREATE PROCEDURE [dbo].[proc_eliminar_propietario](
@id_propietario int
)
as
begin
DECLARE @id_per int= (SELECT persona.id_persona FROM persona INNER JOIN propietario ON persona.id_persona=propietario.id_persona WHERE propietario.id_propietario=@id_propietario)
    DELETE from propietario WHERE id_propietario=@id_propietario
    DELETE from persona WHERE id_persona = @id_per
end

--TABLA VEHICULO

--ObtenerVehiculo
CREATE PROCEDURE [dbo].[proc_obtener_vehiculo](
@id_vehiculo int
)
as
begin
SELECT * FROM persona INNER JOIN propietario ON persona.id_persona=propietario.id_persona INNER JOIN vehiculo ON vehiculo.id_propietario=propietario.id_propietario where vehiculo.id_vehiculo=@id_vehiculo
end

--ListarVehiculo
CREATE PROCEDURE [dbo].[proc_listar_vehiculo]
AS
BEGIN
SELECT * FROM persona INNER JOIN propietario ON persona.id_persona=propietario.id_persona INNER JOIN vehiculo ON vehiculo.id_propietario=propietario.id_propietario
END

--GuardarVehiculo
CREATE PROCEDURE [dbo].[proc_guardar_vehiculo](
@documento VARCHAR(10),
@placa VARCHAR(6),
@modelo VARCHAR(4),
@capacidad_pasajeros VARCHAR(2),
@cilindraje VARCHAR(4),
@ciudad_origen VARCHAR(100),
@descripcion VARCHAR(400)
)
AS
BEGIN
DECLARE @id_pro int= (SELECT propietario.id_propietario FROM propietario INNER JOIN persona ON persona.id_persona=propietario.id_persona WHERE persona.documento=@documento)
INSERT INTO vehiculo (id_propietario,placa,modelo,capacidad_pasajeros,cilindraje,ciudad_origen,descripcion) VALUES (@id_pro,@placa,@modelo,@capacidad_pasajeros,@cilindraje,@ciudad_origen,@descripcion)
END

---EditarVehiculo
CREATE PROCEDURE [dbo].[proc_editar_vehiculo](
@id_vehiculo int,
@documento VARCHAR(10),
@placa VARCHAR(6),
@modelo VARCHAR(4),
@capacidad_pasajeros VARCHAR(2),
@cilindraje VARCHAR(4),
@ciudad_origen VARCHAR(100),
@descripcion VARCHAR(400)
)
as
begin
DECLARE @id_pro int= (SELECT propietario.id_propietario FROM propietario INNER JOIN persona ON persona.id_persona=propietario.id_persona WHERE persona.documento=@documento)
UPDATE vehiculo set id_propietario=@id_pro,placa=@placa,modelo=@modelo,capacidad_pasajeros=@capacidad_pasajeros,cilindraje=@cilindraje,ciudad_origen=@ciudad_origen,descripcion=@descripcion WHERE vehiculo.id_vehiculo=@id_vehiculo
end

---EliminarVehiculo
CREATE PROCEDURE [dbo].[proc_eliminar_vehiculo](
@id_vehiculo int
)
as
begin
DELETE from vehiculo WHERE id_vehiculo=@id_vehiculo
end

--TABLA SEGURO

--ObtenerSeguro
CREATE PROCEDURE [dbo].[proc_obtener_seguro](
@id_seguro int
)
as
begin
SELECT * FROM vehiculo INNER JOIN seguro ON vehiculo.id_vehiculo=seguro.id_vehiculo WHERE seguro.id_seguro=@id_seguro
end

--ListarSeguro
CREATE PROCEDURE [dbo].[proc_listar_seguro]
AS
BEGIN
SELECT * FROM vehiculo INNER JOIN seguro ON vehiculo.id_vehiculo=seguro.id_vehiculo
END

--GuardarSeguro
CREATE PROCEDURE [dbo].[proc_guardar_seguro](
@placa VARCHAR(6),
@fecha_inicio DATETIME,
@fecha_final DATETIME,
@numero_poliza VARCHAR(50),
@tipo_seguro VARCHAR(100)
)
AS
BEGIN
DECLARE @id_vehiculo int= (SELECT vehiculo.id_vehiculo FROM vehiculo WHERE vehiculo.placa=@placa)
INSERT INTO seguro (id_vehiculo,fecha_inicio,fecha_final,numero_poliza,tipo_seguro) VALUES (@id_vehiculo,@fecha_inicio,@fecha_final,@numero_poliza,@tipo_seguro)
END

---EditarSeguro
CREATE PROCEDURE [dbo].[proc_editar_seguro](
@id_seguro int,
@placa VARCHAR(6),
@fecha_inicio DATETIME,
@fecha_final DATETIME,
@numero_poliza VARCHAR(50),
@tipo_seguro VARCHAR(100)
)
as
begin
DECLARE @id_vehiculo int= (SELECT vehiculo.id_vehiculo FROM vehiculo WHERE vehiculo.placa=@placa)
UPDATE seguro set id_vehiculo=@id_vehiculo,fecha_inicio=@fecha_inicio,fecha_final=@fecha_final,numero_poliza=@numero_poliza,tipo_seguro=@tipo_seguro WHERE seguro.id_seguro=@id_seguro
end

---EliminarSeguro
CREATE PROCEDURE [dbo].[proc_eliminar_seguro](
@id_seguro int
)
as
begin
DELETE from seguro WHERE id_seguro=@id_seguro
end

--TABLA REVISION

--ObtenerRevision
CREATE PROCEDURE [dbo].[proc_obtener_revision](
@id_revision int
)
as
begin
SELECT * FROM persona INNER JOIN mecanico ON persona.id_persona=mecanico.id_persona INNER JOIN revision ON mecanico.id_mecanico= revision.id_mecanico INNER JOIN vehiculo ON revision.id_vehiculo=vehiculo.id_vehiculo WHERE revision.id_revision=@id_revision
end

--ListarRevision
CREATE PROCEDURE [dbo].[proc_listar_revision]
AS
BEGIN
--SELECT * FROM persona INNER JOIN mecanico ON persona.id_persona=mecanico.id_persona INNER JOIN revision ON mecanico.id_mecanico= revision.id_mecanico INNER JOIN vehiculo ON revision.id_vehiculo=vehiculo.id_vehiculo LEFT JOIN niveles_vehiculo ON revision.id_revision=niveles_vehiculo.id_revision LEFT JOIN estado ON niveles_vehiculo.id_estado=estado.id_estado
SELECT persona.*,mecanico.*,revision.*,vehiculo.*,niveles_vehiculo.*,estado.id_estado, ISNULL(estado.tipo_estado,'No Registrado') AS tipo_estado FROM persona INNER JOIN mecanico ON persona.id_persona=mecanico.id_persona INNER JOIN revision ON mecanico.id_mecanico= revision.id_mecanico INNER JOIN vehiculo ON revision.id_vehiculo=vehiculo.id_vehiculo LEFT JOIN niveles_vehiculo ON revision.id_revision=niveles_vehiculo.id_revision LEFT JOIN estado ON niveles_vehiculo.id_estado=estado.id_estado
END

--GuardarRevision
CREATE PROCEDURE [dbo].[proc_guardar_revision](
@placa VARCHAR(6),
@documento VARCHAR(10),
@fecha_revision DATETIME,
@hora VARCHAR(6)
)
AS
BEGIN
DECLARE @id_vehiculo int= (SELECT vehiculo.id_vehiculo FROM vehiculo WHERE vehiculo.placa=@placa)
DECLARE @id_mecanico int= (SELECT mecanico.id_mecanico FROM mecanico INNER JOIN persona ON mecanico.id_persona=persona.id_persona WHERE persona.documento=@documento)
INSERT INTO revision (id_vehiculo,id_mecanico,fecha_revision,hora) VALUES (@id_vehiculo,@id_mecanico,@fecha_revision,@hora)
END

---EditarRevision
CREATE PROCEDURE [dbo].[proc_editar_revision](
@id_revision int,
@placa VARCHAR(6),
@documento VARCHAR(10),
@fecha_revision DATETIME,
@hora VARCHAR(6)
)
as
begin
DECLARE @id_vehiculo int= (SELECT vehiculo.id_vehiculo FROM vehiculo WHERE vehiculo.placa=@placa)
DECLARE @id_mecanico int= (SELECT mecanico.id_mecanico FROM mecanico INNER JOIN persona ON mecanico.id_persona=persona.id_persona WHERE persona.documento=@documento)
UPDATE revision set id_vehiculo=@id_vehiculo,id_mecanico=@id_mecanico,fecha_revision=@fecha_revision,hora=@hora WHERE revision.id_revision=@id_revision
end

---EliminarRevision
CREATE PROCEDURE [dbo].[proc_eliminar_revision](
@id_revision int
)
as
begin
DECLARE @id_estado_vehiculo int= (SELECT niveles_vehiculo.id_estado_vehiculo FROM niveles_vehiculo INNER JOIN revision ON niveles_vehiculo.id_revision=revision.id_revision WHERE revision.id_revision=@id_revision)
DELETE from niveles_vehiculo WHERE id_estado_vehiculo=@id_estado_vehiculo
DELETE from revision WHERE id_revision=@id_revision
end

--TABLA NIVELES_VEHICULO

--ListarNiveles
CREATE PROCEDURE [dbo].[proc_listar_niveles]
AS
BEGIN
SELECT * FROM vehiculo INNER JOIN revision ON vehiculo.id_vehiculo=revision.id_vehiculo INNER JOIN niveles_vehiculo ON revision.id_revision=niveles_vehiculo.id_revision INNER JOIN estado ON niveles_vehiculo.id_estado=estado.id_estado
END

--GuardarNivelesEntrada
CREATE PROCEDURE [dbo].[proc_guardar_niveles_en](
@nivel_refrigerante VARCHAR(6),
@nivel_liquido_freno VARCHAR(6),
@nivel_liquido_direccion VARCHAR(6),
@nivel_aceite VARCHAR(6),
@id_revision int
)
AS
BEGIN
INSERT INTO niveles_vehiculo (nivel_refrigerante,nivel_liquido_freno,nivel_liquido_direccion,nivel_aceite,id_revision,id_estado) VALUES (@nivel_refrigerante,@nivel_liquido_freno,@nivel_liquido_direccion,@nivel_aceite,@id_revision,2)
END
--GuardarNivelesSalida
CREATE PROCEDURE [dbo].[proc_guardar_niveles_sa](
@nivel_refrigerante VARCHAR(6),
@nivel_liquido_freno VARCHAR(6),
@nivel_liquido_direccion VARCHAR(6),
@nivel_aceite VARCHAR(6),
@id_revision int
)
AS
BEGIN
DECLARE @id_estado_vehiculo int= (SELECT niveles_vehiculo.id_estado_vehiculo FROM niveles_vehiculo INNER JOIN revision ON niveles_vehiculo.id_revision=revision.id_revision WHERE revision.id_revision=@id_revision)
UPDATE niveles_vehiculo SET id_estado = '1' WHERE niveles_vehiculo.id_estado_vehiculo = @id_estado_vehiculo 
INSERT INTO niveles_vehiculo (nivel_refrigerante,nivel_liquido_freno,nivel_liquido_direccion,nivel_aceite,id_revision,id_estado) VALUES (@nivel_refrigerante,@nivel_liquido_freno,@nivel_liquido_direccion,@nivel_aceite,@id_revision,1)
END

---validarlogin
CREATE PROCEDURE [dbo].[proc_validar_usuario](
    @usuario VARCHAR(100),
    @contrasena VARCHAR(500)
)as BEGIN

if(exists (SELECT * from usuario WHERE usuario = @usuario AND contrasena =@contrasena ))
    SELECT id_usuario FROM usuario WHERE usuario =@usuario and contrasena= @contrasena
ELSE
SELECT '0'
end

