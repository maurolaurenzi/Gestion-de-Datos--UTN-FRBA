USE [GD1C2020]
GO

/****** Object:  Schema [GESTIONADOS_POR_LA_PANDEMIA]    Script Date: 8/6/2020 19:13:56 ******/
CREATE SCHEMA [GESTIONADOS_POR_LA_PANDEMIA]
GO

--Creando Tablas
CREATE TABLE GESTIONADOS_POR_LA_PANDEMIA.Cliente(
ID_CLIENTE INT PRIMARY KEY,
CLIENTE_APELLIDO NVARCHAR(255),
CLIENTE_NOMBRE NVARCHAR(255),
CLIENTE_DNI DECIMAL(18,0),
CLIENTE_FECHA_NAC DATETIME2(3),
CLIENTE_MAIL NVARCHAR(255),
CLIENTE_TELEFONO INT
)
GO

CREATE TABLE GESTIONADOS_POR_LA_PANDEMIA.Factura(
FACTURA_NRO DECIMAL(18,0) PRIMARY KEY,
FACTURA_FECHA DATETIME2(3),
ID_CLIENTE INT,
ID_SUCURSAL INT
)
GO

CREATE TABLE GESTIONADOS_POR_LA_PANDEMIA.Sucursal(
ID_SUCURSAL INT PRIMARY KEY,
SUCURSAL_DIR NVARCHAR(255),
SUCURSAL_MAIL NVARCHAR(255),
SUCURSAL_TELEFONO DECIMAL(18,0)
)
GO

CREATE TABLE GESTIONADOS_POR_LA_PANDEMIA.Estadia_Facturada(
ID_FACT_ESTADIA INT PRIMARY KEY,
FACTURA_NRO DECIMAL(18,0),
ESTADIA_CODIGO DECIMAL(18,0),
ID_HABITACION INT,
FECHA_CHECK_IN DATETIME2(3),
FECHA_CHECK_OUT DATETIME2(3),
HABITACION_PRECIO DECIMAL(18,2)
)
GO

CREATE TABLE GESTIONADOS_POR_LA_PANDEMIA.Pasaje_Facturado(
ID_FACT_PASAJE INT PRIMARY KEY,
FACTURA_NRO DECIMAL(18,0),
PASAJE_CODIGO DECIMAL(18,2),
PASAJE_PRECIO DECIMAL(18,2)
)
GO

CREATE TABLE GESTIONADOS_POR_LA_PANDEMIA.Compra(
COMPRA_NUMERO DECIMAL(18,0) PRIMARY KEY,
COMPRA_FECHA DATETIME2(3),
COSTO_TOTAL DECIMAL(18,2)
)
GO

CREATE TABLE GESTIONADOS_POR_LA_PANDEMIA.Pasaje(
PASAJE_CODIGO DECIMAL(18,2) PRIMARY KEY,
COMPRA_NUMERO DECIMAL(18,0),
PASAJE_COSTO DECIMAL(18,2),
VUELO_CODIGO DECIMAL(19,0),
BUTACA_ID INT
)
GO

CREATE TABLE GESTIONADOS_POR_LA_PANDEMIA.Vuelo(
VUELO_CODIGO DECIMAL(19,0) PRIMARY KEY,
VUELO_FECHA_SALIDA DATETIME2(3),
VUELO_FECHA_LLEGADA DATETIME2(3),
RUTA_AREA_CODIGO DECIMAL(18,0),
AVION_IDENTIFICADOR NVARCHAR(50)
)
GO

CREATE TABLE GESTIONADOS_POR_LA_PANDEMIA.Ruta_Aerea(
RUTA_AEREA_CODIGO DECIMAL(18,0) PRIMARY KEY,
RUTA_AEREA_CIU_ORIGEN NVARCHAR(255),
RUTA_AEREA_CIU_DESTINO NVARCHAR(255)
)
GO

CREATE TABLE GESTIONADOS_POR_LA_PANDEMIA.Avion(
AVION_IDENTIFICADOR NVARCHAR(50) PRIMARY KEY,
AVION_MODELO NVARCHAR(50)
)
GO

