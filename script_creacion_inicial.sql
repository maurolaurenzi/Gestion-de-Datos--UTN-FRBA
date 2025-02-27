USE [GD1C2020]
GO

/****** Object:  Schema [GESTIONADOS_POR_LA_PANDEMIA]    Script Date: 8/6/2020 19:13:56 ******/
CREATE SCHEMA [GESTIONADOS_POR_LA_PANDEMIA]
GO

--Creando Tablas
CREATE TABLE GESTIONADOS_POR_LA_PANDEMIA.Cliente(
ID_CLIENTE INT IDENTITY(500,1) PRIMARY KEY,
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
ID_SUCURSAL INT,
MONTO_TOTAL DECIMAL(18,2)
)
GO

CREATE TABLE GESTIONADOS_POR_LA_PANDEMIA.Sucursal(
ID_SUCURSAL INT IDENTITY(1,1) PRIMARY KEY,
SUCURSAL_DIR NVARCHAR(255),
SUCURSAL_MAIL NVARCHAR(255),
SUCURSAL_TELEFONO DECIMAL(18,0)
)
GO

CREATE TABLE GESTIONADOS_POR_LA_PANDEMIA.Estadia_Facturada(
ID_FACT_ESTADIA INT IDENTITY(600,1) PRIMARY KEY,
FACTURA_NRO DECIMAL(18,0),
ESTADIA_CODIGO DECIMAL(18,0),
ESTADIA_CANTIDAD_NOCHES DECIMAL(18,0),
FECHA_CHECK_IN DATETIME2(3),
FECHA_CHECK_OUT DATETIME2(3),
PRECIO_ESTADIA DECIMAL(18,2)
)
GO

CREATE TABLE GESTIONADOS_POR_LA_PANDEMIA.Habitacion_Vendida(
ID_FACT_ESTADIA INT,
ID_HABITACION INT,
HABITACION_PRECIO DECIMAL(18,2),
CONSTRAINT pk_hab_ven PRIMARY KEY(ID_FACT_ESTADIA,ID_HABITACION)
)
GO

CREATE TABLE GESTIONADOS_POR_LA_PANDEMIA.Pasaje_Facturado(
ID_FACT_PASAJE INT IDENTITY(100,1) PRIMARY KEY,
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
PASAJE_PRECIO DECIMAL(18,2),
VUELO_CODIGO DECIMAL(19,0),
BUTACA_ID INT
)
GO

CREATE TABLE GESTIONADOS_POR_LA_PANDEMIA.Vuelo(
VUELO_CODIGO DECIMAL(19,0) PRIMARY KEY,
VUELO_FECHA_SALIDA DATETIME2(3),
VUELO_FECHA_LLEGADA DATETIME2(3),
RUTA_ID INT,
AVION_IDENTIFICADOR NVARCHAR(50),
AEROLINEA_NOMBRE NVARCHAR(255)
)
GO

CREATE TABLE GESTIONADOS_POR_LA_PANDEMIA.Ruta_Aerea(
RUTA_ID INT IDENTITY(40,1) PRIMARY KEY,
RUTA_AEREA_CODIGO DECIMAL(18,0),
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
BUTACA_ID INT IDENTITY(30,1) PRIMARY KEY,
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
HOTEL_ID INT
)
GO

CREATE TABLE GESTIONADOS_POR_LA_PANDEMIA.Hotel(
HOTEL_ID INT IDENTITY(200,1) PRIMARY KEY,
HOTEL_NOMBRE NVARCHAR(255),
HOTEL_CALLE NVARCHAR(50),
HOTEL_NRO_CALLE DECIMAL(18,0),
HOTEL_CANTIDAD_ESTRELLAS INT 
)
GO

CREATE TABLE GESTIONADOS_POR_LA_PANDEMIA.Habitacion(
ID_HABITACION INT IDENTITY(20,1) PRIMARY KEY,
HOTEL_ID INT,
HABITACION_NUMERO DECIMAL(18,0),
HABITACION_PISO DECIMAL(18,0),
HABITACION_FRENTE NVARCHAR(50),
TIPO_HABITACION_CODIGO DECIMAL(18,0),
HABITACION_COSTO DECIMAL(18, 2),
HABITACION_PRECIO DECIMAL(18,2)
)
GO

CREATE TABLE GESTIONADOS_POR_LA_PANDEMIA.Habitacion_X_Estadia(
ID_HABITACION INT,
ESTADIA_CODIGO DECIMAL(18,0),
HABITACION_COSTO DECIMAL(18, 2)
CONSTRAINT habxest_pk PRIMARY KEY (ID_HABITACION,ESTADIA_CODIGO)
)
GO

CREATE TABLE GESTIONADOS_POR_LA_PANDEMIA.Tipo_Habitacion(
TIPO_HABITACION_CODIGO DECIMAL(18,0) PRIMARY KEY,
TIPO_HABITACION_DESC NVARCHAR(50),
)
GO

--Se crean las vistas

CREATE VIEW GESTIONADOS_POR_LA_PANDEMIA.ItemsMixtos_Factura
AS
SELECT f.FACTURA_NRO, f.ID_CLIENTE, f.MONTO_TOTAL, ef.ESTADIA_CODIGO, ef.PRECIO_ESTADIA, p.PASAJE_CODIGO, p.PASAJE_PRECIO 
FROM GESTIONADOS_POR_LA_PANDEMIA.Factura f, GESTIONADOS_POR_LA_PANDEMIA.Estadia_Facturada ef, GESTIONADOS_POR_LA_PANDEMIA.Pasaje_Facturado p
WHERE ef.FACTURA_NRO = f.FACTURA_NRO
AND p.FACTURA_NRO = f.FACTURA_NRO
AND p.FACTURA_NRO = ef.FACTURA_NRO;
GO

