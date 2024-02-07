--Inicio de session--
ALTER FUNCTION inicio_session
(
	@User VARCHAR(40),
	@Pass VARCHAR(50)
)
RETURNS @TABLA TABLE(NOMBRE VARCHAR(40), ACCES INT, IMAG VARCHAR(MAX), USUARIO VARCHAR(40))
AS
BEGIN
	
	IF exists(SELECT * FROM TB_Administradores WHERE Usuario = @User AND Contraseña = @Pass)
	

		INSERT INTO @TABLA SELECT (Nombre_Trabajador+' '+Apellido_Trabajador)'NOMBRE', Nivel_Acceso, IMG, ADMI.Usuario 
		FROM TB_Trabajadores TRAB INNER JOIN TB_Administradores ADMI
		ON	TRAB.ID_Trabajador = ADMI.ID_Trabajador
		WHERE Usuario = @User AND Contraseña = @Pass 
		RETURN
	
END
GO

--Funcion para extraer la cedula y id del trabajador--
CREATE FUNCTION FUNC_INFO_TRABAJ()
RETURNS @TABLA TABLE(CEDULA VARCHAR(20), ID INT)
AS
BEGIN
		INSERT INTO @TABLA SELECT Cedula_Trabajador, ID_Trabajador FROM TB_Trabajadores
		RETURN
END
GO
--------------
CREATE FUNCTION DBO.FUNCION_NOMBRE_CEDULA()
RETURNS TABLE
AS RETURN 
	(SELECT NOMBRE_TRABAJADOR+' '+APELLIDO_TRABAJADOR+' '+
	CEDULA_TRABAJADOR 'Nombre', ID_TRABAJADOR 'id_trabajador' FROM TB_TRABAJADORES)
go
----------------------------------
CREATE FUNCTION DBO.FUNCION_OCUPACION_ID()
RETURNS TABLE
AS RETURN 
	(SELECT OCUPACION 'ocupacion', ID_OCUPACION 'Id_ocupacion' 
FROM TB_OCUPACIONES)
GO
-------------------------
CREATE FUNCTION DBO.FUNCION_NIVEL_ACC()
RETURNS INT
AS BEGIN
DECLARE @NIVEL INT
	SELECT @NIVEL=NIVEL_ACCESO FROM TB_Administradores WHERE USUARIO = (SELECT SYSTEM_USER)
 	RETURN @NIVEL
END
GO
-----------------------
CREATE FUNCTION DBO.FUNCION_PROYECTOS()
RETURNS TABLE
AS RETURN
	(SELECT Nombre_Proyecto 'Nombre', ID_Proyecto 'Id'
	FROM TB_Proyectos)
GO
-------------------------
