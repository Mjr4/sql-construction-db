
--PROCEDIMIENTOS ALMACENADOS
SET IMPLICIT_TRANSACTIONS ON;
SET TRANSACTION ISOLATION LEVEL READ COMMITTED;

--PROCEDIMIENTO PARA INSERTAR TRABAJADOR
CREATE PROC PROC_INSERTAR_TRABAJADOR
	@ID INT, @NOMBRE VARCHAR(25), @APELLIDO VARCHAR(25), @CED VARCHAR(20), 
	@TELEF VARCHAR(25), @EMAIL VARCHAR(40),	@DIREC VARCHAR(100)
AS
	BEGIN TRY
		BEGIN TRAN
			INSERT INTO TB_Trabajadores (ID_Trabajador, Nombre_Trabajador,
			Apellido_Trabajador,Cedula_Trabajador, Telefono_Trabajador,
			Email_Trabajador,Direccion_Trabajador)
			VALUES (@ID, @NOMBRE, @APELLIDO, @CED, @TELEF, @EMAIL, @DIREC)
		COMMIT TRAN
	END TRY

	BEGIN CATCH
		PRINT 'Error de insercion'
		ROLLBACK
	END CATCH

--PROCEDIMIENTO PARA ACTUALIZAR REGISTRO TRABAJADORES
CREATE PROCEDURE PROC_ACTUALIZAR_TRABAJADOR
	@ID INT,  @NOMBRE VARCHAR(25), @APELLIDO VARCHAR(25), @CED VARCHAR(20), 
	@TELEF VARCHAR(25), @EMAIL VARCHAR(40),	@DIREC VARCHAR(100)
AS 
	BEGIN TRY
		BEGIN TRAN
			UPDATE TB_TRABAJADORES SET Nombre_Trabajador = @NOMBRE, APELLIDO_TRABAJADOR = @APELLIDO,
			Cedula_Trabajador = @CED, Telefono_Trabajador= @TELEF, Email_Trabajador = @EMAIL, 
			Direccion_Trabajador = @DIREC WHERE ID_TRABAJADOR = @ID
		COMMIT TRAN
	END TRY
	
	BEGIN CATCH
		PRINT 'ERROR DE ACTUALIZACION'
		ROLLBACK
	END CATCH

--Procedimiento eliminar registro
CREATE PROCEDURE PROC_ELIM_TRABAJADOR
	@ID INT
AS 
	BEGIN
		BEGIN TRY
			BEGIN TRAN
			DELETE FROM TB_TRABAJADORES WHERE ID_TRABAJADOR = @ID
			COMMIT TRAN
		END TRY
	BEGIN CATCH
		PRINT 'ERROR DE ELIMINACION'
		ROLLBACK
	END CATCH
END

--PROCEDIMIENTO PARA AñADIR UNA OCUPACION
CREATE PROCEDURE PROC_INSERTAR_OCUPACION
	@ID INT,
	@OCUPACION VARCHAR(25),
	@PRECIO_HORA_N SMALLMONEY,
	@PRECIO_HORA_E SMALLMONEY
AS 
	BEGIN TRY
		BEGIN TRAN
			INSERT INTO TB_OCUPACIONES (ID_Ocupacion, Ocupacion, Precio_Hora, Precio_Hora_Extra)
			VALUES (@ID, @OCUPACION, @PRECIO_HORA_N, @PRECIO_HORA_E)
		COMMIT TRAN
	END TRY
	BEGIN CATCH
		PRINT 'ERROR DE INSERCION'
		ROLLBACK
	END CATCH

--PROCEDIMIENTO PARA ACTUALIZAR OCUPACIONES
CREATE PROCEDURE PROC_ACTUALIZAR_OCUP
	@ID INT,
	@OCUP VARCHAR(25),
	@PRECIO_HORA_N SMALLMONEY,
	@PRECIO_HORA_E SMALLMONEY
AS 
	BEGIN TRY
		BEGIN TRAN
			UPDATE TB_OCUPACIONES SET Ocupacion = @OCUP, Precio_Hora = @PRECIO_HORA_N,
			Precio_Hora_Extra = @PRECIO_HORA_E WHERE ID_OCUPACION = @ID
		COMMIT TRAN
		END TRY
		BEGIN CATCH
			ROLLBACK
		END CATCH

--PROCEDIMIENTO PARA ELIMINAR UNA OCUPACION
CREATE PROCEDURE PROC_ELIMINAR_OCUP
	@ID INT
AS 
	BEGIN TRY
		BEGIN TRAN
		DELETE FROM TB_OCUPACIONES WHERE ID_OCUPACION = @ID
		COMMIT TRAN
	END TRY
	BEGIN CATCH
		ROLLBACK
	END CATCH