CREATE TABLE GESTIONADOS_POR_LA_PANDEMIA.Butaca(
BUTACA_ID INT PRIMARY KEY,
BUTACA_NUMERO DECIMAL(18,0),
BUTACA_TIPO NVARCHAR(255),
AVION_IDENTIFICADOR NVARCHAR(50)
)
GO

CREATE TABLE GESTIONADOS_POR_LA_PANDEMIA.Estadia(
ESTADIA_CODIGO DECIMAL(18,0) PRIMARY KEY,
COMPRA_NUMERO DECIMAL(18,0),
ESTADIA_FECHA_INI DATETIME2(3),
ESTADIA_CANTIDAD_NOCHES DECIMAL(18,0),
HOTEL_RAZON_SOCIAL NVARCHAR(255)
)
GO

CREATE TABLE GESTIONADOS_POR_LA_PANDEMIA.Hotel(
HOTEL_RAZON_SOCIAL NVARCHAR(255) PRIMARY KEY,
HOTEL_CALLE NVARCHAR(50),
HOTEL_NRO_CALLE DECIMAL(18,0),
HOTEL_CANTIDAD_ESTRELLAS INT 
)
GO

CREATE TABLE GESTIONADOS_POR_LA_PANDEMIA.Habitacion(
ID_HABITACION INT PRIMARY KEY,
HABITACION_NUMERO DECIMAL(18,0),
HOTEL_RAZON_SOCIAL NVARCHAR(255),
HABITACION_PISO DECIMAL(18,0),
HABITACION_FRENTE NVARCHAR(50),
TIPO_HABITACION_CODIGO DECIMAL(18,0)
)
GO

CREATE TABLE GESTIONADOS_POR_LA_PANDEMIA.Habitacion_X_Estadia(
ID_HABITACION INT,
ESTADIA_CODIGO DECIMAL(18,0),
CONSTRAINT habxest_pk PRIMARY KEY (ID_HABITACION,ESTADIA_CODIGO)
)
GO

CREATE TABLE GESTIONADOS_POR_LA_PANDEMIA.Tipo_Habitacion(
TIPO_HABITACION_CODIGO DECIMAL(18,0) PRIMARY KEY,
TIPO_HABITACION_DESC NVARCHAR(50),
HABITACION_COSTO DECIMAL(18, 2)
)
GO

--Se agregan las FK
ALTER TABLE GESTIONADOS_POR_LA_PANDEMIA.Factura
ADD FOREIGN KEY(ID_CLIENTE) REFERENCES GESTIONADOS_POR_LA_PANDEMIA.Cliente(ID_CLIENTE);

ALTER TABLE GESTIONADOS_POR_LA_PANDEMIA.Factura
ADD FOREIGN KEY(ID_SUCURSAL) REFERENCES GESTIONADOS_POR_LA_PANDEMIA.Sucursal(ID_SUCURSAL);

ALTER TABLE GESTIONADOS_POR_LA_PANDEMIA.Estadia_Facturada
ADD FOREIGN KEY(FACTURA_NRO) REFERENCES GESTIONADOS_POR_LA_PANDEMIA.Factura(FACTURA_NRO);

ALTER TABLE GESTIONADOS_POR_LA_PANDEMIA.Estadia_Facturada
ADD FOREIGN KEY(ESTADIA_CODIGO) REFERENCES GESTIONADOS_POR_LA_PANDEMIA.Estadia(ESTADIA_CODIGO);

ALTER TABLE GESTIONADOS_POR_LA_PANDEMIA.Estadia_Facturada
ADD FOREIGN KEY(ID_HABITACION) REFERENCES GESTIONADOS_POR_LA_PANDEMIA.Habitacion(ID_HABITACION);

ALTER TABLE GESTIONADOS_POR_LA_PANDEMIA.Pasaje_Facturado
ADD FOREIGN KEY(FACTURA_NRO) REFERENCES GESTIONADOS_POR_LA_PANDEMIA.Factura(FACTURA_NRO);