CREATE VIEW GESTIONADOS_POR_LA_PANDEMIA.Estadias_Factura
AS
SELECT f.FACTURA_NRO, f.ID_CLIENTE, f.MONTO_TOTAL, ef.ESTADIA_CODIGO, ef.PRECIO_ESTADIA 
FROM GESTIONADOS_POR_LA_PANDEMIA.Factura f, GESTIONADOS_POR_LA_PANDEMIA.Estadia_Facturada ef
WHERE ef.FACTURA_NRO = f.FACTURA_NRO;
GO

CREATE VIEW GESTIONADOS_POR_LA_PANDEMIA.Pasajes_Factura
AS
SELECT f.FACTURA_NRO, f.ID_CLIENTE, f.MONTO_TOTAL, p.PASAJE_CODIGO, p.PASAJE_PRECIO 
FROM GESTIONADOS_POR_LA_PANDEMIA.Factura f, GESTIONADOS_POR_LA_PANDEMIA.Pasaje_Facturado p
WHERE p.FACTURA_NRO = f.FACTURA_NRO
GO

CREATE VIEW GESTIONADOS_POR_LA_PANDEMIA.ItemsMixtos_Compra
AS
SELECT c.COMPRA_NUMERO,c.COSTO_TOTAL,e.ESTADIA_CODIGO,p.PASAJE_CODIGO
FROM GESTIONADOS_POR_LA_PANDEMIA.Compra c, GESTIONADOS_POR_LA_PANDEMIA.Estadia e, GESTIONADOS_POR_LA_PANDEMIA.Pasaje p
WHERE c.COMPRA_NUMERO = e.COMPRA_NUMERO
AND c.COMPRA_NUMERO = p.COMPRA_NUMERO
AND e.COMPRA_NUMERO = p.COMPRA_NUMERO
GO

CREATE VIEW GESTIONADOS_POR_LA_PANDEMIA.Compra_Estadia
AS
SELECT c.COMPRA_NUMERO, c.COMPRA_FECHA, c.COSTO_TOTAL, e.ESTADIA_CODIGO, e.HOTEL_ID, e.ESTADIA_FECHA_INI, e.ESTADIA_CANTIDAD_NOCHES
FROM GESTIONADOS_POR_LA_PANDEMIA.Compra c, GESTIONADOS_POR_LA_PANDEMIA.Estadia e
WHERE c.COMPRA_NUMERO = e.COMPRA_NUMERO
GO

CREATE VIEW GESTIONADOS_POR_LA_PANDEMIA.Compra_Pasaje
AS
SELECT c.COMPRA_NUMERO, c.COMPRA_FECHA, c.COSTO_TOTAL, p.PASAJE_CODIGO,p.VUELO_CODIGO
FROM GESTIONADOS_POR_LA_PANDEMIA.Compra c, GESTIONADOS_POR_LA_PANDEMIA.Pasaje p
WHERE c.COMPRA_NUMERO = p.COMPRA_NUMERO
GO

CREATE VIEW GESTIONADOS_POR_LA_PANDEMIA.Vuelos_Programados
AS
SELECT v.VUELO_CODIGO, r.RUTA_AEREA_CIU_ORIGEN AS ORIGEN, r.RUTA_AEREA_CIU_DESTINO AS DESTINO, v.VUELO_FECHA_SALIDA AS SALIDA, v.VUELO_FECHA_LLEGADA AS LLEGADA, v.AEROLINEA_NOMBRE AS AEROLINEA
FROM GESTIONADOS_POR_LA_PANDEMIA.Vuelo v, GESTIONADOS_POR_LA_PANDEMIA.Ruta_Aerea r
WHERE v.RUTA_ID = r.RUTA_ID
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

ALTER TABLE GESTIONADOS_POR_LA_PANDEMIA.Habitacion_Vendida
ADD FOREIGN KEY(ID_HABITACION) REFERENCES GESTIONADOS_POR_LA_PANDEMIA.Habitacion(ID_HABITACION);

ALTER TABLE GESTIONADOS_POR_LA_PANDEMIA.Habitacion_Vendida
ADD FOREIGN KEY(ID_FACT_ESTADIA) REFERENCES GESTIONADOS_POR_LA_PANDEMIA.Estadia_Facturada(ID_FACT_ESTADIA);

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
ADD FOREIGN KEY(RUTA_ID) REFERENCES GESTIONADOS_POR_LA_PANDEMIA.Ruta_Aerea(RUTA_ID);

ALTER TABLE GESTIONADOS_POR_LA_PANDEMIA.Butaca
ADD FOREIGN KEY(AVION_IDENTIFICADOR) REFERENCES GESTIONADOS_POR_LA_PANDEMIA.Avion(AVION_IDENTIFICADOR);

ALTER TABLE GESTIONADOS_POR_LA_PANDEMIA.Estadia
ADD FOREIGN KEY(COMPRA_NUMERO) REFERENCES GESTIONADOS_POR_LA_PANDEMIA.Compra(COMPRA_NUMERO);

ALTER TABLE GESTIONADOS_POR_LA_PANDEMIA.Estadia
ADD FOREIGN KEY(HOTEL_ID) REFERENCES GESTIONADOS_POR_LA_PANDEMIA.Hotel(HOTEL_ID);

ALTER TABLE GESTIONADOS_POR_LA_PANDEMIA.Habitacion_X_Estadia
ADD FOREIGN KEY(ID_HABITACION) REFERENCES GESTIONADOS_POR_LA_PANDEMIA.Habitacion(ID_HABITACION);

ALTER TABLE GESTIONADOS_POR_LA_PANDEMIA.Habitacion_X_Estadia
ADD FOREIGN KEY(ESTADIA_CODIGO) REFERENCES GESTIONADOS_POR_LA_PANDEMIA.Estadia(ESTADIA_CODIGO);

ALTER TABLE GESTIONADOS_POR_LA_PANDEMIA.Habitacion
ADD FOREIGN KEY(HOTEL_ID) REFERENCES GESTIONADOS_POR_LA_PANDEMIA.Hotel(HOTEL_ID);