--PROCEDIMIENTO PARA INSERTAR UN CONTRATO
CREATE PROCEDURE PROC_INSERTAR_CONTRATO
	@ID INT,
	@ID_TRABAJADOR INT,
	@ID_OCUP INT,
	@ESTADO BIT,
	@FECHA_INICIO DATE,
	@FECHA_FIN DATE,
	@METODO_PAGO VARCHAR(30)
AS
	BEGIN TRY
		BEGIN TRAN
		INSERT INTO TB_Contrato (ID_Contrato, ID_Trabajador, ID_Ocupacion, Contrato_Estado, Fecha_Inicio,
		Fecha_Fin, Metodo_Pago) VALUES (@ID, @ID_TRABAJADOR, @ID_OCUP, @ESTADO, @FECHA_INICIO, @FECHA_FIN, @METODO_PAGO)
		COMMIT TRAN
	END TRY
	BEGIN CATCH
		ROLLBACK
	END CATCH

--PROCEDIMIENTO PARA ACTUALIZAR CONTRATO
CREATE PROCEDURE PROC_ACTUALIZAR_CONTRATO
	@ID INT,
	@ESTADO BIT,
	@FECHA_INICIO DATE,
	@FECHA_FIN DATE,
	@METODO_PAGO VARCHAR(30)
AS 
	BEGIN TRY
		BEGIN TRAN
		UPDATE TB_Contrato SET Contrato_Estado = @ESTADO, Fecha_Inicio = @FECHA_INICIO,
		Fecha_Fin = @FECHA_FIN, Metodo_Pago = @METODO_PAGO WHERE ID_Contrato = @ID
		COMMIT TRAN
	END TRY
	BEGIN CATCH
		ROLLBACK
	END CATCH
GO

--PROCEDIMIENTO PARA ELIMINAR CONTRATO
CREATE PROCEDURE PROC_ELIMINAR_CONTRATO
	@ID INT
AS 
	BEGIN TRY
		BEGIN TRAN
		DELETE FROM TB_Contrato WHERE ID_Contrato = @ID
		COMMIT TRAN
	END TRY
	BEGIN CATCH
		ROLLBACK
	END CATCH
GO
--PROCEDIMIENTO PARA INSERTAR ACTIVIDAD
CREATE PROCEDURE PROC_INSERTAR_ACTIV
	@ID INT,
	@NOMBRE VARCHAR(30)
AS
	BEGIN TRY
		BEGIN TRAN
		INSERT INTO TB_Actividades (ID_Actividad, Nombre_Actividad) VALUES (@ID, @NOMBRE)
		COMMIT TRAN
	END TRY
	BEGIN CATCH
		ROLLBACK
	END CATCH
GO

--PROCEDIMIENTO ACTUALIZAR ACTIVIDADES
CREATE PROCEDURE PROC_ACTUALIZAR_ACTIV
	@ID INT,
	@NOMBRE VARCHAR(30)
AS
	BEGIN TRY
		BEGIN TRAN
		UPDATE TB_Actividades SET Nombre_Actividad = @NOMBRE WHERE ID_Actividad = @ID
		COMMIT TRAN
	END TRY
	BEGIN CATCH
		ROLLBACK
	END CATCH
GO

--PROCEDIMIENTO ELIMINAR ACTIVIDADES
CREATE PROCEDURE PROC_ELIMINAR_ACTIV
	@ID INT
AS
	BEGIN TRY
		BEGIN TRAN
		DELETE FROM TB_Actividades WHERE ID_Actividad = @ID
		COMMIT TRAN
	END TRY
	BEGIN CATCH
		ROLLBACK
	END CATCH
GO

--PROCEDIMIENTO PARA INSERTAR PROYECTO
CREATE PROCEDURE PROC_INSERTAR_PROY
	@ID INT,
	@NOMBRE VARCHAR(50),
	@UBICACION VARCHAR(30)
AS 
	BEGIN TRY
		BEGIN TRAN
		INSERT INTO TB_Proyectos (ID_Proyecto, Nombre_Proyecto, Ubicacion) VALUES (@ID, @NOMBRE, @UBICACION)
		COMMIT TRAN
	END TRY
	BEGIN CATCH
		ROLLBACK
	END CATCH
GO

--PROCEDIMIENTO PARA ACTUALIZAR UN PROYECTO
CREATE PROCEDURE PROC_ACTUALIZAR_PROY
	@ID INT,
	@NOMBRE VARCHAR(50),
	@UBICACION VARCHAR(30)
AS 
	BEGIN TRY
		BEGIN TRAN
		UPDATE TB_Proyectos SET Nombre_Proyecto = @NOMBRE, Ubicacion = @UBICACION WHERE ID_Proyecto = @ID
		COMMIT TRAN
	END TRY
	BEGIN CATCH
		ROLLBACK
	END CATCH
