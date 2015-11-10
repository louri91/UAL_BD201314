SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`editorial`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `mydb`.`editorial` (
  `nombre` VARCHAR(25) NOT NULL ,
  PRIMARY KEY (`nombre`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`libro`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `mydb`.`libro` (
  `ISBN` INT NOT NULL ,
  `Titulo` VARCHAR(45) NULL ,
  `Genero` VARCHAR(45) NULL ,
  `Resumen` VARCHAR(45) NULL ,
  `Precio` FLOAT NULL ,
  `TipoEncuadernacion` VARCHAR(45) NULL ,
  `NumPaginas` INT NULL ,
  `editorial_nombre` VARCHAR(25) NOT NULL ,
  PRIMARY KEY (`ISBN`) ,
  INDEX `fk_libro_editorial_idx` (`editorial_nombre` ASC) ,
  CONSTRAINT `fk_libro_editorial`
    FOREIGN KEY (`editorial_nombre` )
    REFERENCES `mydb`.`editorial` (`nombre` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`autor`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `mydb`.`autor` (
  `idAutor` INT NOT NULL ,
  `nombre` VARCHAR(45) NULL ,
  `nacionalidad` VARCHAR(45) NULL ,
  PRIMARY KEY (`idAutor`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`cliente`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `mydb`.`cliente` (
  `idCliente` INT NOT NULL ,
  `nombre` VARCHAR(45) NULL ,
  `apellidos` VARCHAR(45) NULL ,
  `sexo` VARCHAR(45) NULL ,
  `fechaNacimiento` VARCHAR(45) NULL ,
  PRIMARY KEY (`idCliente`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`direccion`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `mydb`.`direccion` (
  `calle` VARCHAR(25) NOT NULL ,
  `numero` INT NULL ,
  `localidad` VARCHAR(45) NULL ,
  `provincia` VARCHAR(45) NULL ,
  `pais` VARCHAR(45) NULL ,
  PRIMARY KEY (`calle`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`factura`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `mydb`.`factura` (
  `idFactura` INT NOT NULL ,
  `fechaCompra` VARCHAR(45) NULL ,
  PRIMARY KEY (`idFactura`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`comentario`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `mydb`.`comentario` (
  `idComentario` INT NOT NULL ,
  `valoracion` INT NULL ,
  `descripcion` VARCHAR(45) NULL ,
  `cliente_idCliente` INT NOT NULL ,
  `libro_ISBN` INT NOT NULL ,
  PRIMARY KEY (`idComentario`) ,
  INDEX `fk_comentario_cliente1_idx` (`cliente_idCliente` ASC) ,
  INDEX `fk_comentario_libro1_idx` (`libro_ISBN` ASC) ,
  CONSTRAINT `fk_comentario_cliente1`
    FOREIGN KEY (`cliente_idCliente` )
    REFERENCES `mydb`.`cliente` (`idCliente` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_comentario_libro1`
    FOREIGN KEY (`libro_ISBN` )
    REFERENCES `mydb`.`libro` (`ISBN` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`libro_has_autor`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `mydb`.`libro_has_autor` (
  `libro_ISBN` INT NOT NULL ,
  `autor_idAutor` INT NOT NULL ,
  PRIMARY KEY (`libro_ISBN`, `autor_idAutor`) ,
  INDEX `fk_libro_has_autor_autor1_idx` (`autor_idAutor` ASC) ,
  INDEX `fk_libro_has_autor_libro1_idx` (`libro_ISBN` ASC) ,
  CONSTRAINT `fk_libro_has_autor_libro1`
    FOREIGN KEY (`libro_ISBN` )
    REFERENCES `mydb`.`libro` (`ISBN` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_libro_has_autor_autor1`
    FOREIGN KEY (`autor_idAutor` )
    REFERENCES `mydb`.`autor` (`idAutor` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`cliente_has_direccion`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `mydb`.`cliente_has_direccion` (
  `cliente_idCliente` INT NOT NULL ,
  `direccion_calle` VARCHAR(25) NOT NULL ,
  `orden` INT NULL ,
  PRIMARY KEY (`cliente_idCliente`, `direccion_calle`) ,
  INDEX `fk_cliente_has_direccion_direccion1_idx` (`direccion_calle` ASC) ,
  INDEX `fk_cliente_has_direccion_cliente1_idx` (`cliente_idCliente` ASC) ,
  CONSTRAINT `fk_cliente_has_direccion_cliente1`
    FOREIGN KEY (`cliente_idCliente` )
    REFERENCES `mydb`.`cliente` (`idCliente` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_cliente_has_direccion_direccion1`
    FOREIGN KEY (`direccion_calle` )
    REFERENCES `mydb`.`direccion` (`calle` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`cliente_has_factura`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `mydb`.`cliente_has_factura` (
  `cliente_idCliente` INT NOT NULL ,
  `factura_idFactura` INT NOT NULL ,
  `cantidad` INT NULL ,
  `precioFinal` DOUBLE NULL ,
  PRIMARY KEY (`cliente_idCliente`, `factura_idFactura`) ,
  INDEX `fk_cliente_has_factura_factura1_idx` (`factura_idFactura` ASC) ,
  INDEX `fk_cliente_has_factura_cliente1_idx` (`cliente_idCliente` ASC) ,
  CONSTRAINT `fk_cliente_has_factura_cliente1`
    FOREIGN KEY (`cliente_idCliente` )
    REFERENCES `mydb`.`cliente` (`idCliente` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_cliente_has_factura_factura1`
    FOREIGN KEY (`factura_idFactura` )
    REFERENCES `mydb`.`factura` (`idFactura` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

USE `mydb` ;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