ALTER TABLE GESTIONADOS_POR_LA_PANDEMIA.Pasaje_Facturado
ADD FOREIGN KEY(PASAJE_CODIGO) REFERENCES GESTIONADOS_POR_LA_PANDEMIA.Pasaje(PASAJE_CODIGO);

ALTER TABLE GESTIONADOS_POR_LA_PANDEMIA.Pasaje
ADD FOREIGN KEY(COMPRA_NUMERO) REFERENCES GESTIONADOS_POR_LA_PANDEMIA.Compra(COMPRA_NUMERO);

ALTER TABLE GESTIONADOS_POR_LA_PANDEMIA.Pasaje
ADD FOREIGN KEY(VUELO_CODIGO) REFERENCES GESTIONADOS_POR_LA_PANDEMIA.Vuelo(VUELO_CODIGO);

ALTER TABLE GESTIONADOS_POR_LA_PANDEMIA.Pasaje
ADD FOREIGN KEY(BUTACA_ID) REFERENCES GESTIONADOS_POR_LA_PANDEMIA.Butaca(BUTACA_ID);

ALTER TABLE GESTIONADOS_POR_LA_PANDEMIA.Vuelo
ADD FOREIGN KEY(AVION_IDENTIFICADOR) REFERENCES GESTIONADOS_POR_LA_PANDEMIA.Avion(AVION_IDENTIFICADOR);

ALTER TABLE GESTIONADOS_POR_LA_PANDEMIA.Vuelo
ADD FOREIGN KEY(RUTA_AREA_CODIGO) REFERENCES GESTIONADOS_POR_LA_PANDEMIA.Ruta_Aerea(RUTA_AEREA_CODIGO);

ALTER TABLE GESTIONADOS_POR_LA_PANDEMIA.Butaca
ADD FOREIGN KEY(AVION_IDENTIFICADOR) REFERENCES GESTIONADOS_POR_LA_PANDEMIA.Avion(AVION_IDENTIFICADOR);

ALTER TABLE GESTIONADOS_POR_LA_PANDEMIA.Estadia
ADD FOREIGN KEY(COMPRA_NUMERO) REFERENCES GESTIONADOS_POR_LA_PANDEMIA.Compra(COMPRA_NUMERO);

ALTER TABLE GESTIONADOS_POR_LA_PANDEMIA.Estadia
ADD FOREIGN KEY(HOTEL_RAZON_SOCIAL) REFERENCES GESTIONADOS_POR_LA_PANDEMIA.Hotel(HOTEL_RAZON_SOCIAL);

ALTER TABLE GESTIONADOS_POR_LA_PANDEMIA.Habitacion_X_Estadia
ADD FOREIGN KEY(ID_HABITACION) REFERENCES GESTIONADOS_POR_LA_PANDEMIA.Habitacion(ID_HABITACION);

ALTER TABLE GESTIONADOS_POR_LA_PANDEMIA.Habitacion_X_Estadia
ADD FOREIGN KEY(ESTADIA_CODIGO) REFERENCES GESTIONADOS_POR_LA_PANDEMIA.Estadia(ESTADIA_CODIGO);

ALTER TABLE GESTIONADOS_POR_LA_PANDEMIA.Habitacion
ADD FOREIGN KEY(HOTEL_RAZON_SOCIAL) REFERENCES GESTIONADOS_POR_LA_PANDEMIA.Hotel(HOTEL_RAZON_SOCIAL);

ALTER TABLE GESTIONADOS_POR_LA_PANDEMIA.Habitacion
ADD FOREIGN KEY(TIPO_HABITACION_CODIGO) REFERENCES GESTIONADOS_POR_LA_PANDEMIA.Tipo_Habitacion(TIPO_HABITACION_CODIGO);
GO

--Se agregan CONSTRAINTS
ALTER TABLE GESTIONADOS_POR_LA_PANDEMIA.Cliente
ADD CONSTRAINT uq_dni_cli UNIQUE(CLIENTE_DNI);

