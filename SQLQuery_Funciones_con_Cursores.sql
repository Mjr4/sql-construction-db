/* FUNCIONES DE IMPRESION DE */

CREATE FUNCTION INFO_PAGOS
(
	@ID_CONTRATO INT
)
RETURNS @TABLA TABLE(FECHA DATE, MONTO MONEY, ID_PAG INT)
AS
BEGIN
	DECLARE 
		@FECHAA DATE,
		@MONTO MONEY,
		@ID_PAG INT
	DECLARE CURSOR_REGISTRO_PAGO CURSOR SCROLL LOCAL
	FOR SELECT Fecha, Monto_Pago, ID_Pago FROM TB_Pagos
		WHERE ID_Contrato = @ID_CONTRATO
	
	OPEN CURSOR_REGISTRO_PAGO
	FETCH NEXT FROM CURSOR_REGISTRO_PAGO INTO @FECHAA, @MONTO, @ID_PAG
	WHILE @@FETCH_STATUS = 0
		BEGIN
			INSERT INTO @TABLA (FECHA, MONTO, ID_PAG)
			VALUES (@FECHAA, @MONTO, @ID_PAG)

			FETCH NEXT FROM CURSOR_REGISTRO_PAGO INTO @FECHAA, @MONTO, @ID_PAG
		END
	
	CLOSE CURSOR_REGISTRO_PAGO
	DEALLOCATE CURSOR_REGISTRO_PAGO
	RETURN
END
GO

/*FUNCION PARA VER LOS TRABAJOS HECHOS EN EL DIA*/
CREATE FUNCTION INFO_TRABAJOS_MES
(
	@mes int,
	@id_proyec int
)
RETURNS @TABLA TABLE(FECHA DATE, NOMBRE VARCHAR(40), PROYECTO VARCHAR(60), ACTIVIDAD VARCHAR(40), HORAS INT)
AS 
BEGIN
	DECLARE 
		@FECHA DATE,
		@NOMBRE VARCHAR(40),
		@PROYECTO VARCHAR(60),
		@ACTIVIDAD VARCHAR(40),
		@HORAS INT

	DECLARE CURSOR_RECOPILA_MES CURSOR SCROLL LOCAL
	FOR SELECT TRAB.FECHA, (DORES.Nombre_trabajador+' '+DORES.Apellido_Trabajador)'TRAB_Nombre',
		PROY.Nombre_Proyecto, ACTI.Nombre_Actividad, (TRAB.Horas_Trabajadas + TRAB.Horas_Extra_Trabajadas) 'Total Horas'
		FROM TB_TRABAJOS TRAB INNER JOIN TB_TRABAJADORES DORES
		ON TRAB.ID_trabajador = DORES.ID_Trabajador INNER JOIN TB_PROYECTOS PROY
		ON TRAB.ID_Proyecto = PROY.ID_Proyecto INNER JOIN TB_Actividades ACTI
		ON ACTI.ID_Actividad = TRAB.ID_Actividad
		WHERE TRAB.ID_Proyecto = @id_proyec
	OPEN CURSOR_RECOPILA_MES
	FETCH NEXT FROM CURSOR_RECOPILA_MES INTO @FECHA, @NOMBRE, @PROYECTO, @ACTIVIDAD, @HORAS
	
	WHILE @@FETCH_STATUS = 0
		BEGIN
				IF @mes = cast(DATEPART(MONTH,@FECHA) as INT)
				BEGIN
					INSERT INTO @TABLA (FECHA , NOMBRE, PROYECTO, ACTIVIDAD, HORAS)
					VALUES (@FECHA, @NOMBRE, @PROYECTO, @ACTIVIDAD, @HORAS)
				END
				
			FETCH NEXT FROM CURSOR_RECOPILA_MES INTO @FECHA, @NOMBRE, @PROYECTO, @ACTIVIDAD, @HORAS
		END
	CLOSE CURSOR_RECOPILA_MES
	DEALLOCATE CURSOR_RECOPILA_MES
	RETURN
END
GO