SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`autor`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `mydb`.`autor` (
  `idautor` INT NOT NULL ,
  `email` VARCHAR(45) NULL ,
  `nombre` VARCHAR(45) NULL ,
  `ciudad` VARCHAR(45) NULL ,
  `pais` VARCHAR(45) NULL ,
  PRIMARY KEY (`idautor`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`proyecto`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `mydb`.`proyecto` (
  `idproyecto` INT NOT NULL ,
  `nombre` VARCHAR(45) NULL ,
  `fechaInicio` VARCHAR(45) NULL ,
  `fechaFin` VARCHAR(45) NULL ,
  `importe` VARCHAR(45) NULL ,
  `areaDesarrollo` VARCHAR(45) NULL ,
  PRIMARY KEY (`idproyecto`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`patente`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `mydb`.`patente` (
  `idpatente` INT NOT NULL ,
  `descripcion` VARCHAR(45) NULL ,
  `fechaInscripcion` VARCHAR(45) NULL ,
  `autor_idautor` INT NOT NULL ,
  `proyecto_idproyecto` INT NOT NULL ,
  PRIMARY KEY (`idpatente`) ,
  INDEX `fk_patente_autor_idx` (`autor_idautor` ASC) ,
  INDEX `fk_patente_proyecto1_idx` (`proyecto_idproyecto` ASC) ,
  CONSTRAINT `fk_patente_autor`
    FOREIGN KEY (`autor_idautor` )
    REFERENCES `mydb`.`autor` (`idautor` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_patente_proyecto1`
    FOREIGN KEY (`proyecto_idproyecto` )
    REFERENCES `mydb`.`proyecto` (`idproyecto` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`empresa`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `mydb`.`empresa` (
  `CIF` VARCHAR(9) NOT NULL ,
  `nombre` VARCHAR(45) NULL ,
  `direccion` VARCHAR(45) NULL ,
  `ciudad` VARCHAR(45) NULL ,
  `pais` VARCHAR(45) NULL ,
  `sector` VARCHAR(45) NULL ,
  PRIMARY KEY (`CIF`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`documentos`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `mydb`.`documentos` (
  `ID` INT NOT NULL ,
  `descripcion` VARCHAR(45) NULL ,
  `PDF` VARCHAR(45) NULL ,
  PRIMARY KEY (`ID`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`patente_has_empresa`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `mydb`.`patente_has_empresa` (
  `patente_idpatente` INT NOT NULL ,
  `empresa_CIF` VARCHAR(9) NOT NULL ,
  `fechaInicioUso` VARCHAR(45) NULL ,
  PRIMARY KEY (`patente_idpatente`, `empresa_CIF`) ,
  INDEX `fk_patente_has_empresa_empresa1_idx` (`empresa_CIF` ASC) ,
  INDEX `fk_patente_has_empresa_patente1_idx` (`patente_idpatente` ASC) ,
  CONSTRAINT `fk_patente_has_empresa_patente1`
    FOREIGN KEY (`patente_idpatente` )
    REFERENCES `mydb`.`patente` (`idpatente` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_patente_has_empresa_empresa1`
    FOREIGN KEY (`empresa_CIF` )
    REFERENCES `mydb`.`empresa` (`CIF` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`patente_has_documentos`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `mydb`.`patente_has_documentos` (
  `patente_idpatente` INT NOT NULL ,
  `documentos_ID` INT NOT NULL ,
  PRIMARY KEY (`patente_idpatente`, `documentos_ID`) ,
  INDEX `fk_patente_has_documentos_documentos1_idx` (`documentos_ID` ASC) ,
  INDEX `fk_patente_has_documentos_patente1_idx` (`patente_idpatente` ASC) ,
  CONSTRAINT `fk_patente_has_documentos_patente1`
    FOREIGN KEY (`patente_idpatente` )
    REFERENCES `mydb`.`patente` (`idpatente` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_patente_has_documentos_documentos1`
    FOREIGN KEY (`documentos_ID` )
    REFERENCES `mydb`.`documentos` (`ID` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

USE `mydb` ;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
