-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema m2_Modelatge_BBDD
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema m2_Modelatge_BBDD
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `m2_Modelatge_BBDD` DEFAULT CHARACTER SET utf8mb4 ;
-- -----------------------------------------------------
-- Schema m2_modelatge_bbdd
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema m2_modelatge_bbdd
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `m2_modelatge_bbdd` DEFAULT CHARACTER SET utf8mb4 ;
USE `m2_Modelatge_BBDD` ;

-- -----------------------------------------------------
-- Table `m2_Modelatge_BBDD`.`Avions`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `m2_Modelatge_BBDD`.`Avions` (
  `id_avio` INT NOT NULL AUTO_INCREMENT COMMENT 'Holds plane id',
  `capacitat` INT NULL COMMENT 'Hold the amount of passengers allowed in the flight',
  `model` VARCHAR(45) NULL COMMENT 'Holds the model plane',
  UNIQUE INDEX `id_avio_UNIQUE` (`id_avio` ASC) VISIBLE,
  PRIMARY KEY (`id_avio`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `m2_Modelatge_BBDD`.`Seients`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `m2_Modelatge_BBDD`.`Seients` (
  `id_seient` INT NOT NULL AUTO_INCREMENT COMMENT 'Holds the id seat',
  `Avions_id_avio` INT NOT NULL,
  PRIMARY KEY (`id_seient`),
  UNIQUE INDEX `id_seient_UNIQUE` (`id_seient` ASC) VISIBLE,
  INDEX `fk_Seients_Avions1_idx` (`Avions_id_avio` ASC) VISIBLE,
  CONSTRAINT `fk_Seients_Avions1`
    FOREIGN KEY (`Avions_id_avio`)
    REFERENCES `m2_Modelatge_BBDD`.`Avions` (`id_avio`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `m2_Modelatge_BBDD`.`Comprador`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `m2_Modelatge_BBDD`.`Comprador` (
  `id_comprador` INT NOT NULL AUTO_INCREMENT COMMENT 'Holds the id buyer',
  `comprador_dni` VARCHAR(9) NOT NULL COMMENT 'Holds the identity card from the buyer',
  `comprador_nom` VARCHAR(45) NOT NULL COMMENT 'Holds the first name from the buyer',
  `comprador_cognom` VARCHAR(45) NOT NULL COMMENT 'Holds the second name from the buyer',
  UNIQUE INDEX `id_comprador_UNIQUE` (`id_comprador` ASC) VISIBLE,
  INDEX `idx_cognom` (`comprador_cognom` ASC) INVISIBLE,
  PRIMARY KEY (`id_comprador`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `m2_Modelatge_BBDD`.`Comprador_compra_quadre`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `m2_Modelatge_BBDD`.`Comprador_compra_quadre` (
  `idComprador_compra_quadre_id` INT NOT NULL AUTO_INCREMENT,
  `Comprador_id_comprador` INT NOT NULL,
  `compra_data` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Holds the date-time of the purchace',
  PRIMARY KEY (`idComprador_compra_quadre_id`),
  INDEX `fk_Comprador_compra_quadre_Comprador1_idx` (`Comprador_id_comprador` ASC) VISIBLE,
  CONSTRAINT `fk_Comprador_compra_quadre_Comprador1`
    FOREIGN KEY (`Comprador_id_comprador`)
    REFERENCES `m2_Modelatge_BBDD`.`Comprador` (`id_comprador`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `m2_Modelatge_BBDD`.`Quadres`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `m2_Modelatge_BBDD`.`Quadres` (
  `id_quadre` INT NOT NULL COMMENT 'Holds the painting id',
  `quadre_preu` INT NOT NULL COMMENT 'Holds the painting price',
  `quadre_autor` VARCHAR(45) NULL COMMENT 'Holds the painting author',
  `Comprador_compra_quadre_idComprador_compra_quadre_id` INT NOT NULL,
  PRIMARY KEY (`id_quadre`),
  INDEX `idx_quadre_autor` (`quadre_autor` ASC) VISIBLE,
  INDEX `fk_Quadres_Comprador_compra_quadre1_idx` (`Comprador_compra_quadre_idComprador_compra_quadre_id` ASC) VISIBLE,
  CONSTRAINT `fk_Quadres_Comprador_compra_quadre1`
    FOREIGN KEY (`Comprador_compra_quadre_idComprador_compra_quadre_id`)
    REFERENCES `m2_Modelatge_BBDD`.`Comprador_compra_quadre` (`idComprador_compra_quadre_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `m2_Modelatge_BBDD`.`Usuaris_Videos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `m2_Modelatge_BBDD`.`Usuaris_Videos` (
  `id_usuari` INT NOT NULL AUTO_INCREMENT COMMENT 'Holds the user id',
  `usuari_contrasenya` VARCHAR(10) NOT NULL COMMENT 'Holds the user password',
  `usuari_email` VARCHAR(255) NOT NULL COMMENT 'Holds the user mail',
  PRIMARY KEY (`id_usuari`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `m2_Modelatge_BBDD`.`Videos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `m2_Modelatge_BBDD`.`Videos` (
  `id_video` INT NOT NULL AUTO_INCREMENT COMMENT 'Holds the id from the video',
  `video_descripcio` VARCHAR(255) NULL COMMENT 'Holds the video description',
  `video_url` VARCHAR(45) NULL COMMENT 'Holds the video url',
  `Usuaris_id_usuari` INT NOT NULL,
  PRIMARY KEY (`id_video`),
  INDEX `fk_Videos_Usuaris1_idx` (`Usuaris_id_usuari` ASC) VISIBLE,
  CONSTRAINT `fk_Videos_Usuaris1`
    FOREIGN KEY (`Usuaris_id_usuari`)
    REFERENCES `m2_Modelatge_BBDD`.`Usuaris_Videos` (`id_usuari`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `m2_Modelatge_BBDD`.`Autors`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `m2_Modelatge_BBDD`.`Autors` (
  `id_Autor` INT NOT NULL AUTO_INCREMENT COMMENT 'Holds the author id',
  `autor_direccio` VARCHAR(45) NULL COMMENT 'Holds the author address',
  PRIMARY KEY (`id_Autor`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `m2_Modelatge_BBDD`.`Cataleg`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `m2_Modelatge_BBDD`.`Cataleg` (
  `id_llibre` INT NOT NULL AUTO_INCREMENT COMMENT 'Holds the book id',
  `llibre_titol` VARCHAR(45) NULL COMMENT 'Holds the book title',
  `unitats_disponible` INT NULL COMMENT 'Holds the quantity of available books',
  `llibre_preu` DECIMAL(8,2) NULL COMMENT 'Holds the book price',
  `Autors_id_Autor` INT NOT NULL COMMENT 'Holds the book´s author',
  PRIMARY KEY (`id_llibre`),
  INDEX `fk_Llibres_Autors1_idx` (`Autors_id_Autor` ASC) VISIBLE,
  CONSTRAINT `fk_Llibres_Autors1`
    FOREIGN KEY (`Autors_id_Autor`)
    REFERENCES `m2_Modelatge_BBDD`.`Autors` (`id_Autor`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `m2_Modelatge_BBDD`.`Usuaris_Cataleg`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `m2_Modelatge_BBDD`.`Usuaris_Cataleg` (
  `id_usuari` INT NOT NULL AUTO_INCREMENT COMMENT 'Holds the user id',
  `usuari_nom` VARCHAR(45) NOT NULL COMMENT 'Holds the user name',
  `usuari_email` VARCHAR(255) NOT NULL COMMENT 'Holds the user email',
  `usuari_contrasenya` VARCHAR(45) NOT NULL COMMENT 'Holds the user password',
  PRIMARY KEY (`id_usuari`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `m2_Modelatge_BBDD`.`Factures`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `m2_Modelatge_BBDD`.`Factures` (
  `id_factura` INT NOT NULL AUTO_INCREMENT COMMENT 'Holds the ticket id',
  `factura_data` DATETIME NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Holds the date of the purchase',
  `Cataleg_id_llibre` INT NOT NULL COMMENT 'Holds the book id',
  `Usuaris_id_usuari` INT NOT NULL,
  PRIMARY KEY (`id_factura`),
  INDEX `fk_Factures_Cataleg1_idx` (`Cataleg_id_llibre` ASC) VISIBLE,
  INDEX `fk_Factures_Usuaris1_idx` (`Usuaris_id_usuari` ASC) VISIBLE,
  CONSTRAINT `fk_Factures_Cataleg1`
    FOREIGN KEY (`Cataleg_id_llibre`)
    REFERENCES `m2_Modelatge_BBDD`.`Cataleg` (`id_llibre`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Factures_Usuaris1`
    FOREIGN KEY (`Usuaris_id_usuari`)
    REFERENCES `m2_Modelatge_BBDD`.`Usuaris_Cataleg` (`id_usuari`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `m2_Modelatge_BBDD`.`Usuaris_Fotos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `m2_Modelatge_BBDD`.`Usuaris_Fotos` (
  `id_usuari` INT NOT NULL AUTO_INCREMENT COMMENT 'Holds the user id',
  `usuari_nom` VARCHAR(45) NOT NULL COMMENT 'Holds the user name',
  `usuari_contrasenya` VARCHAR(45) NOT NULL COMMENT 'Holds the user password',
  `usuari_email` VARCHAR(255) NOT NULL COMMENT 'Holds the user email',
  PRIMARY KEY (`id_usuari`),
  UNIQUE INDEX `id_usuari_UNIQUE` (`id_usuari` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `m2_Modelatge_BBDD`.`Fotografies`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `m2_Modelatge_BBDD`.`Fotografies` (
  `id_foto` INT NOT NULL AUTO_INCREMENT COMMENT 'Holds the picture id',
  `foto_adreca` TEXT NULL COMMENT 'Holds the picture address',
  `foto_url` VARCHAR(100) NULL COMMENT 'Holds the picture url',
  `Usuaris_id_usuari` INT NOT NULL COMMENT 'Holds the user id who took the picture',
  PRIMARY KEY (`id_foto`),
  UNIQUE INDEX `id_fotografia_UNIQUE` (`id_foto` ASC) VISIBLE,
  INDEX `fk_Fotografies_Usuaris1_idx` (`Usuaris_id_usuari` ASC) VISIBLE,
  CONSTRAINT `fk_Fotografies_Usuaris1`
    FOREIGN KEY (`Usuaris_id_usuari`)
    REFERENCES `m2_Modelatge_BBDD`.`Usuaris_Fotos` (`id_usuari`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `m2_Modelatge_BBDD`.`Proveidors`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `m2_Modelatge_BBDD`.`Proveidors` (
  `id_proveidor` INT NOT NULL AUTO_INCREMENT COMMENT 'Holds the supplier id',
  `proveidor_nom` VARCHAR(45) NOT NULL COMMENT 'Holds the supplier name',
  `proveidor_adreca_carrer` VARCHAR(45) NOT NULL COMMENT 'Holds the supplier adress : street',
  `proveidor_adreca_num` INT NULL COMMENT 'Holds the supplier adress : number',
  `proveidor_adreca_pis` INT(1) NULL COMMENT 'Holds the supplier adress : floor',
  `proveidor_adreca_porta` CHAR(2) NULL COMMENT 'Holds the supplier adress : door',
  `proveidor_adreca_ciutat` TEXT NULL COMMENT 'Holds the supplier adress : city',
  `proveidor_adreca_pais` TEXT NULL COMMENT 'Holds the supplier adress : country',
  `proveidor_tlf` INT NULL COMMENT 'Holds the supplier phone',
  `proveidor_fax` VARCHAR(45) NULL COMMENT 'Holds the supplier fax',
  `proveidor_NIF` VARCHAR(9) NOT NULL COMMENT 'Holds the supplier NIF',
  PRIMARY KEY (`id_proveidor`),
  INDEX `idx_proveidor_NIF` (`proveidor_NIF` ASC) VISIBLE,
  INDEX `idx_proveidor_nom` (`proveidor_nom` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `m2_Modelatge_BBDD`.`Marques`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `m2_Modelatge_BBDD`.`Marques` (
  `id_marca_ulleres` INT NOT NULL AUTO_INCREMENT COMMENT 'Holds the glasses brand id',
  `marca_nom` TEXT NULL COMMENT 'Holds the glasses brand name',
  `Proveidors_id_proveidor` INT NOT NULL,
  PRIMARY KEY (`id_marca_ulleres`),
  INDEX `fk_Marques_Proveidors1_idx` (`Proveidors_id_proveidor` ASC) VISIBLE,
  CONSTRAINT `fk_Marques_Proveidors1`
    FOREIGN KEY (`Proveidors_id_proveidor`)
    REFERENCES `m2_Modelatge_BBDD`.`Proveidors` (`id_proveidor`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `m2_Modelatge_BBDD`.`Ulleres`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `m2_Modelatge_BBDD`.`Ulleres` (
  `id_ulleres` INT NOT NULL AUTO_INCREMENT COMMENT 'Holds the glasses id',
  `ulleres_graduacio_dret` DECIMAL(4,3) NULL COMMENT 'Holds the glasses graduation right eye',
  `ulleres_graduacio_esq` DECIMAL(4,3) NULL COMMENT 'Holds the glasses graduation left eye',
  `ulleres_muntura` CHAR(1) NULL COMMENT 'Holds the first letter of the glasses structure material :\nF = flotant\nP = Pasta\nM = Metal·lica',
  `muntura_color` VARCHAR(20) NULL COMMENT 'Holds the glasses structure´s color',
  `vidre_color` VARCHAR(45) NULL COMMENT 'Holds the glass color',
  `ulleres_preu` DECIMAL(5,3) NOT NULL COMMENT 'Holds the glasses price',
  `Marques_id_marca_ulleres` INT NOT NULL,
  PRIMARY KEY (`id_ulleres`),
  INDEX `fk_Ulleres_Marques1_idx` (`Marques_id_marca_ulleres` ASC) VISIBLE,
  CONSTRAINT `fk_Ulleres_Marques1`
    FOREIGN KEY (`Marques_id_marca_ulleres`)
    REFERENCES `m2_Modelatge_BBDD`.`Marques` (`id_marca_ulleres`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `m2_Modelatge_BBDD`.`Clients`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `m2_Modelatge_BBDD`.`Clients` (
  `id_client` INT NOT NULL AUTO_INCREMENT COMMENT 'Holds the client id',
  `client_nom` VARCHAR(45) NOT NULL COMMENT 'Holds the client name',
  `client_adreca_carrer` VARCHAR(45) NULL COMMENT 'Holds the client adress : street',
  `client_adreca_num` INT NULL COMMENT 'Holds the client adress : number',
  `client_adreca_pis` INT(1) NULL COMMENT 'Holds the client adress : floor',
  `client_adreca_porta` CHAR(2) NULL COMMENT 'Holds the client adress : door',
  `client_adreca_ciutat` TEXT NULL COMMENT 'Holds the client adress : city',
  `client_adreca_pais` TEXT NULL COMMENT 'Holds the client adress : country',
  `client_tlf` INT NOT NULL COMMENT 'Holds the client phone',
  `client_email` VARCHAR(255) NOT NULL COMMENT 'Holds the client email',
  `client_registre_data` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `id_client_recomanat_per` INT NULL,
  PRIMARY KEY (`id_client`),
  INDEX `idx_client_nom` (`client_nom` ASC) INVISIBLE,
  INDEX `idx_client_email` (`client_email` ASC) VISIBLE,
  INDEX `fk_Clients_Clients1_idx` (`id_client_recomanat_per` ASC) VISIBLE,
  CONSTRAINT `fk_Clients_Clients1`
    FOREIGN KEY (`id_client_recomanat_per`)
    REFERENCES `m2_Modelatge_BBDD`.`Clients` (`id_client`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `m2_Modelatge_BBDD`.`Empleats`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `m2_Modelatge_BBDD`.`Empleats` (
  `id_empleat` INT NOT NULL AUTO_INCREMENT,
  `empleat_nom` VARCHAR(45) NULL,
  PRIMARY KEY (`id_empleat`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `m2_Modelatge_BBDD`.`Compres`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `m2_Modelatge_BBDD`.`Compres` (
  `id_compra` INT NOT NULL AUTO_INCREMENT COMMENT 'Holds the purchase id',
  `Empleats_id_empleat` INT NOT NULL COMMENT 'Holds the employee id who sold the glasses',
  `compra_data` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Holds the date of the purchase',
  `Clients_id_client` INT NOT NULL,
  PRIMARY KEY (`id_compra`),
  INDEX `fk_Compres_Empleats1_idx` (`Empleats_id_empleat` ASC) VISIBLE,
  INDEX `fk_Compres_Clients1_idx` (`Clients_id_client` ASC) VISIBLE,
  CONSTRAINT `fk_Compres_Empleats1`
    FOREIGN KEY (`Empleats_id_empleat`)
    REFERENCES `m2_Modelatge_BBDD`.`Empleats` (`id_empleat`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Compres_Clients1`
    FOREIGN KEY (`Clients_id_client`)
    REFERENCES `m2_Modelatge_BBDD`.`Clients` (`id_client`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `m2_Modelatge_BBDD`.`Usuari_amic_usuari`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `m2_Modelatge_BBDD`.`Usuari_amic_usuari` (
  `id_usuari_amic_usuari` INT NOT NULL AUTO_INCREMENT,
  `Usuaris_id_usuari` INT NOT NULL,
  `Usuaris_id_usuari_amic` INT NOT NULL,
  `amistat_origin` TEXT NULL,
  PRIMARY KEY (`id_usuari_amic_usuari`),
  INDEX `fk_Usuari_amic_usuari_Usuaris1_idx` (`Usuaris_id_usuari` ASC) VISIBLE,
  INDEX `fk_Usuari_amic_usuari_Usuaris2_idx` (`Usuaris_id_usuari_amic` ASC) VISIBLE,
  CONSTRAINT `fk_Usuari_amic_usuari_Usuaris1`
    FOREIGN KEY (`Usuaris_id_usuari`)
    REFERENCES `m2_Modelatge_BBDD`.`Usuaris_Fotos` (`id_usuari`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Usuari_amic_usuari_Usuaris2`
    FOREIGN KEY (`Usuaris_id_usuari_amic`)
    REFERENCES `m2_Modelatge_BBDD`.`Usuaris_Fotos` (`id_usuari`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `m2_Modelatge_BBDD`.`Ulleres_per_compra`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `m2_Modelatge_BBDD`.`Ulleres_per_compra` (
  `id_ulleres_per_compra` INT NOT NULL AUTO_INCREMENT COMMENT 'Holds the tuple(glasses,purchase) id',
  `Compres_id_compra` INT NOT NULL COMMENT 'Holds the purchase id',
  `Ulleres_id_ulleres` INT NOT NULL COMMENT 'Holds the glasses id',
  PRIMARY KEY (`id_ulleres_per_compra`),
  INDEX `fk_Ulleres_per_compra_Compres1_idx` (`Compres_id_compra` ASC) VISIBLE,
  INDEX `fk_Ulleres_per_compra_Ulleres1_idx` (`Ulleres_id_ulleres` ASC) VISIBLE,
  CONSTRAINT `fk_Ulleres_per_compra_Compres1`
    FOREIGN KEY (`Compres_id_compra`)
    REFERENCES `m2_Modelatge_BBDD`.`Compres` (`id_compra`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Ulleres_per_compra_Ulleres1`
    FOREIGN KEY (`Ulleres_id_ulleres`)
    REFERENCES `m2_Modelatge_BBDD`.`Ulleres` (`id_ulleres`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

USE `m2_modelatge_bbdd` ;

-- -----------------------------------------------------
-- Table `m2_modelatge_bbdd`.`avions`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `m2_modelatge_bbdd`.`avions` (
  `id_avio` INT NOT NULL AUTO_INCREMENT COMMENT 'Holds plane id',
  `capacitat` INT NULL DEFAULT NULL COMMENT 'Hold the amount of passengers allowed in the flight',
  `model` VARCHAR(45) NULL DEFAULT NULL COMMENT 'Holds the model plane',
  PRIMARY KEY (`id_avio`),
  UNIQUE INDEX `id_avio_UNIQUE` (`id_avio` ASC) VISIBLE)
ENGINE = InnoDB
AUTO_INCREMENT = 2
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `m2_modelatge_bbdd`.`comprador`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `m2_modelatge_bbdd`.`comprador` (
  `id_comprador` INT NOT NULL AUTO_INCREMENT COMMENT 'Holds the id buyer',
  `comprador_dni` VARCHAR(9) NOT NULL COMMENT 'Holds the identity card from the buyer',
  `comprador_nom` VARCHAR(45) NOT NULL COMMENT 'Holds the first name from the buyer',
  `comprador_cognom` VARCHAR(45) NOT NULL COMMENT 'Holds the second name from the buyer',
  PRIMARY KEY (`id_comprador`),
  UNIQUE INDEX `id_comprador_UNIQUE` (`id_comprador` ASC) VISIBLE,
  INDEX `idx_cognom` (`comprador_cognom` ASC) INVISIBLE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `m2_modelatge_bbdd`.`quadres`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `m2_modelatge_bbdd`.`quadres` (
  `id_quadre` INT NOT NULL COMMENT 'Holds the painting id',
  `quadre_preu` INT NOT NULL COMMENT 'Holds the painting price',
  `quadre_autor` VARCHAR(45) NULL DEFAULT NULL COMMENT 'Holds the painting author',
  PRIMARY KEY (`id_quadre`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `m2_modelatge_bbdd`.`comprador_compra_quadre`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `m2_modelatge_bbdd`.`comprador_compra_quadre` (
  `idComprador_compra_quadre_id` INT NOT NULL AUTO_INCREMENT,
  `Quadres_id_quadre` INT NOT NULL COMMENT 'Holds the painting id',
  `Comprador_id_comprador` INT NOT NULL COMMENT 'Holds the id of the buyer',
  `compra_data` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Holds the date-time of the purchace',
  PRIMARY KEY (`idComprador_compra_quadre_id`),
  INDEX `fk_Comprador_compra_quadre_Quadres1_idx` (`Quadres_id_quadre` ASC) VISIBLE,
  INDEX `fk_Comprador_compra_quadre_Comprador1_idx` (`Comprador_id_comprador` ASC) VISIBLE,
  CONSTRAINT `fk_Comprador_compra_quadre_Comprador1`
    FOREIGN KEY (`Comprador_id_comprador`)
    REFERENCES `m2_modelatge_bbdd`.`comprador` (`id_comprador`),
  CONSTRAINT `fk_Comprador_compra_quadre_Quadres1`
    FOREIGN KEY (`Quadres_id_quadre`)
    REFERENCES `m2_modelatge_bbdd`.`quadres` (`id_quadre`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `m2_modelatge_bbdd`.`seients`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `m2_modelatge_bbdd`.`seients` (
  `id_seient` INT NOT NULL AUTO_INCREMENT COMMENT 'Holds the id seat',
  `Avions_id_avio` INT NOT NULL,
  PRIMARY KEY (`id_seient`),
  UNIQUE INDEX `id_seient_UNIQUE` (`id_seient` ASC) VISIBLE,
  INDEX `fk_Seients_Avions1_idx` (`Avions_id_avio` ASC) VISIBLE,
  CONSTRAINT `fk_Seients_Avions1`
    FOREIGN KEY (`Avions_id_avio`)
    REFERENCES `m2_modelatge_bbdd`.`avions` (`id_avio`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `m2_modelatge_bbdd`.`usuaris`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `m2_modelatge_bbdd`.`usuaris` (
  `id_usuari` INT NOT NULL COMMENT 'Holds the user id',
  `usuari_contrasenya` VARCHAR(10) NOT NULL COMMENT 'Holds the user password',
  `usuari_email` VARCHAR(255) NOT NULL COMMENT 'Holds the user mail',
  PRIMARY KEY (`id_usuari`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `m2_modelatge_bbdd`.`videos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `m2_modelatge_bbdd`.`videos` (
  `id_video` INT NOT NULL COMMENT 'Holds the id from the video',
  `video_descripcio` VARCHAR(255) NULL DEFAULT NULL COMMENT 'Holds the video description',
  `video_url` VARCHAR(45) NULL DEFAULT NULL COMMENT 'Holds the video url',
  `Usuaris_id_usuari` INT NOT NULL,
  PRIMARY KEY (`id_video`),
  INDEX `fk_Videos_Usuaris1_idx` (`Usuaris_id_usuari` ASC) VISIBLE,
  CONSTRAINT `fk_Videos_Usuaris1`
    FOREIGN KEY (`Usuaris_id_usuari`)
    REFERENCES `m2_modelatge_bbdd`.`usuaris` (`id_usuari`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