GO

--PROCEDIMIENTO PARA ELIMINAR UN PROYECTO
CREATE PROCEDURE PROC_ELIMINAR_PROY
	@ID INT
AS 
	BEGIN TRY
		BEGIN TRAN
		DELETE FROM TB_Proyectos WHERE ID_Proyecto = @ID
		COMMIT TRAN
	END TRY
	BEGIN CATCH
		ROLLBACK
	END CATCH
GO

--PROCEDIMIENTO PARA INSERTAR UN TRABAJO
ALTER PROCEDURE PROC_INSERTAR_TRABJO
	@ID_TRABAJA INT,
	@ID_ACTIVI INT,
	@ID_PROYECT INT,
	@FECHA DATE,
	@HORA_INI TIME(7),
	@HORA_FIN TIME(7),
	@HORA_EXTRA FLOAT
AS 
	BEGIN TRY
		BEGIN TRAN
		
		select * from  TB_Trabajos
		INSERT INTO TB_Trabajos(ID_Trabajador, ID_Actividad, ID_Proyecto,Fecha, Hora_Inicio, Hora_Fin, Horas_Trabajadas, Horas_Extra_Trabajadas) 
		VALUES (@ID_TRABAJA, @ID_ACTIVI, @ID_PROYECT, @FECHA, @HORA_INI, @HORA_FIN, DATEDIFF(hour,@HORA_INI, @HORA_FIN), @HORA_EXTRA)
		COMMIT TRAN
	END TRY
	BEGIN CATCH
		ROLLBACK
	END CATCH
GO

dbcc useroptions

--PROCEDIMIENTO PARA ACTUALIZAR UN TRABAJO
ALTER PROCEDURE PROC_ACTUALIZAR_TRABJO
	@ID_TRABAJA INT,
	@ID_ACTIVI INT,
	@ID_PROYECT INT,
	@FECHA DATE,
	@HORA_INI TIME(7),
	@HORA_FIN TIME(7),
	@HORA_EXTRA FLOAT
AS 
	BEGIN TRY
		BEGIN TRAN
		UPDATE TB_Trabajos SET Hora_Inicio = @HORA_INI, Hora_Fin = @HORA_FIN, 
		Horas_Trabajadas = DATEDIFF(hour,@HORA_INI, @HORA_FIN), Horas_Extra_Trabajadas = @HORA_EXTRA 
		WHERE ID_Trabajador = @ID_TRABAJA AND ID_Actividad = @ID_ACTIVI AND ID_Proyecto = @ID_PROYECT AND Fecha = @FECHA
		COMMIT TRAN
	END TRY
	BEGIN CATCH
		ROLLBACK
	END CATCH
GO

--PROCEDIMIENTO PARA ELIMINAR UN TRABAJO
CREATE PROCEDURE PROC_ELIMINAR_TRABJO
	@ID_TRABAJA INT,
	@ID_ACTIVI INT,
	@ID_PROYECT INT,
	@FECHA DATE
AS 
	BEGIN TRY
		BEGIN TRAN
		DELETE FROM TB_Trabajos WHERE ID_Trabajador = @ID_TRABAJA AND ID_Actividad = @ID_ACTIVI AND ID_Proyecto = @ID_PROYECT AND  Fecha = @FECHA
		COMMIT TRAN
	END TRY
	BEGIN CATCH
		ROLLBACK
	END CATCH
GO

--PROCEDIMIENTO PARA INSERTAR PAGO
CREATE PROCEDURE PROC_INSERT_PAGO
	@ID_P INT, @ID_CONT INT, @OBS VARCHAR(30)