ALTER TABLE GESTIONADOS_POR_LA_PANDEMIA.Cliente
ADD CONSTRAINT ck_mail_cli CHECK(CLIENTE_MAIL LIKE '%_@__%.__%');

ALTER TABLE GESTIONADOS_POR_LA_PANDEMIA.Sucursal
ADD CONSTRAINT ck_mail_suc CHECK(SUCURSAL_MAIL LIKE '%_@__%.__%');

ALTER TABLE GESTIONADOS_POR_LA_PANDEMIA.Estadia_Facturada
ADD CONSTRAINT dl_precio_hab DEFAULT 0 FOR HABITACION_PRECIO;

ALTER TABLE GESTIONADOS_POR_LA_PANDEMIA.Tipo_Habitacion
ADD CONSTRAINT dl_hab_costo DEFAULT 0 FOR HABITACION_COSTO;

ALTER TABLE GESTIONADOS_POR_LA_PANDEMIA.Pasaje_Facturado
ADD CONSTRAINT dl_pas_precio DEFAULT 0 FOR PASAJE_PRECIO;

ALTER TABLE GESTIONADOS_POR_LA_PANDEMIA.Compra
ADD CONSTRAINT dl_compra_costo_tot DEFAULT 0 FOR COSTO_TOTAL;

ALTER TABLE GESTIONADOS_POR_LA_PANDEMIA.Pasaje
ADD CONSTRAINT dl_pas_costo DEFAULT 0 FOR PASAJE_COSTO;

ALTER TABLE GESTIONADOS_POR_LA_PANDEMIA.Cliente
ALTER COLUMN CLIENTE_APELLIDO NVARCHAR(255) NOT NULL;

ALTER TABLE GESTIONADOS_POR_LA_PANDEMIA.Cliente
ALTER COLUMN CLIENTE_NOMBRE NVARCHAR(255) NOT NULL;

ALTER TABLE GESTIONADOS_POR_LA_PANDEMIA.Compra
ALTER COLUMN COMPRA_FECHA DATETIME2(3) NOT NULL;

ALTER TABLE GESTIONADOS_POR_LA_PANDEMIA.Factura
ALTER COLUMN FACTURA_FECHA DATETIME2(3) NOT NULL;

ALTER TABLE GESTIONADOS_POR_LA_PANDEMIA.Estadia_Facturada
ALTER COLUMN FECHA_CHECK_IN DATETIME2(3) NOT NULL;

ALTER TABLE GESTIONADOS_POR_LA_PANDEMIA.Estadia_Facturada
ALTER COLUMN FECHA_CHECK_OUT DATETIME2(3) NOT NULL;

ALTER TABLE GESTIONADOS_POR_LA_PANDEMIA.Vuelo
ALTER COLUMN VUELO_FECHA_SALIDA DATETIME2(3) NOT NULL;

ALTER TABLE GESTIONADOS_POR_LA_PANDEMIA.Vuelo
ALTER COLUMN VUELO_FECHA_LLEGADA DATETIME2(3) NOT NULL;

ALTER TABLE GESTIONADOS_POR_LA_PANDEMIA.Ruta_Aerea
ALTER COLUMN RUTA_AEREA_CIU_ORIGEN NVARCHAR(255) NOT NULL;

ALTER TABLE GESTIONADOS_POR_LA_PANDEMIA.Ruta_Aerea
ALTER COLUMN RUTA_AEREA_CIU_DESTINO NVARCHAR(255) NOT NULL;

ALTER TABLE GESTIONADOS_POR_LA_PANDEMIA.Butaca
ALTER COLUMN BUTACA_NUMERO DECIMAL(18,0) NOT NULL;

ALTER TABLE GESTIONADOS_POR_LA_PANDEMIA.Estadia
ALTER COLUMN ESTADIA_FECHA_INI DATETIME2(3) NOT NULL;

ALTER TABLE GESTIONADOS_POR_LA_PANDEMIA.Estadia
ALTER COLUMN ESTADIA_CANTIDAD_NOCHES DECIMAL(18,0) NOT NULL;