ALTER TABLE GESTIONADOS_POR_LA_PANDEMIA.Habitacion
ADD FOREIGN KEY(TIPO_HABITACION_CODIGO) REFERENCES GESTIONADOS_POR_LA_PANDEMIA.Tipo_Habitacion(TIPO_HABITACION_CODIGO);
GO


--Se agregan CONSTRAINTS
ALTER TABLE GESTIONADOS_POR_LA_PANDEMIA.Cliente
ADD CONSTRAINT ck_mail_cli CHECK(CLIENTE_MAIL LIKE '%_@__%.__%');

ALTER TABLE GESTIONADOS_POR_LA_PANDEMIA.Sucursal
ADD CONSTRAINT ck_mail_suc CHECK(SUCURSAL_MAIL LIKE '%_@__%.__%');

ALTER TABLE GESTIONADOS_POR_LA_PANDEMIA.Factura
ADD CONSTRAINT dt_monto_total DEFAULT 0 FOR MONTO_TOTAL;

ALTER TABLE GESTIONADOS_POR_LA_PANDEMIA.Estadia_Facturada
ADD CONSTRAINT dt_precio_est DEFAULT 0 FOR PRECIO_ESTADIA;

ALTER TABLE GESTIONADOS_POR_LA_PANDEMIA.Pasaje_Facturado
ADD CONSTRAINT dt_pas_precio DEFAULT 0 FOR PASAJE_PRECIO;

ALTER TABLE GESTIONADOS_POR_LA_PANDEMIA.Compra
ADD CONSTRAINT dt_compra_costo_tot DEFAULT 0 FOR COSTO_TOTAL;

ALTER TABLE GESTIONADOS_POR_LA_PANDEMIA.Pasaje
ADD CONSTRAINT dt_pas_costo DEFAULT 0 FOR PASAJE_COSTO;

ALTER TABLE GESTIONADOS_POR_LA_PANDEMIA.Cliente
ALTER COLUMN CLIENTE_APELLIDO NVARCHAR(255) NOT NULL;

ALTER TABLE GESTIONADOS_POR_LA_PANDEMIA.Cliente
ALTER COLUMN CLIENTE_NOMBRE NVARCHAR(255) NOT NULL;

ALTER TABLE GESTIONADOS_POR_LA_PANDEMIA.Compra
ALTER COLUMN COMPRA_FECHA DATETIME2(3) NOT NULL;

ALTER TABLE GESTIONADOS_POR_LA_PANDEMIA.Factura
ALTER COLUMN FACTURA_FECHA DATETIME2(3) NOT NULL;

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
GO

--Se agregan los triggers