AS BEGIN
	DECLARE @ID_TRAB INT
	DECLARE @FEC_ULT DATE
	DECLARE @ID_OCUP INT
	DECLARE @HORAN_T INT
	DECLARE @HORAE_T INT

	SELECT @ID_TRAB=ID_TRABAJADOR, @ID_OCUP=OCUP.ID_OCUPACION FROM TB_CONTRATO CONT INNER JOIN TB_OCUPACIONES OCUP 
	ON CONT.ID_OCUPACION = OCUP.ID_OCUPACION WHERE CONT.ID_CONTRATO = @ID_CONT

	IF EXISTS (SELECT FECHA FROM TB_PAGOS WHERE ID_CONTRATO = @ID_CONT)
	BEGIN
		SELECT TOP 1 @FEC_ULT = FECHA FROM TB_PAGOS WHERE ID_CONTRATO = @ID_CONT ORDER BY FECHA DESC
		SELECT @HORAN_T=SUM(HORAS_TRABAJADAS), @HORAE_T=SUM(HORAS_EXTRA_TRABAJADAS) FROM TB_TRABAJOS 
		WHERE ID_TRABAJADOR = @ID_TRAB AND FECHA BETWEEN @FEC_ULT AND CONVERT(DATE, SWITCHOFFSET(SYSDATETIMEOFFSET(), '-05:00'))
		IF @HORAN_T+@HORAE_T IS NULL
			BEGIN 
				PRINT 'NO EXISTEN REGISTROS DE TRABAJOS EN ESTE CICLO DE PAGO'
			END
		ELSE
			BEGIN
				BEGIN TRAN
					INSERT INTO TB_PAGOS (ID_Pago, ID_Contrato, Horas_Normales_Trabajadas, Horas_Extras_Trabajadas, Monto_Pago, Fecha, Observacion)
					VALUES (@ID_P, @ID_CONT, @HORAN_T,@HORAE_T,
					(SELECT (PRECIO_HORA*@HORAN_T)+(PRECIO_HORA_EXTRA*@HORAE_T) FROM TB_OCUPACIONES WHERE ID_OCUPACION = @ID_OCUP), (SELECT CONVERT(DATE, SWITCHOFFSET(SYSDATETIMEOFFSET(), '-05:00'))), @OBS)
				COMMIT TRAN
			END
		END
	ELSE
		BEGIN
		SELECT @FEC_ULT = FECHA_INICIO FROM TB_CONTRATO WHERE ID_CONTRATO=@ID_CONT
		SELECT @HORAN_T=SUM(HORAS_TRABAJADAS), @HORAE_T=SUM(HORAS_EXTRA_TRABAJADAS) FROM TB_TRABAJOS 
		WHERE ID_TRABAJADOR = @ID_TRAB AND FECHA BETWEEN @FEC_ULT AND CONVERT(DATE, SWITCHOFFSET(SYSDATETIMEOFFSET(), '-05:00'))
		IF @HORAN_T+@HORAE_T IS NULL
			BEGIN
				PRINT 'NO EXISTEN REGISTROS DE TRABAJOS DESDE EL INICIO DEL CONTRATO'
			END
		ELSE
			BEGIN
				BEGIN TRAN
					INSERT INTO TB_PAGOS (ID_Pago, ID_Contrato, Horas_Normales_Trabajadas, Horas_Extras_Trabajadas, Monto_Pago, Fecha, Observacion)
					VALUES (@ID_P, @ID_CONT, @HORAN_T,@HORAE_T,
					(SELECT (PRECIO_HORA*@HORAN_T)+(PRECIO_HORA_EXTRA*@HORAE_T) FROM TB_OCUPACIONES WHERE ID_OCUPACION = @ID_OCUP), (SELECT CONVERT(DATE, SWITCHOFFSET(SYSDATETIMEOFFSET(), '-05:00'))), @OBS)
				COMMIT TRAN
			END
		END
END
GO

--PROCEDIMIENTO PARA ELIMINAR PAGO-
CREATE PROCEDURE ELIMINAR_PAGO
(
	@ID_PA INT
)
AS
BEGIN
	BEGIN TRAN
		DELETE FROM TB_PAGOS WHERE ID_PAGO = @ID_PA
	COMMIT TRAN
END
GO
--PROCEDIMIENTO PARA ELIMINAR UN ADMIN
CREATE PROCEDURE PROC_ELIMI_ADM
(
	@ID INT
)
AS
BEGIN TRAN
	DELETE FROM TB_Administradores WHERE ID_Trabajador = @ID
COMMIT TRAN
GO
----PROCEDIMIENTO PARA ACTUALIZAR ADMINISTRADORES
CREATE PROCEDURE PROC_MODI_ADM
(
	@ID INT,
	@USE VARCHAR(40),
	@PAS VARCHAR(60),
	@ACESS INT
)
AS
BEGIN TRAN
	UPDATE TB_Administradores SET Contraseña = @PAS, Nivel_Acceso = @ACESS
	WHERE ID_Trabajador = @ID
COMMIT TRAN
GO

---Creacion de funcion de registro de nuevos administradores--
CREATE PROCEDURE FUNC_INSER_ADMIN
(
	@ID_TRAB INT,
	@USER VARCHAR(20),
	@PASS VARCHAR(60),
	@ACCESO INT
)
AS
BEGIN
	IF EXISTS(SELECT * FROM TB_Administradores WHERE ID_Trabajador = @ID_TRAB)
		BEGIN
			BEGIN TRAN
			PRINT'EXISTE ADMIN'
			ROLLBACK
		END
	ELSE
		BEGIN
			BEGIN TRAN
			INSERT INTO TB_Administradores (ID_Trabajador, Usuario, Contraseña, Nivel_Acceso)
			VALUES (@ID_TRAB, @USER, @PASS,@ACCESO)
		COMMIT TRAN
		END
END
GO