--Decido agregar la columna "HABITACION_COSTO" a Habitacion_X_Estadia para tener mas facilidad a la hora de calcular el costo total de la estadia.
--Esta variable se calculara mediante un trigger cuando se instancie la tabla.
ALTER TABLE GESTIONADOS_POR_LA_PANDEMIA.Habitacion_X_Estadia
ADD HABITACION_COSTO DECIMAL(18, 2);
GO

--Se agregan los triggers
--Se suma el costo del pasaje al costo total de la compra asociada al mismo
 CREATE TRIGGER GESTIONADOS_POR_LA_PANDEMIA.sumar_pasaje_a_costo_total
 ON GESTIONADOS_POR_LA_PANDEMIA.Pasaje FOR INSERT 
 AS
 BEGIN
 UPDATE GESTIONADOS_POR_LA_PANDEMIA.Compra 
 SET COSTO_TOTAL = COSTO_TOTAL + PASAJE_COSTO FROM inserted
 WHERE Compra.COMPRA_NUMERO = inserted.COMPRA_NUMERO
 END;
 GO

 --Analogo al anterior, se le suma el costo de cada habitacion x estadia instanciada al costo total de la compra asociada
 CREATE TRIGGER GESTIONADOS_POR_LA_PANDEMIA.sumar_hab_a_costo_total
 ON GESTIONADOS_POR_LA_PANDEMIA.Habitacion_X_Estadia FOR INSERT 
 AS
 BEGIN
 UPDATE GESTIONADOS_POR_LA_PANDEMIA.Compra 
 SET COSTO_TOTAL = c.COSTO_TOTAL + (i.HABITACION_COSTO*e.ESTADIA_CANTIDAD_NOCHES)
 FROM Compra c, inserted i, Estadia e
 WHERE c.COMPRA_NUMERO = e.COMPRA_NUMERO 
 AND e.ESTADIA_CODIGO = i.ESTADIA_CODIGO
 END;
 GO

 --En caso de que creemos una nueva instancia de Pasaje, pero aun no exista un registro de Compra asociado, se crean ambos al mismo tiempo.
 CREATE TRIGGER GESTIONADOS_POR_LA_PANDEMIA.crear_compra_tras_instancia_de_pasaje
 ON GESTIONADOS_POR_LA_PANDEMIA.Pasaje INSTEAD OF INSERT 
 AS
 BEGIN
  IF NOT EXISTS (SELECT * 
                FROM GESTIONADOS_POR_LA_PANDEMIA.Compra INNER JOIN inserted
                ON Compra.COMPRA_NUMERO = inserted.COMPRA_NUMERO)
				INSERT INTO GESTIONADOS_POR_LA_PANDEMIA.Compra(COMPRA_NUMERO, COMPRA_FECHA) 
				SELECT i.COMPRA_NUMERO, GETDATE() FROM inserted i;
  INSERT INTO GESTIONADOS_POR_LA_PANDEMIA.Pasaje(PASAJE_CODIGO,COMPRA_NUMERO, PASAJE_COSTO, VUELO_CODIGO, BUTACA_ID)
  SELECT PASAJE_CODIGO, COMPRA_NUMERO, PASAJE_COSTO, VUELO_CODIGO, BUTACA_ID FROM inserted;

 END;
 GO 

  --Analogo al anterior, tras la instanciacion de una nueva estadia. Con la salvedad de que, en este caso, es necesario tener un hotel asociado a la estadia 
  --antes de instanciar la misma.
 CREATE TRIGGER GESTIONADOS_POR_LA_PANDEMIA.crear_compra_tras_instancia_de_estadia
 ON GESTIONADOS_POR_LA_PANDEMIA.Estadia INSTEAD OF INSERT 
 AS
 BEGIN
  IF NOT EXISTS (SELECT * 
                FROM GESTIONADOS_POR_LA_PANDEMIA.Compra INNER JOIN inserted
                ON Compra.COMPRA_NUMERO = inserted.COMPRA_NUMERO)
				INSERT INTO GESTIONADOS_POR_LA_PANDEMIA.Compra(COMPRA_NUMERO, COMPRA_FECHA) 
				SELECT i.COMPRA_NUMERO, GETDATE() FROM inserted i;
  INSERT INTO GESTIONADOS_POR_LA_PANDEMIA.Estadia(ESTADIA_CODIGO, COMPRA_NUMERO, ESTADIA_FECHA_INI, ESTADIA_CANTIDAD_NOCHES, HOTEL_RAZON_SOCIAL)
  SELECT ESTADIA_CODIGO, COMPRA_NUMERO, ESTADIA_FECHA_INI, ESTADIA_CANTIDAD_NOCHES, HOTEL_RAZON_SOCIAL FROM inserted;

 END;
 GO

 --se instancia Hab_X_Est con las PK cargadas por el usuario y el COSTO_HABITACION se carga automaticamente segun las PK dadas
 --Sirve para asegurarnos que el precio sea el correcto, por si el usuario introduce uno erroneo.
 CREATE TRIGGER GESTIONADOS_POR_LA_PANDEMIA.cargar_costo_hab_x_estadia
 ON GESTIONADOS_POR_LA_PANDEMIA.Habitacion_X_Estadia INSTEAD OF INSERT
 AS
 BEGIN
 INSERT INTO GESTIONADOS_POR_LA_PANDEMIA.Habitacion_X_Estadia(ESTADIA_CODIGO,ID_HABITACION,HABITACION_COSTO)
 SELECT i.ESTADIA_CODIGO, i.ID_HABITACION, th.HABITACION_COSTO
 FROM Tipo_Habitacion th, Habitacion h, inserted i
 WHERE th.TIPO_HABITACION_CODIGO = h.TIPO_HABITACION_CODIGO
 AND h.ID_HABITACION = i.ID_HABITACION;
 END;
 GO 

 CREATE TRIGGER GESTIONADOS_POR_LA_PANDEMIA.fechas_correctas_estadia_facturada
 ON GESTIONADOS_POR_LA_PANDEMIA.Estadia_Facturada INSTEAD OF INSERT
 AS
 DECLARE @dif INT = 0;
 DECLARE @dif_check_in INT = 0;
 DECLARE @dif_check_out INT = 0;
 BEGIN
      SELECT @dif = DATEDIFF(DAY, FECHA_CHECK_IN, FECHA_CHECK_OUT)
	  FROM inserted;

	  IF(@dif <= 0)
	  THROW 50005, N'El check out debe ser al menos un dia despues del check in', 5;

      SELECT @dif_check_in = DATEDIFF(DAY, e.ESTADIA_FECHA_INI, i.FECHA_CHECK_IN)
      FROM Estadia e, inserted i
	  WHERE i.ESTADIA_CODIGO = e.ESTADIA_CODIGO;

	  IF(@dif_check_in< 0)
	  THROW 50001, N'El check in no puede ser antes de la fecha de inicio de estadia', 1;

	  SELECT @dif_check_out = DATEDIFF(DAY, DATEADD(DAY,e.ESTADIA_CANTIDAD_NOCHES,e.ESTADIA_FECHA_INI), i.FECHA_CHECK_OUT)
      FROM Estadia e, inserted i
	  WHERE i.ESTADIA_CODIGO = e.ESTADIA_CODIGO;

	  IF(@dif_check_out> 0)
	  THROW 50003, N'El check out no puede ser despues de la fecha de fin de estadia', 3;

	  INSERT INTO GESTIONADOS_POR_LA_PANDEMIA.Estadia_Facturada(ID_FACT_ESTADIA,FACTURA_NRO,ESTADIA_CODIGO,ID_HABITACION,FECHA_CHECK_IN,FECHA_CHECK_OUT,HABITACION_PRECIO)
	  SELECT ID_FACT_ESTADIA,FACTURA_NRO,ESTADIA_CODIGO,ID_HABITACION,FECHA_CHECK_IN,FECHA_CHECK_OUT,HABITACION_PRECIO FROM inserted;
 END;
 GO



 
