Consulta 1 - 

CREATE TABLE Sucursal (
			nombreSuc VARCHAR(50) NOT NULL,
			ciudadSuc VARCHAR(50),
			activo FLOAT DEFAULT 0);
			
CREATE TABLE Cuenta (
			numeroCta VARCHAR(5) NOT NULL,
			saldo FLOAT DEFAULT 0,
			ultimaActualizacion DATE,
			nombreSuc VARCHAR(50));	
			
CREATE TABLE Transaccion (
			numeroCta VARCHAR(5) NOT NULL,
			numeroTrans VARCHAR(5) NOT NULL,	
			importe FLOAT, 
			fecha DATE);

CREATE TABLE Descubierto (
			idDescubierto INT NOT NULL,
			numeroCta VARCHAR (5),
			fecha DATE);
			

Consulta 2 - 

ALTER TABLE Sucursal ADD PRIMARY KEY (nombreSuc);						
ALTER TABLE Cuenta ADD PRIMARY KEY (numeroCta);	
ALTER TABLE Transaccion ADD CONSTRAINT Trans_PK PRIMARY KEY (numeroCta, numeroTrans);
ALTER TABLE Descubierto ADD PRIMARY KEY (idDescubierto);
ALTER TABLE Descubierto ADD CONSTRAINT numeroCta_FK FOREIGN KEY (numeroCta) 
								REFERENCES Cuenta(numeroCta);

Consulta 4 - 

CREATE SEQUENCE idDescubiertoSeq
START WITH 1
INCREMENT BY 1 
MINVALUE 1
NOCYCLE
NOCACHE
NOORDER;

Consulta 5 - 

create or replace TRIGGER transaccionAfterInsert
  AFTER INSERT ON TRANSACCION
  FOR EACH ROW
BEGIN
  UPDATE CUENTA 
  SET cuenta.SALDO = cuenta.saldo + :NEW.IMPORTE,
  ULTIMAACTUALIZACION = SYSDATE
  WHERE NUMEROCTA = :OLD.NUMEROCTA;  
END transaccionAfterInsert;

Consulta 6 - 

create or replace TRIGGER cuentaAfterUpdateSaldo
AFTER UPDATE ON Cuenta
FOR EACH ROW 
BEGIN
UPDATE Sucursal
SET activo = activo + :NEW.saldo
WHERE Sucursal.nombreSuc = :NEW.nombreSuc;
END;

Consulta 7 - 

create or replace TRIGGER comprobarDescubierto
AFTER UPDATE OF saldo on Cuenta
FOR EACH ROW
WHEN (new.saldo < 0)
BEGIN 
INSERT INTO Descubierto(idDescubierto, numeroCta, fecha)
VALUES (idDescubiertoSeq.nextval, :new.numeroCta, current_date);
END;

Consulta 9 - 

ALTER TRIGGER TransaccionAfterInsert disable
ALTER TRIGGER comprobarDescubierto disable

Consulta 10 - 

CREATE OR REPLACE PROCEDURE realizarOperacion (numeroCta VARCHAR, numeroTrans VARCHAR, fecha DATE, importe FLOAT)
AS cambioSaldo FLOAT;
BEGIN SELECT saldo INTO cambioSaldo FROM Cuenta
WHERE realizarOperacion.numeroCta = Cuenta.numeroCta;
INSERT INTO Transaccion values(realizarOperacion.numeroCta, realizarOperacion.numeroTrans, realizarOperacion.importe, realizarOperacion.fecha);
UPDATE Cuenta
SET saldo = cambioSaldo + realizarOperacion.importe, ultimaActualizacion = realizarOperacion.fecha
WHERE numeroCta = realizarOperacion.numeroCta;
IF cambioSaldo + realizarOperacion.importe < 0 THEN
INSERT INTO Descubierto VALUES(idDescubiertoSeq.nextval, realizarOperacion.numeroCta, realizarOperacion.fecha);
END IF;
END;

CALL realizarOperacion ('1','3',TO_DATE('11-OCT-2006','DD-MM-YYYY'),22500);  


