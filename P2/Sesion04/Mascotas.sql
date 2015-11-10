SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`especie`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `mydb`.`especie` (
  `nombre` VARCHAR(25) NOT NULL ,
  `alimentacion` VARCHAR(45) NULL ,
  `listaCuidados` VARCHAR(45) NULL ,
  PRIMARY KEY (`nombre`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`raza`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `mydb`.`raza` (
  `nombre` VARCHAR(25) NOT NULL ,
  `descripcion` VARCHAR(45) NULL ,
  `listaCuidados` VARCHAR(45) NULL ,
  `especie_nombre` VARCHAR(25) NOT NULL ,
  PRIMARY KEY (`nombre`) ,
  INDEX `fk_raza_especie1_idx` (`especie_nombre` ASC) ,
  CONSTRAINT `fk_raza_especie1`
    FOREIGN KEY (`especie_nombre` )
    REFERENCES `mydb`.`especie` (`nombre` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`mascota`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `mydb`.`mascota` (
  `idMascota` INT NOT NULL ,
  `fechaNacimiento` VARCHAR(45) NULL ,
  `precio` FLOAT NULL ,
  `pedigree` VARCHAR(45) NULL ,
  `raza_nombre` VARCHAR(25) NOT NULL ,
  PRIMARY KEY (`idMascota`) ,
  INDEX `fk_mascota_raza1_idx` (`raza_nombre` ASC) ,
  CONSTRAINT `fk_mascota_raza1`
    FOREIGN KEY (`raza_nombre` )
    REFERENCES `mydb`.`raza` (`nombre` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`empleado`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `mydb`.`empleado` (
  `NIF` VARCHAR(9) NOT NULL ,
  `nombre` VARCHAR(45) NULL ,
  `apellidos` VARCHAR(45) NULL ,
  `direccion` VARCHAR(45) NULL ,
  `fechaIncorporacion` VARCHAR(45) NULL ,
  PRIMARY KEY (`NIF`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`cliente`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `mydb`.`cliente` (
  `codCliente` INT NOT NULL ,
  `NIF` VARCHAR(9) NULL ,
  `nombre` VARCHAR(45) NULL ,
  `apellidos` VARCHAR(45) NULL ,
  `direccion` VARCHAR(45) NULL ,
  PRIMARY KEY (`codCliente`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`reserva`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `mydb`.`reserva` (
  `numReserva` INT NOT NULL ,
  `fechaReserva` VARCHAR(45) NULL ,
  `fechaCaducidad` VARCHAR(45) NULL ,
  `fianza` FLOAT NULL ,
  `empleado_NIF` VARCHAR(9) NOT NULL ,
  `cliente_codCliente` INT NOT NULL ,
  `mascota_idMascota` INT NOT NULL ,
  PRIMARY KEY (`numReserva`) ,
  INDEX `fk_reserva_empleado1_idx` (`empleado_NIF` ASC) ,
  INDEX `fk_reserva_cliente1_idx` (`cliente_codCliente` ASC) ,
  INDEX `fk_reserva_mascota1_idx` (`mascota_idMascota` ASC) ,
  CONSTRAINT `fk_reserva_empleado1`
    FOREIGN KEY (`empleado_NIF` )
    REFERENCES `mydb`.`empleado` (`NIF` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_reserva_cliente1`
    FOREIGN KEY (`cliente_codCliente` )
    REFERENCES `mydb`.`cliente` (`codCliente` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_reserva_mascota1`
    FOREIGN KEY (`mascota_idMascota` )
    REFERENCES `mydb`.`mascota` (`idMascota` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`venta`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `mydb`.`venta` (
  `numFactura` INT NOT NULL ,
  `fechaVenta` VARCHAR(45) NULL ,
  `precioFinal` VARCHAR(45) NULL ,
  `mascota_idMascota` INT NOT NULL ,
  `empleado_NIF` VARCHAR(9) NOT NULL ,
  `cliente_codCliente` INT NOT NULL ,
  PRIMARY KEY (`numFactura`) ,
  INDEX `fk_venta_mascota1_idx` (`mascota_idMascota` ASC) ,
  INDEX `fk_venta_empleado1_idx` (`empleado_NIF` ASC) ,
  INDEX `fk_venta_cliente1_idx` (`cliente_codCliente` ASC) ,
  CONSTRAINT `fk_venta_mascota1`
    FOREIGN KEY (`mascota_idMascota` )
    REFERENCES `mydb`.`mascota` (`idMascota` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_venta_empleado1`
    FOREIGN KEY (`empleado_NIF` )
    REFERENCES `mydb`.`empleado` (`NIF` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_venta_cliente1`
    FOREIGN KEY (`cliente_codCliente` )
    REFERENCES `mydb`.`cliente` (`codCliente` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

USE `mydb` ;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
