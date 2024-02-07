/*Query para la creacion de la base de datos, tablas y consultas*/

/*
-------------------Creacion de la base de datos-----------------
*/

USE DB_RPconstruction
GO
SET LANGUAGE Español
SET DATEFORMAT DYM

CREATE DATABASE DB_RPconstruction
ON PRIMARY
(
	NAME = 'DB_PROYECTO_DATA',
	Filename = 'D:\Proyecto_DB\DB_PROYECTO.MDF',
	Size = 40MB,
	MAXSIZE = 100,
	FILEGROWTH = 10MB
)
LOG ON
(
	NAME = 'DB_PROYECTO_LOG',
	Filename = 'D:\Proyecto_DB\DB_PROYECTO.LDF',
	SIZE = 20MB,
	MAXSIZE = 40,
	FILEGROWTH = 20MB
)
GO


/*
----------------Creacion de tablas y definicion de PK y FK----------------
*/

--Tabla trabajadores--
CREATE TABLE TB_Trabajadores
(
	ID_Trabajador INT NOT NULL,
	Nombre_Trabajador VARCHAR(25) NOT NULL,
	Apellido_Trabajador VARCHAR(25) NOT NULL,
	Telefono_Trabajador VARCHAR(25) NOT NULL,
	Email_Trabajador VARCHAR(40),
	Direccion_Trabajador VARCHAR(100) NOT NULL,
	Cedula_Trabajador VARCHAR(20) NOT NULL,
	CONSTRAINT PK_TB_Trabajadores_ID_Trabajador PRIMARY KEY(ID_Trabajador)
)

--Tabla Administradores--
CREATE TABLE TB_Administradores
(
	Usuario VARCHAR(30) NOT NULL,
	Contraseña VARCHAR(30) NOT NULL,
	Nivel_Acceso INT NOT NULL,
	ID_Trabajador INT NOT NULL,

	CONSTRAINT PK_TB_Admin_Usuario PRIMARY KEY (Usuario),
	CONSTRAINT FK_TB_Admin_ID_Trabajador FOREIGN KEY (ID_Trabajador) REFERENCES TB_Trabajadores(ID_Trabajador),
)

--Tabla Ocupaciones--
CREATE TABLE TB_Ocupaciones
(
	ID_Ocupacion INT NOT NULL,
	Ocupacion VARCHAR(30) NOT NULL,
	Precio_Hora MONEY NOT NULL,
	Precio_Hora_Extra MONEY NOT NULL,

	CONSTRAINT PK_TB_Ocupacion_ID_Ocupacion PRIMARY KEY (ID_Ocupacion)
)


--Tabla contrato--
CREATE TABLE TB_Contrato
(
	ID_Contrato INT NOT NULL,
	ID_Trabajador INT NOT NULL,
	ID_Ocupacion INT NOT NULL,
	Contrato_Estado BIT,
	Fecha_Inicio DATE NOT NULL,
	Fecha_Fin DATE NOT NULL,
	Metodo_Pago VARCHAR (20),
	
	CONSTRAINT PK_TB_Contrato_ID_Contrato PRIMARY KEY (ID_Contrato),
	CONSTRAINT FK_TB_Contrato_ID_Trabajador FOREIGN KEY (ID_Trabajador) REFERENCES TB_Trabajadores(ID_Trabajador),
	CONSTRAINT FK_TB_Contrato_ID_Ocupacion FOREIGN KEY (ID_Ocupacion) REFERENCES TB_Ocupaciones(ID_Ocupacion)
)	

--Tabla Proyectos--
CREATE TABLE TB_Proyectos
(
	ID_Proyecto INT NOT NULL,
	Nombre_Proyecto VARCHAR(50) NOT NULL,
	Ubicacion VARCHAR(30) NOT NULL,
	CONSTRAINT PK_TB_Proyecto_ID_Proyecto PRIMARY KEY (ID_Proyecto)
)
GO

-- Tabla de Actividades--
CREATE TABLE TB_Actividades
(
	ID_Actividad INT NOT NULL,
	Nombre_Actividad VARCHAR(30) NOT NULL,
	
	CONSTRAINT PK_TB_Actividades_ID_Actividad PRIMARY KEY (ID_Actividad)
)
GO

--Tabla union trabajador fecha--
CREATE TABLE TB_Trabajos
(
	ID_Trabajador INT NOT NULL,
	ID_Actividad INT NOT NULL,
	ID_Proyecto INT NOT NULL,
	Fecha DATE NOT NULL,
	Hora_Inicio TIME NOT NULL,
	Hora_Fin TIME NOT NULL,
	Horas_Trabajadas FLOAT NOT NULL,
	Horas_Extra_Trabajadas FLOAT,

	CONSTRAINT PK_TB_Trabajos_ID_Trabajador_ID_Actividad_ID_Proyecto_Fecha PRIMARY KEY (ID_Trabajador, ID_Actividad, ID_Proyecto, Fecha),
	CONSTRAINT FK_TB_Trabajos_ID_Trabajador FOREIGN KEY (ID_Trabajador) REFERENCES TB_Trabajadores(ID_Trabajador),
	CONSTRAINT FK_TB_Trabajos_ID_Actividad FOREIGN KEY (ID_Actividad) REFERENCES TB_Actividades(ID_Actividad),
	CONSTRAINT FK_TB_Trabajos_ID_Proyecto FOREIGN KEY (ID_Proyecto) REFERENCES TB_Proyectos(ID_Proyecto)
)
GO

--Tabla de registro--
CREATE TABLE TB_Registro
(
	ID_Proyecto INT NOT NULL,
	ID_Actividad INT NOT NULL,
	FECHA DATE NOT NULL,
	
	CONSTRAINT PK_TB_Registro_ID_Proyecto_ID_Actividad_FECHA PRIMARY KEY (ID_Proyecto, ID_Actividad, FECHA),
	CONSTRAINT FK_TB_Registro_ID_Proyecto FOREIGN KEY (ID_Proyecto) REFERENCES TB_Proyectos(ID_Proyecto),
	CONSTRAINT FK_TB_Registro_ID_Actividad FOREIGN KEY (ID_Actividad) REFERENCES TB_Actividades(ID_Actividad)
)
GO

--Tabla de log
CREATE TABLE TB_Log(
	Usuario VARCHAR(30) NOT NULL DEFAULT(SYSTEM_USER),
	Fecha_Hora DATETIME DEFAULT (SWITCHOFFSET(SYSDATETIMEOFFSET(), '-05:00')),
	Accion VARCHAR(60),
	Tabla VARCHAR(15),

	CONSTRAINT PK_TB_LOG_USUARIO_FECHA_HORA PRIMARY KEY (Usuario, Fecha_Hora),
	CONSTRAINT FK_TB_LOG_USUARIO FOREIGN KEY (Usuario) REFERENCES TB_Administradores(Usuario)
)
GO

--Tabla Pagos
CREATE TABLE TB_Pagos
(
	ID_Pago INT NOT NULL,
	ID_Contrato INT NOT NULL,
	Horas_Normales_Trabajadas FLOAT,
	Horas_Extras_Trabajadas FLOAT,
	Monto_Pago MONEY,
	Fecha DATE,
	Observacion VARCHAR(30),

	CONSTRAINT PK_TB_PAGOS_ID_PAGO PRIMARY KEY (ID_Pago),
	CONSTRAINT FK_TB_PAGOS_ID_CONTRATO FOREIGN KEY (ID_Contrato) REFERENCES TB_Contrato(ID_Contrato)
)
GO
