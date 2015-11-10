SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`ayuntamiento`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `mydb`.`ayuntamiento` (
  `codigo` INT NOT NULL ,
  `nombrePoblacion` VARCHAR(45) NULL ,
  `numHabitantes` VARCHAR(45) NULL ,
  `domicilio` VARCHAR(45) NULL ,
  PRIMARY KEY (`codigo`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`telefono`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `mydb`.`telefono` (
  `nTelefono` VARCHAR(9) NOT NULL ,
  `ayuntamiento_codigo` INT NOT NULL ,
  INDEX `fk_telefono_ayuntamiento_idx` (`ayuntamiento_codigo` ASC) ,
  CONSTRAINT `fk_telefono_ayuntamiento`
    FOREIGN KEY (`ayuntamiento_codigo` )
    REFERENCES `mydb`.`ayuntamiento` (`codigo` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`solicitud`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `mydb`.`solicitud` (
  `idSolicitud` INT NOT NULL ,
  `fecha` VARCHAR(45) NULL ,
  `domicilio` VARCHAR(45) NULL ,
  `superficie` VARCHAR(45) NULL ,
  `presupuesto` VARCHAR(45) NULL ,
  `estado` VARCHAR(45) NULL ,
  PRIMARY KEY (`idSolicitud`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`tipoActividad`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `mydb`.`tipoActividad` (
  `idTipoActividad` INT NOT NULL ,
  `descripcion` VARCHAR(45) NULL ,
  `listaNormas` VARCHAR(45) NULL ,
  PRIMARY KEY (`idTipoActividad`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`solicitante`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `mydb`.`solicitante` (
  `NIF` VARCHAR(9) NOT NULL ,
  `nombre` VARCHAR(45) NULL ,
  `telefono` VARCHAR(45) NULL ,
  `domicilio` VARCHAR(45) NULL ,
  PRIMARY KEY (`NIF`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`tecnico`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `mydb`.`tecnico` (
  `NIF` VARCHAR(9) NOT NULL ,
  `nombre` VARCHAR(45) NULL ,
  `categoria` VARCHAR(45) NULL ,
  PRIMARY KEY (`NIF`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`ayuntamiento_has_solicitud`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `mydb`.`ayuntamiento_has_solicitud` (
  `ayuntamiento_codigo` INT NOT NULL ,
  `solicitud_idSolicitud` INT NOT NULL ,
  PRIMARY KEY (`ayuntamiento_codigo`, `solicitud_idSolicitud`) ,
  INDEX `fk_ayuntamiento_has_solicitud_solicitud1_idx` (`solicitud_idSolicitud` ASC) ,
  INDEX `fk_ayuntamiento_has_solicitud_ayuntamiento1_idx` (`ayuntamiento_codigo` ASC) ,
  CONSTRAINT `fk_ayuntamiento_has_solicitud_ayuntamiento1`
    FOREIGN KEY (`ayuntamiento_codigo` )
    REFERENCES `mydb`.`ayuntamiento` (`codigo` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_ayuntamiento_has_solicitud_solicitud1`
    FOREIGN KEY (`solicitud_idSolicitud` )
    REFERENCES `mydb`.`solicitud` (`idSolicitud` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`solicitante_presenta_solicitud`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `mydb`.`solicitante_presenta_solicitud` (
  `solicitante_NIF` VARCHAR(9) NOT NULL ,
  `solicitud_idSolicitud` INT NOT NULL ,
  PRIMARY KEY (`solicitante_NIF`, `solicitud_idSolicitud`) ,
  INDEX `fk_solicitante_has_solicitud_solicitud1_idx` (`solicitud_idSolicitud` ASC) ,
  INDEX `fk_solicitante_has_solicitud_solicitante1_idx` (`solicitante_NIF` ASC) ,
  CONSTRAINT `fk_solicitante_has_solicitud_solicitante1`
    FOREIGN KEY (`solicitante_NIF` )
    REFERENCES `mydb`.`solicitante` (`NIF` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_solicitante_has_solicitud_solicitud1`
    FOREIGN KEY (`solicitud_idSolicitud` )
    REFERENCES `mydb`.`solicitud` (`idSolicitud` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`tecnico_revisa_solicitud`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `mydb`.`tecnico_revisa_solicitud` (
  `tecnico_NIF` VARCHAR(9) NOT NULL ,
  `solicitud_idSolicitud` INT NOT NULL ,
  `nOrden` VARCHAR(45) NULL ,
  `error` VARCHAR(45) NULL ,
  `posibleSolucion` VARCHAR(45) NULL ,
  PRIMARY KEY (`tecnico_NIF`, `solicitud_idSolicitud`) ,
  INDEX `fk_tecnico_has_solicitud_solicitud1_idx` (`solicitud_idSolicitud` ASC) ,
  INDEX `fk_tecnico_has_solicitud_tecnico1_idx` (`tecnico_NIF` ASC) ,
  CONSTRAINT `fk_tecnico_has_solicitud_tecnico1`
    FOREIGN KEY (`tecnico_NIF` )
    REFERENCES `mydb`.`tecnico` (`NIF` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_tecnico_has_solicitud_solicitud1`
    FOREIGN KEY (`solicitud_idSolicitud` )
    REFERENCES `mydb`.`solicitud` (`idSolicitud` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

USE `mydb` ;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
