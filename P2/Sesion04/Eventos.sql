SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`evento`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `mydb`.`evento` (
  `idevento` INT NOT NULL ,
  `tipo` VARCHAR(45) NULL ,
  `descripcion` VARCHAR(45) NULL ,
  `fechaCelebracion` VARCHAR(45) NOT NULL ,
  `lugar` VARCHAR(45) NULL ,
  PRIMARY KEY (`idevento`, `fechaCelebracion`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`localidades`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `mydb`.`localidades` (
  `tipo` VARCHAR(9) NOT NULL ,
  `precio` VARCHAR(45) NULL ,
  `cantidadDisponible` VARCHAR(45) NULL ,
  `evento_idevento` INT NOT NULL ,
  `evento_fechaCelebracion` VARCHAR(45) NOT NULL ,
  PRIMARY KEY (`tipo`) ,
  INDEX `fk_localidades_evento_idx` (`evento_idevento` ASC, `evento_fechaCelebracion` ASC) ,
  CONSTRAINT `fk_localidades_evento`
    FOREIGN KEY (`evento_idevento` , `evento_fechaCelebracion` )
    REFERENCES `mydb`.`evento` (`idevento` , `fechaCelebracion` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`titular`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `mydb`.`titular` (
  `idTitular` INT NOT NULL ,
  `NIF` VARCHAR(9) NULL ,
  `nombre` VARCHAR(45) NULL ,
  `apellidos` VARCHAR(45) NULL ,
  `direccion` VARCHAR(45) NULL ,
  `localidad` VARCHAR(45) NULL ,
  PRIMARY KEY (`idTitular`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`reservas`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `mydb`.`reservas` (
  `idreserva` INT NOT NULL ,
  `fechaReserva` VARCHAR(45) NULL ,
  `modoEntrega` VARCHAR(45) NULL ,
  `cantidad` INT NULL ,
  `precioTotal` FLOAT NULL ,
  `evento_idevento` INT NOT NULL ,
  `evento_fechaCelebracion` VARCHAR(45) NOT NULL ,
  `localidades_tipo` VARCHAR(9) NOT NULL ,
  `titular_idTitular` INT NOT NULL ,
  PRIMARY KEY (`idreserva`) ,
  INDEX `fk_reservas_evento1_idx` (`evento_idevento` ASC, `evento_fechaCelebracion` ASC) ,
  INDEX `fk_reservas_localidades1_idx` (`localidades_tipo` ASC) ,
  INDEX `fk_reservas_titular1_idx` (`titular_idTitular` ASC) ,
  CONSTRAINT `fk_reservas_evento1`
    FOREIGN KEY (`evento_idevento` , `evento_fechaCelebracion` )
    REFERENCES `mydb`.`evento` (`idevento` , `fechaCelebracion` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_reservas_localidades1`
    FOREIGN KEY (`localidades_tipo` )
    REFERENCES `mydb`.`localidades` (`tipo` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_reservas_titular1`
    FOREIGN KEY (`titular_idTitular` )
    REFERENCES `mydb`.`titular` (`idTitular` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`responsable`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `mydb`.`responsable` (
  `email` VARCHAR(25) NOT NULL ,
  `nombre` VARCHAR(45) NULL ,
  `telefono` VARCHAR(45) NULL ,
  `fax` VARCHAR(45) NULL ,
  `evento_idevento` INT NOT NULL ,
  `evento_fechaCelebracion` VARCHAR(45) NOT NULL ,
  PRIMARY KEY (`email`) ,
  INDEX `fk_responsable_evento1_idx` (`evento_idevento` ASC, `evento_fechaCelebracion` ASC) ,
  CONSTRAINT `fk_responsable_evento1`
    FOREIGN KEY (`evento_idevento` , `evento_fechaCelebracion` )
    REFERENCES `mydb`.`evento` (`idevento` , `fechaCelebracion` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

USE `mydb` ;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
