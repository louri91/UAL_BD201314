

DROP TABLE IF EXISTS PERSONAL;
CREATE TABLE IF NOT EXISTS Personal (
idPersonal INT auto_increment,
nombre VARCHAR(50),
apellidos VARCHAR(50),
profesion VARCHAR(50),
PRIMARY KEY(idPersonal)
);

INSERT INTO Personal(nombre, apellidos, profesion) VALUES('Cristiano', 'Ronaldo', 'Futbolista');
INSERT INTO Personal(nombre, apellidos, profesion) VALUES('Leo', 'Messi', 'Futbolista');