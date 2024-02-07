--Vista Tabla Ocupaciones--
CREATE VIEW V_Ocupaciones
AS
    SELECT ID_Ocupacion 'ID de Ocupación', Ocupacion 'Ocupación', Precio_Hora 'Precio por Hora', Precio_Hora_Extra 'Precio por Hora Extra' 
    FROM TB_Ocupaciones
GO

--Vista Tabla Proyectos--
CREATE VIEW V_Proyectos
AS 
    SELECT ID_Proyecto 'ID del Proyecto', Nombre_Proyecto 'Nombre del Proyecto', Ubicacion 'Ubicación' 
    FROM TB_Proyectos
GO

--Vista Tabla Registro--
CREATE VIEW V_Registro
AS 
    SELECT ID_Proyecto 'ID del Proyecto', ID_Actividad 'ID de la Actividad', FECHA 'Fecha' 
    FROM TB_Registro
GO

--Vista Tabla Trabajadores--
ALTER VIEW V_Trabajadores
AS 
    SELECT ID_Trabajador 'ID del Trabajador', Nombre_Trabajador 'Nombre del Trabajador', Apellido_Trabajador 'Apellido del Trabajador', 
    Cedula_Trabajador 'Cédula del Trabajador' , Telefono_Trabajador 'Teléfono del Trabajador', Email_Trabajador 'Email del Trabajador',
    Direccion_Trabajador 'Dirección del Trabajador' 
    FROM TB_Trabajadores
GO

--Vista Tabla Trabajos--
ALTER VIEW V_Trabajos
AS 
    SELECT TJOS.ID_Trabajador 'ID Trabajador', Nombre_Trabajador+' '+Apellido_Trabajador+' '+Cedula_Trabajador 'Nombre Trabajador', 
    ACT.ID_Actividad 'ID Actividad', Nombre_Actividad 'Nombre Actividad', PROY.ID_Proyecto 'ID Proyecto',Nombre_Proyecto 'Nombre Proyecto', 
    Fecha 'Fecha', Hora_Inicio 'Hora de Inicio', Hora_Fin 'Hora de Fin', Horas_Trabajadas 'Horas Trabajadas',
    Horas_Extra_Trabajadas 'Horas Extras Trabajadas' 
    FROM TB_Proyectos PROY INNER JOIN TB_Trabajos TJOS 
    ON PROY.ID_Proyecto = TJOS.ID_Proyecto INNER JOIN TB_Actividades ACT
    ON ACT.ID_Actividad = TJOS.ID_Actividad INNER JOIN TB_Trabajadores TDORES 
    ON TDORES.ID_Trabajador = TJOS.ID_Trabajador
GO

--Vista Tabla Contrato--
ALTER VIEW V_Contrato
AS 
    SELECT ID_Contrato 'ID del Contrato', NOMBRE_TRABAJADOR+' '+APELLIDO_TRABAJADOR 'Nombre del Trabajador', Ocupacion 'Ocupación', 
    Contrato_Estado 'Estado del Contrato', Fecha_Inicio 'Fecha de Inicio', Fecha_Fin 'Fecha de Fin', Metodo_Pago 'Método de Pago' 
    FROM TB_Contrato CONT INNER JOIN TB_TRABAJADORES TRAB 
    ON CONT.ID_TRABAJADOR = TRAB.ID_TRABAJADOR INNER JOIN TB_OCUPACIONES OCUP 
    ON CONT.ID_OCUPACION = OCUP.ID_OCUPACION
GO

--Vista Tabla Actividades--
CREATE VIEW V_Actividades
AS 
    SELECT ID_Actividad 'ID de Actividad', Nombre_Actividad 'Nombre de la Actividad' 
    FROM TB_Actividades
GO

--Vista Tabla Administrador--
CREATE VIEW V_Admin
AS 
    SELECT * FROM TB_Administradores
GO