--Se suma el costo del pasaje al costo total de la tabla Compra asociada al mismo
 CREATE TRIGGER GESTIONADOS_POR_LA_PANDEMIA.sumar_pasaje_a_costo_total
 ON GESTIONADOS_POR_LA_PANDEMIA.Pasaje FOR INSERT 
 AS
 BEGIN
      UPDATE GESTIONADOS_POR_LA_PANDEMIA.Compra 
      SET COSTO_TOTAL = COSTO_TOTAL + PASAJE_COSTO FROM inserted
      WHERE Compra.COMPRA_NUMERO = inserted.COMPRA_NUMERO
 END;
 GO

 --Analogo al anterior, se le suma el costo de cada habitacion reservada para una estadia al costo total de la tabla Compra asociada
 CREATE TRIGGER GESTIONADOS_POR_LA_PANDEMIA.sumar_hab_a_costo_total
 ON GESTIONADOS_POR_LA_PANDEMIA.Habitacion_X_Estadia FOR INSERT 
 AS
 BEGIN
      UPDATE GESTIONADOS_POR_LA_PANDEMIA.Compra 
      SET COSTO_TOTAL = c.COSTO_TOTAL + (i.HABITACION_COSTO*e.ESTADIA_CANTIDAD_NOCHES)
      FROM GESTIONADOS_POR_LA_PANDEMIA.Compra c, inserted i, GESTIONADOS_POR_LA_PANDEMIA.Estadia e
      WHERE c.COMPRA_NUMERO = e.COMPRA_NUMERO 
      AND e.ESTADIA_CODIGO = i.ESTADIA_CODIGO
 END;
 GO

 --En caso de que creemos una nueva instancia de Pasaje, pero aun no exista un registro de la tabla Compra asociado a este pasaje, 
 --se crean ambos simultaneamente.
 CREATE TRIGGER GESTIONADOS_POR_LA_PANDEMIA.crear_compra_tras_instancia_de_pasaje
 ON GESTIONADOS_POR_LA_PANDEMIA.Pasaje INSTEAD OF INSERT 
 AS
 BEGIN
      IF NOT EXISTS (SELECT * 
                FROM GESTIONADOS_POR_LA_PANDEMIA.Compra INNER JOIN inserted
                ON Compra.COMPRA_NUMERO = inserted.COMPRA_NUMERO)
	  INSERT INTO GESTIONADOS_POR_LA_PANDEMIA.Compra(COMPRA_NUMERO, COMPRA_FECHA) 
	  SELECT i.COMPRA_NUMERO, GETDATE() FROM inserted i;

      INSERT INTO GESTIONADOS_POR_LA_PANDEMIA.Pasaje(PASAJE_CODIGO,COMPRA_NUMERO, PASAJE_COSTO, PASAJE_PRECIO, VUELO_CODIGO, BUTACA_ID)
      SELECT PASAJE_CODIGO, COMPRA_NUMERO, PASAJE_COSTO, PASAJE_PRECIO, VUELO_CODIGO, BUTACA_ID FROM inserted;

 END;
 GO 

  --Analogo al anterior, tras la instanciacion de una nueva estadia. 
  --Con la salvedad de que, en este caso, es necesario tener un registro en la tabla Hotel asociado a la estadia antes de instanciar la misma.
 CREATE TRIGGER GESTIONADOS_POR_LA_PANDEMIA.crear_compra_tras_instancia_de_estadia
 ON GESTIONADOS_POR_LA_PANDEMIA.Estadia INSTEAD OF INSERT 
 AS
 BEGIN
      IF NOT EXISTS (SELECT * 
                     FROM GESTIONADOS_POR_LA_PANDEMIA.Compra INNER JOIN inserted
                     ON Compra.COMPRA_NUMERO = inserted.COMPRA_NUMERO)
	  INSERT INTO GESTIONADOS_POR_LA_PANDEMIA.Compra(COMPRA_NUMERO, COMPRA_FECHA) 
	  SELECT i.COMPRA_NUMERO, GETDATE() FROM inserted i;

      INSERT INTO GESTIONADOS_POR_LA_PANDEMIA.Estadia(ESTADIA_CODIGO, COMPRA_NUMERO, ESTADIA_FECHA_INI, ESTADIA_CANTIDAD_NOCHES, HOTEL_ID)
      SELECT ESTADIA_CODIGO, COMPRA_NUMERO, ESTADIA_FECHA_INI, ESTADIA_CANTIDAD_NOCHES, HOTEL_ID FROM inserted;

 END;
 GO

 --Se crea trigger para que, cuando se instancia Hab_X_Est con las PK correspondientes cargadas por el usuario,
 --se cargue automaticamente el COSTO_HABITACION y de esa manera asegurarnos que sea el correcto.
 CREATE TRIGGER GESTIONADOS_POR_LA_PANDEMIA.cargar_costo_hab_x_estadia
 ON GESTIONADOS_POR_LA_PANDEMIA.Habitacion_X_Estadia INSTEAD OF INSERT
 AS
 BEGIN
      INSERT INTO GESTIONADOS_POR_LA_PANDEMIA.Habitacion_X_Estadia(ESTADIA_CODIGO,ID_HABITACION,HABITACION_COSTO)
      SELECT i.ESTADIA_CODIGO, i.ID_HABITACION, h.HABITACION_COSTO
      FROM GESTIONADOS_POR_LA_PANDEMIA.Habitacion h, inserted i
      WHERE h.ID_HABITACION = i.ID_HABITACION;
 END;
 GO 

 --Se crea trigger para que, cuando se crea una nueva instancia de Habitacion_Vendida, 
 --se actualicen automaticamente el PRECIO_ESTADIA de Estadia_Facturada y MONTO_TOTAL de Factura, de forma simultanea.
 CREATE TRIGGER GESTIONADOS_POR_LA_PANDEMIA.cargar_precio_hab_en_factura
 ON GESTIONADOS_POR_LA_PANDEMIA.Habitacion_Vendida FOR INSERT
 AS
 BEGIN
      UPDATE GESTIONADOS_POR_LA_PANDEMIA.Estadia_Facturada
	  SET PRECIO_ESTADIA = ef.PRECIO_ESTADIA + (i.HABITACION_PRECIO*ef.ESTADIA_CANTIDAD_NOCHES)
	  FROM GESTIONADOS_POR_LA_PANDEMIA.Estadia_Facturada ef, inserted i
	  WHERE i.ID_FACT_ESTADIA = ef.ID_FACT_ESTADIA;

      UPDATE GESTIONADOS_POR_LA_PANDEMIA.Factura
	  SET MONTO_TOTAL = f.MONTO_TOTAL + (i.HABITACION_PRECIO*ef.ESTADIA_CANTIDAD_NOCHES)
	  FROM inserted i, GESTIONADOS_POR_LA_PANDEMIA.Factura f, GESTIONADOS_POR_LA_PANDEMIA.Estadia_Facturada ef
	  WHERE ef.ID_FACT_ESTADIA = i.ID_FACT_ESTADIA
	  AND ef.FACTURA_NRO = f.FACTURA_NRO;
 END;
 GO

 --Similar al trigger anterior, este se encarga de actualizar el MONTO_TOTAL en Factura cuando se instancia un nuevo registro en Pasaje_Facturado
 CREATE TRIGGER GESTIONADOS_POR_LA_PANDEMIA.cargar_precio_pas_en_factura
 ON GESTIONADOS_POR_LA_PANDEMIA.Pasaje_Facturado FOR INSERT
 AS
 BEGIN
      UPDATE GESTIONADOS_POR_LA_PANDEMIA.Factura
	  SET MONTO_TOTAL = f.MONTO_TOTAL + i.PASAJE_PRECIO
	  FROM GESTIONADOS_POR_LA_PANDEMIA.Factura F, inserted i
	  WHERE i.FACTURA_NRO = f.FACTURA_NRO;
 END;
 GO

 --Se crea trigger para asegurarnos que el valor introducido en HABITACION_PRECIO ante una nueva instanciacion de la tabla
 --Habitacion_Vendida, sea el correcto, obteniendo el valor de la tabla Habitacion.
 CREATE TRIGGER GESTIONADOS_POR_LA_PANDEMIA.cargar_precio_hab_vendida
 ON GESTIONADOS_POR_LA_PANDEMIA.Habitacion_Vendida INSTEAD OF INSERT
 AS
 BEGIN
      INSERT INTO GESTIONADOS_POR_LA_PANDEMIA.Habitacion_Vendida(ID_FACT_ESTADIA,ID_HABITACION,HABITACION_PRECIO)
	  SELECT i.ID_FACT_ESTADIA, i.ID_HABITACION, h.HABITACION_PRECIO
	  FROM GESTIONADOS_POR_LA_PANDEMIA.Habitacion H, inserted i
	  WHERE h.ID_HABITACION = i.ID_HABITACION
 END;
 GO

 --Similar al anterior, para asegurarnos que el precio cargado en Pasaje_Facturado sea el correcto.
 CREATE TRIGGER GESTIONADOS_POR_LA_PANDEMIA.cargar_precio_pas_vendido
 ON GESTIONADOS_POR_LA_PANDEMIA.Pasaje_Facturado INSTEAD OF INSERT
 AS
 BEGIN
      INSERT INTO GESTIONADOS_POR_LA_PANDEMIA.Pasaje_Facturado(FACTURA_NRO,PASAJE_CODIGO,PASAJE_PRECIO)
	  SELECT i.FACTURA_NRO, i.PASAJE_CODIGO, p.PASAJE_PRECIO
	  FROM GESTIONADOS_POR_LA_PANDEMIA.Pasaje p, inserted i
	  WHERE p.PASAJE_CODIGO = i.PASAJE_CODIGO
 END;
 GO

 --Se crea trigger para calcular fecha check in y check out de Estadia_Facturada ante una nueva instanciacion de la misma.
 CREATE TRIGGER GESTIONADOS_POR_LA_PANDEMIA.cargar_fechas_check_in_out
 ON GESTIONADOS_POR_LA_PANDEMIA.Estadia_Facturada INSTEAD OF INSERT
 AS
 BEGIN
      INSERT INTO GESTIONADOS_POR_LA_PANDEMIA.Estadia_Facturada(FACTURA_NRO,ESTADIA_CODIGO,ESTADIA_CANTIDAD_NOCHES,FECHA_CHECK_IN,FECHA_CHECK_OUT)
	  SELECT i.FACTURA_NRO, i.ESTADIA_CODIGO, i.ESTADIA_CANTIDAD_NOCHES, e.ESTADIA_FECHA_INI, (SELECT DATEADD(DAY,i.ESTADIA_CANTIDAD_NOCHES, e.ESTADIA_FECHA_INI))
	  FROM inserted i, GESTIONADOS_POR_LA_PANDEMIA.Estadia e
	  WHERE i.ESTADIA_CODIGO = e.ESTADIA_CODIGO

 END;
 GO

 --Agrego indices
 CREATE INDEX IX_ContactoCliente
 ON GESTIONADOS_POR_LA_PANDEMIA.Cliente(CLIENTE_MAIL, CLIENTE_TELEFONO);

 CREATE INDEX IX_ClienteFactura
 ON GESTIONADOS_POR_LA_PANDEMIA.Factura(ID_CLIENTE);

 CREATE INDEX IX_PasajeVendido
 ON GESTIONADOS_POR_LA_PANDEMIA.Pasaje_Facturado(PASAJE_CODIGO);

 CREATE INDEX IX_EstadiaVendida
 ON GESTIONADOS_POR_LA_PANDEMIA.Estadia_Facturada(ESTADIA_CODIGO);

 CREATE INDEX IX_HabitacionVendida
 ON GESTIONADOS_POR_LA_PANDEMIA.Habitacion_Vendida(ID_HABITACION);
 
 CREATE INDEX IX_ContactoSucursal
 ON GESTIONADOS_POR_LA_PANDEMIA.Sucursal(SUCURSAL_MAIL,SUCURSAL_TELEFONO);

 CREATE INDEX IX_PasajeComprado
 ON GESTIONADOS_POR_LA_PANDEMIA.Pasaje(COMPRA_NUMERO);

 CREATE INDEX IX_VueloPasaje
 ON GESTIONADOS_POR_LA_PANDEMIA.Pasaje(VUELO_CODIGO);

 CREATE INDEX IX_ButacaPasaje
 ON GESTIONADOS_POR_LA_PANDEMIA.Pasaje(BUTACA_ID);

 CREATE INDEX IX_RutaVuelo
 ON GESTIONADOS_POR_LA_PANDEMIA.Vuelo(RUTA_ID);

 CREATE INDEX IX_EstadiaComprada
 ON GESTIONADOS_POR_LA_PANDEMIA.Estadia(COMPRA_NUMERO);

 CREATE INDEX IX_HotelEstadia
 ON GESTIONADOS_POR_LA_PANDEMIA.Estadia(HOTEL_ID);

 CREATE INDEX IX_DireccionHotel
 ON GESTIONADOS_POR_LA_PANDEMIA.Hotel(HOTEL_CALLE, HOTEL_NRO_CALLE);

 CREATE INDEX IX_HotelHabitacion
 ON GESTIONADOS_POR_LA_PANDEMIA.Habitacion(HOTEL_ID);

 CREATE INDEX IX_UbicacionHabitacion
 ON GESTIONADOS_POR_LA_PANDEMIA.Habitacion(HABITACION_NUMERO, HABITACION_PISO);

 CREATE INDEX IX_TipoHabitacion
 ON GESTIONADOS_POR_LA_PANDEMIA.Habitacion(TIPO_HABITACION_CODIGO);
 GO

 --Se crean los stored procedures para la migracion de datos.
 
 --Se crea procedure para insertar datos en tabla Cliente. 
 CREATE PROCEDURE GESTIONADOS_POR_LA_PANDEMIA.cargarDatosEnCliente
 AS
 BEGIN
      INSERT INTO GESTIONADOS_POR_LA_PANDEMIA.Cliente(CLIENTE_APELLIDO,CLIENTE_NOMBRE,CLIENTE_DNI,CLIENTE_FECHA_NAC,CLIENTE_MAIL,CLIENTE_TELEFONO)
      SELECT CLIENTE_APELLIDO,CLIENTE_NOMBRE,CLIENTE_DNI,CLIENTE_FECHA_NAC,CLIENTE_MAIL,CLIENTE_TELEFONO 
      FROM gd_esquema.Maestra 
      WHERE CLIENTE_NOMBRE IS NOT NULL
      AND CLIENTE_APELLIDO IS NOT NULL
      AND CLIENTE_DNI IS NOT NULL;
 END;
 GO

 --Se crea procedure para insertar datos en tabla Sucursal
 CREATE PROCEDURE GESTIONADOS_POR_LA_PANDEMIA.cargarDatosEnSucursal
 AS
 BEGIN
      INSERT INTO GESTIONADOS_POR_LA_PANDEMIA.Sucursal(SUCURSAL_DIR,SUCURSAL_TELEFONO,SUCURSAL_MAIL)
      SELECT DISTINCT SUCURSAL_DIR, SUCURSAL_TELEFONO, SUCURSAL_MAIL
      FROM gd_esquema.Maestra 
      WHERE SUCURSAL_DIR IS NOT NULL
      AND SUCURSAL_TELEFONO IS NOT NULL
      AND SUCURSAL_MAIL IS NOT NULL;
 END;
 GO

 --Se crea procedure para insertar datos en tabla Factura
 CREATE PROCEDURE GESTIONADOS_POR_LA_PANDEMIA.cargarDatosEnFactura
 AS
 BEGIN
      INSERT INTO GESTIONADOS_POR_LA_PANDEMIA.Factura(FACTURA_NRO,FACTURA_FECHA,ID_CLIENTE,ID_SUCURSAL)
	  SELECT m.FACTURA_NRO, m.FACTURA_FECHA, c.ID_CLIENTE, s.ID_SUCURSAL
	  FROM gd_esquema.Maestra m, GESTIONADOS_POR_LA_PANDEMIA.Cliente c, GESTIONADOS_POR_LA_PANDEMIA.Sucursal s
	  WHERE m.FACTURA_NRO IS NOT NULL
	  AND c.CLIENTE_APELLIDO = m.CLIENTE_APELLIDO
	  AND c.CLIENTE_NOMBRE = m.CLIENTE_NOMBRE
	  AND c.CLIENTE_DNI = m.CLIENTE_DNI
	  AND s.SUCURSAL_DIR = m.SUCURSAL_DIR
 END;
 GO
 
 --Se crea procedure para insertar datos en tabla Compra
 CREATE PROCEDURE GESTIONADOS_POR_LA_PANDEMIA.cargarDatosEnCompra
 AS
 BEGIN
      INSERT INTO GESTIONADOS_POR_LA_PANDEMIA.Compra(COMPRA_NUMERO,COMPRA_FECHA)
	  SELECT DISTINCT COMPRA_NUMERO, COMPRA_FECHA 
	  FROM gd_esquema.Maestra;
 END;
 GO
 
 --Se crea procedure para insertar datos en tabla Hotel
 CREATE PROCEDURE GESTIONADOS_POR_LA_PANDEMIA.cargarDatosEnHotel
 AS
 BEGIN
      INSERT INTO GESTIONADOS_POR_LA_PANDEMIA.Hotel(HOTEL_NOMBRE,HOTEL_CALLE,HOTEL_NRO_CALLE,HOTEL_CANTIDAD_ESTRELLAS)
	  SELECT DISTINCT EMPRESA_RAZON_SOCIAL,HOTEL_CALLE,HOTEL_NRO_CALLE,HOTEL_CANTIDAD_ESTRELLAS 
	  FROM gd_esquema.Maestra
	  WHERE EMPRESA_RAZON_SOCIAL IS NOT NULL
	  AND HOTEL_CALLE IS NOT NULL
	  OR HOTEL_NRO_CALLE IS NOT NULL
	  OR HOTEL_CANTIDAD_ESTRELLAS IS NOT NULL;
 END;
 GO

 --Se crea procedure para insertar datos en tabla Estadia.
 CREATE PROCEDURE GESTIONADOS_POR_LA_PANDEMIA.cargarDatosEnEstadia
 AS
 BEGIN
      INSERT INTO GESTIONADOS_POR_LA_PANDEMIA.Estadia(ESTADIA_CODIGO,COMPRA_NUMERO,ESTADIA_FECHA_INI,ESTADIA_CANTIDAD_NOCHES,HOTEL_ID)
	  SELECT m.ESTADIA_CODIGO,m.COMPRA_NUMERO,m.ESTADIA_FECHA_INI,m.ESTADIA_CANTIDAD_NOCHES, h.HOTEL_ID
	  FROM gd_esquema.Maestra m, GESTIONADOS_POR_LA_PANDEMIA.Hotel h
	  WHERE m.ESTADIA_CODIGO IS NOT NULL
	  AND NOT EXISTS(SELECT e.ESTADIA_CODIGO FROM GESTIONADOS_POR_LA_PANDEMIA.Estadia e, gd_esquema.Maestra m WHERE m.ESTADIA_CODIGO = e.ESTADIA_CODIGO)
	  AND m.COMPRA_NUMERO IS NOT NULL
	  AND m.EMPRESA_RAZON_SOCIAL IS NOT NULL
	  AND m.EMPRESA_RAZON_SOCIAL = h.HOTEL_NOMBRE
	  AND m.HOTEL_CALLE = h.HOTEL_CALLE
	  AND m.HOTEL_NRO_CALLE = h.HOTEL_NRO_CALLE
	  AND m.FACTURA_NRO IS NULL --Para asegurarme que sea la COMPRA de estadia y no la venta de la misma
 END;
 GO

 --Se crea procedure para insertar datos en tabla Tipo_Habitacion
 CREATE PROCEDURE GESTIONADOS_POR_LA_PANDEMIA.cargarDatosEnTipoHabitacion
 AS
 BEGIN
      INSERT INTO GESTIONADOS_POR_LA_PANDEMIA.Tipo_Habitacion(TIPO_HABITACION_CODIGO,TIPO_HABITACION_DESC)
	  SELECT DISTINCT TIPO_HABITACION_CODIGO,TIPO_HABITACION_DESC
	  FROM gd_esquema.Maestra
	  WHERE TIPO_HABITACION_CODIGO IS NOT NULL
 END;
 GO
 
 --Se crea procedure para insertar datos en tabla Habitacion.
 CREATE PROCEDURE GESTIONADOS_POR_LA_PANDEMIA.cargarDatosEnHabitacion
 AS
 BEGIN
      INSERT INTO GESTIONADOS_POR_LA_PANDEMIA.Habitacion(HOTEL_ID,HABITACION_NUMERO,HABITACION_PISO,HABITACION_FRENTE,TIPO_HABITACION_CODIGO, HABITACION_COSTO, HABITACION_PRECIO)
	  SELECT DISTINCT h.HOTEL_ID, m.HABITACION_NUMERO,m.HABITACION_PISO,m.HABITACION_FRENTE,m.TIPO_HABITACION_CODIGO, m.HABITACION_COSTO, m.HABITACION_PRECIO
	  FROM gd_esquema.Maestra m, GESTIONADOS_POR_LA_PANDEMIA.Hotel h
	  WHERE h.HOTEL_NOMBRE = m.EMPRESA_RAZON_SOCIAL
	  AND h.HOTEL_CALLE = m.HOTEL_CALLE
	  AND h.HOTEL_NRO_CALLE = m.HOTEL_NRO_CALLE
 END;
 GO

 --Se crea procedure para insertar datos en tabla Habitacion_X_Estadia
 CREATE PROCEDURE GESTIONADOS_POR_LA_PANDEMIA.cargarDatosEnHabitacion_X_Estadia
 AS
 BEGIN
      INSERT INTO GESTIONADOS_POR_LA_PANDEMIA.Habitacion_X_Estadia(ESTADIA_CODIGO,ID_HABITACION)
	  SELECT DISTINCT m.ESTADIA_CODIGO,h.ID_HABITACION
	  FROM gd_esquema.Maestra m, GESTIONADOS_POR_LA_PANDEMIA.Habitacion h, GESTIONADOS_POR_LA_PANDEMIA.Hotel hot
	  WHERE m.ESTADIA_CODIGO IS NOT NULL
	  AND m.HABITACION_COSTO IS NOT NULL
	  AND m.FACTURA_NRO IS NULL
	  AND m.HABITACION_NUMERO = h.HABITACION_NUMERO
	  AND m.HABITACION_PISO = h.HABITACION_PISO
	  AND m.HABITACION_FRENTE = h.HABITACION_FRENTE
	  AND m.TIPO_HABITACION_CODIGO = h.TIPO_HABITACION_CODIGO
	  AND m.EMPRESA_RAZON_SOCIAL = hot.HOTEL_NOMBRE
	  AND m.HOTEL_CALLE = hot.HOTEL_CALLE
	  AND m.HOTEL_NRO_CALLE = hot.HOTEL_NRO_CALLE

 END;
 GO
 
 --Se crea procedure para insertar datos en tabla Estadia_Facturada
 CREATE PROCEDURE GESTIONADOS_POR_LA_PANDEMIA.cargarDatosEnEstadiaFacturada
 AS
 BEGIN
      INSERT INTO GESTIONADOS_POR_LA_PANDEMIA.Estadia_Facturada(FACTURA_NRO,ESTADIA_CODIGO, ESTADIA_CANTIDAD_NOCHES)
	  SELECT DISTINCT m.FACTURA_NRO,m.ESTADIA_CODIGO,m.ESTADIA_CANTIDAD_NOCHES
	  FROM gd_esquema.Maestra m
	  WHERE m.FACTURA_NRO IS NOT NULL
	  AND m.ESTADIA_CODIGO IS NOT NULL
 END;
 GO
 
 --Se crea procedure para insertar datos en tabla Habitacion_Vendida
 CREATE PROCEDURE GESTIONADOS_POR_LA_PANDEMIA.cargarDatosEnHabitacionVendida
 AS
 BEGIN
      INSERT INTO GESTIONADOS_POR_LA_PANDEMIA.Habitacion_Vendida(ID_FACT_ESTADIA,ID_HABITACION)
	  SELECT DISTINCT ef.ID_FACT_ESTADIA, h.ID_HABITACION
	  FROM GESTIONADOS_POR_LA_PANDEMIA.Estadia_Facturada ef, GESTIONADOS_POR_LA_PANDEMIA.Habitacion h, GESTIONADOS_POR_LA_PANDEMIA.Hotel hot, gd_esquema.Maestra m
	  WHERE m.FACTURA_NRO IS NOT NULL
	  AND m.FACTURA_NRO = ef.FACTURA_NRO
	  AND m.ESTADIA_CODIGO = ef.ESTADIA_CODIGO
	  AND m.EMPRESA_RAZON_SOCIAL = hot.HOTEL_NOMBRE
	  AND m.HOTEL_CALLE = hot.HOTEL_CALLE
	  AND m.HOTEL_NRO_CALLE = hot.HOTEL_NRO_CALLE
	  AND hot.HOTEL_ID = h.HOTEL_ID
	  AND m.HABITACION_PISO = h.HABITACION_PISO
	  AND m.HABITACION_NUMERO = h.HABITACION_NUMERO
	  AND m.HABITACION_FRENTE = h.HABITACION_FRENTE
 END;
 GO

 --Se crea procedure para insertar datos en tabla Avion
 CREATE PROCEDURE GESTIONADOS_POR_LA_PANDEMIA.cargarDatosEnAvion
 AS
 BEGIN
      INSERT INTO GESTIONADOS_POR_LA_PANDEMIA.Avion(AVION_IDENTIFICADOR,AVION_MODELO)
	  SELECT DISTINCT m.AVION_IDENTIFICADOR, m.AVION_MODELO 
	  FROM gd_esquema.Maestra m
	  WHERE AVION_IDENTIFICADOR IS NOT NULL
 END;
 GO

 --Se crea procedure para insertar datos en tabla Butaca
 CREATE PROCEDURE GESTIONADOS_POR_LA_PANDEMIA.cargarDatosEnButaca
 AS
 BEGIN
      INSERT INTO GESTIONADOS_POR_LA_PANDEMIA.Butaca(BUTACA_NUMERO,BUTACA_TIPO,AVION_IDENTIFICADOR)
	  SELECT DISTINCT m.BUTACA_NUMERO,m.BUTACA_TIPO,m.AVION_IDENTIFICADOR 
	  FROM gd_esquema.Maestra m
	  WHERE BUTACA_NUMERO IS NOT NULL
 END;
 GO

 --Se crea procedure para insertar datos en tabla Ruta Aerea
 CREATE PROCEDURE GESTIONADOS_POR_LA_PANDEMIA.cargarDatosEnRutaAerea
 AS
 BEGIN
      INSERT INTO GESTIONADOS_POR_LA_PANDEMIA.Ruta_Aerea(RUTA_AEREA_CODIGO,RUTA_AEREA_CIU_ORIGEN,RUTA_AEREA_CIU_DESTINO)
	  SELECT DISTINCT m.RUTA_AEREA_CODIGO, m.RUTA_AEREA_CIU_ORIG, m.RUTA_AEREA_CIU_DEST
	  FROM gd_esquema.Maestra m
	  WHERE RUTA_AEREA_CIU_ORIG IS NOT NULL
	  AND RUTA_AEREA_CIU_DEST IS NOT NULL
 END;
 GO

 --Se crea procedure para insertar datos en tabla Vuelo
 CREATE PROCEDURE GESTIONADOS_POR_LA_PANDEMIA.cargarDatosEnVuelo
 AS
 BEGIN
      INSERT INTO GESTIONADOS_POR_LA_PANDEMIA.Vuelo(VUELO_CODIGO,VUELO_FECHA_SALIDA,VUELO_FECHA_LLEGADA,RUTA_ID,AVION_IDENTIFICADOR,AEROLINEA_NOMBRE)
	  SELECT DISTINCT m.VUELO_CODIGO,m.VUELO_FECHA_SALUDA,m.VUELO_FECHA_LLEGADA,r.RUTA_ID,m.AVION_IDENTIFICADOR,m.EMPRESA_RAZON_SOCIAL
	  FROM gd_esquema.Maestra m, GESTIONADOS_POR_LA_PANDEMIA.Ruta_Aerea r
	  WHERE m.VUELO_CODIGO IS NOT NULL
	  AND m.RUTA_AEREA_CIU_ORIG = r.RUTA_AEREA_CIU_ORIGEN
	  AND m.RUTA_AEREA_CIU_DEST = r.RUTA_AEREA_CIU_DESTINO
	  AND m.RUTA_AEREA_CODIGO = r.RUTA_AEREA_CODIGO
 END;
 GO

 --Se crea procedure para insertar datos en tabla Pasaje
 CREATE PROCEDURE GESTIONADOS_POR_LA_PANDEMIA.cargarDatosEnPasaje
 AS
 BEGIN
      INSERT INTO GESTIONADOS_POR_LA_PANDEMIA.Pasaje(PASAJE_CODIGO,COMPRA_NUMERO,PASAJE_COSTO,PASAJE_PRECIO,VUELO_CODIGO,BUTACA_ID)
	  SELECT DISTINCT m.PASAJE_CODIGO, m.COMPRA_NUMERO, m.PASAJE_COSTO, m.PASAJE_PRECIO, m.VUELO_CODIGO, b.BUTACA_ID
	  FROM gd_esquema.Maestra m, GESTIONADOS_POR_LA_PANDEMIA.Butaca b
	  WHERE m.PASAJE_CODIGO IS NOT NULL
	  AND m.FACTURA_NRO IS NULL
	  AND m.BUTACA_NUMERO = b.BUTACA_NUMERO
	  AND m.BUTACA_TIPO = b.BUTACA_TIPO
	  AND m.AVION_IDENTIFICADOR = b.AVION_IDENTIFICADOR
 END;
 GO

 --Se crea procedure para insertar datos en tabla Pasaje_Facturado
 CREATE PROCEDURE GESTIONADOS_POR_LA_PANDEMIA.cargarDatosEnPasajeFacturado
 AS
 BEGIN
      INSERT INTO GESTIONADOS_POR_LA_PANDEMIA.Pasaje_Facturado(FACTURA_NRO,PASAJE_CODIGO,PASAJE_PRECIO)
	  SELECT DISTINCT m.FACTURA_NRO, m.PASAJE_CODIGO, m.PASAJE_PRECIO
	  FROM gd_esquema.Maestra m
	  WHERE m.FACTURA_NRO IS NOT NULL
	  AND m.PASAJE_CODIGO IS NOT NULL
 END;
 GO
 
 --Ejecuto procedures
 EXECUTE GESTIONADOS_POR_LA_PANDEMIA.cargarDatosEnEstadiaFacturada;
 GO

 EXECUTE GESTIONADOS_POR_LA_PANDEMIA.cargarDatosEnCliente;
 GO
 
 EXECUTE GESTIONADOS_POR_LA_PANDEMIA.cargarDatosEnSucursal;
 GO

 EXECUTE GESTIONADOS_POR_LA_PANDEMIA.cargarDatosEnFactura;
 GO

 EXECUTE GESTIONADOS_POR_LA_PANDEMIA.cargarDatosEnCompra;
 GO
 
 EXECUTE GESTIONADOS_POR_LA_PANDEMIA.cargarDatosEnHotel;
 GO

 EXECUTE GESTIONADOS_POR_LA_PANDEMIA.cargarDatosEnEstadia;
 GO

 EXECUTE GESTIONADOS_POR_LA_PANDEMIA.cargarDatosEnTipoHabitacion;
 GO

 EXECUTE GESTIONADOS_POR_LA_PANDEMIA.cargarDatosEnHabitacion;
 GO

 EXECUTE GESTIONADOS_POR_LA_PANDEMIA.cargarDatosEnHabitacion_X_Estadia;
 GO

 EXECUTE GESTIONADOS_POR_LA_PANDEMIA.cargarDatosEnEstadiaFacturada;
 GO

 EXECUTE GESTIONADOS_POR_LA_PANDEMIA.cargarDatosEnHabitacionVendida;
 GO

 EXECUTE GESTIONADOS_POR_LA_PANDEMIA.cargarDatosEnAvion;
 GO

 EXECUTE GESTIONADOS_POR_LA_PANDEMIA.cargarDatosEnButaca;
 GO

 EXECUTE GESTIONADOS_POR_LA_PANDEMIA.cargarDatosEnRutaAerea;
 GO

 EXECUTE GESTIONADOS_POR_LA_PANDEMIA.cargarDatosEnVuelo;
 GO

 EXECUTE GESTIONADOS_POR_LA_PANDEMIA.cargarDatosEnPasaje;
 GO
 
 EXECUTE GESTIONADOS_POR_LA_PANDEMIA.cargarDatosEnPasajeFacturado;
 GO
