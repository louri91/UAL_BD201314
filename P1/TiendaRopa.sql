SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`tienda`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `mydb`.`tienda` (
  `idTienda` INT NOT NULL ,
  `domicilio` VARCHAR(45) NULL ,
  `ciudad` VARCHAR(45) NULL ,
  `telefono` VARCHAR(45) NULL ,
  PRIMARY KEY (`idTienda`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`empleado`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `mydb`.`empleado` (
  `NIF` VARCHAR(9) NOT NULL ,
  `nombre` VARCHAR(45) NULL ,
  `telefono` VARCHAR(45) NULL ,
  `categoria` VARCHAR(45) NULL ,
  `sueldo` FLOAT NULL ,
  `tienda_idTienda` INT NOT NULL ,
  PRIMARY KEY (`NIF`) ,
  INDEX `fk_empleado_tienda_idx` (`tienda_idTienda` ASC) ,
  CONSTRAINT `fk_empleado_tienda`
    FOREIGN KEY (`tienda_idTienda` )
    REFERENCES `mydb`.`tienda` (`idTienda` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`modelo`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `mydb`.`modelo` (
  `idModelo` INT NOT NULL ,
  `nombre` VARCHAR(45) NULL ,
  `tipo` VARCHAR(45) NULL ,
  `descripcion` VARCHAR(45) NULL ,
  PRIMARY KEY (`idModelo`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`articulos`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `mydb`.`articulos` (
  `idArticulo` INT NOT NULL ,
  `color` VARCHAR(45) NULL ,
  `talla` VARCHAR(45) NULL ,
  `precioNormal` FLOAT NULL ,
  `precioRebajado` FLOAT NULL ,
  `modelo_idModelo` INT NOT NULL ,
  PRIMARY KEY (`idArticulo`) ,
  INDEX `fk_articulos_modelo1_idx` (`modelo_idModelo` ASC) ,
  CONSTRAINT `fk_articulos_modelo1`
    FOREIGN KEY (`modelo_idModelo` )
    REFERENCES `mydb`.`modelo` (`idModelo` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`pedidos`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `mydb`.`pedidos` (
  `idPedido` INT NOT NULL ,
  `fechaPedido` VARCHAR(45) NULL ,
  PRIMARY KEY (`idPedido`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`tienda_has_articulos`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `mydb`.`tienda_has_articulos` (
  `tienda_idTienda` INT NOT NULL ,
  `articulos_idArticulo` INT NOT NULL ,
  `stock` INT NULL ,
  PRIMARY KEY (`tienda_idTienda`, `articulos_idArticulo`) ,
  INDEX `fk_tienda_has_articulos_articulos1_idx` (`articulos_idArticulo` ASC) ,
  INDEX `fk_tienda_has_articulos_tienda1_idx` (`tienda_idTienda` ASC) ,
  CONSTRAINT `fk_tienda_has_articulos_tienda1`
    FOREIGN KEY (`tienda_idTienda` )
    REFERENCES `mydb`.`tienda` (`idTienda` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_tienda_has_articulos_articulos1`
    FOREIGN KEY (`articulos_idArticulo` )
    REFERENCES `mydb`.`articulos` (`idArticulo` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`tienda_realiza_pedidos`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `mydb`.`tienda_realiza_pedidos` (
  `tienda_idTienda` INT NOT NULL ,
  `pedidos_idPedido` INT NOT NULL ,
  `fechaPedido` VARCHAR(45) NULL ,
  `cantidad` INT NULL ,
  PRIMARY KEY (`tienda_idTienda`, `pedidos_idPedido`) ,
  INDEX `fk_tienda_has_pedidos_pedidos1_idx` (`pedidos_idPedido` ASC) ,
  INDEX `fk_tienda_has_pedidos_tienda1_idx` (`tienda_idTienda` ASC) ,
  CONSTRAINT `fk_tienda_has_pedidos_tienda1`
    FOREIGN KEY (`tienda_idTienda` )
    REFERENCES `mydb`.`tienda` (`idTienda` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_tienda_has_pedidos_pedidos1`
    FOREIGN KEY (`pedidos_idPedido` )
    REFERENCES `mydb`.`pedidos` (`idPedido` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

USE `mydb` ;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
