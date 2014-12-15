-- MySQL Script generated by MySQL Workbench
-- Dom 14 Dez 2014 23:07:59 AMT
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema juufam
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `juufam` ;

-- -----------------------------------------------------
-- Schema juufam
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `juufam` DEFAULT CHARACTER SET utf8 ;
USE `juufam` ;

-- -----------------------------------------------------
-- Table `juufam`.`evento`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `juufam`.`evento` ;

CREATE TABLE IF NOT EXISTS `juufam`.`evento` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(45) NOT NULL,
  `data_ini_event` DATE NOT NULL,
  `data_end_event` DATE NOT NULL,
  `data_ini_insc` DATE NOT NULL,
  `data_end_insc` DATE NOT NULL,
  `cert_conc_path` TEXT NULL DEFAULT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `juufam`.`unidade`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `juufam`.`unidade` ;

CREATE TABLE IF NOT EXISTS `juufam`.`unidade` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `juufam`.`chapa`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `juufam`.`chapa` ;

CREATE TABLE IF NOT EXISTS `juufam`.`chapa` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(45) NOT NULL,
  `id_evento` INT NOT NULL,
  `id_unidade` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `id_evento_idx` (`id_evento` ASC),
  INDEX `id_unidade_idx` (`id_unidade` ASC),
  CONSTRAINT `id_evento`
    FOREIGN KEY (`id_evento`)
    REFERENCES `juufam`.`evento` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `id_unidade`
    FOREIGN KEY (`id_unidade`)
    REFERENCES `juufam`.`unidade` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `juufam`.`usuario`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `juufam`.`usuario` ;

CREATE TABLE IF NOT EXISTS `juufam`.`usuario` (
  `nome` VARCHAR(45) NOT NULL,
  `login` VARCHAR(45) NOT NULL,
  `senha` VARCHAR(45) NOT NULL,
  `id_tipo_usuario` ENUM('representante', 'admin') NOT NULL,
  `id_chapa` INT NOT NULL,
  PRIMARY KEY (`login`),
  INDEX `id_chapa_idx` (`id_chapa` ASC),
  CONSTRAINT `id_chapa`
    FOREIGN KEY (`id_chapa`)
    REFERENCES `juufam`.`chapa` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `juufam`.`instituto`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `juufam`.`instituto` ;

CREATE TABLE IF NOT EXISTS `juufam`.`instituto` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nome` TEXT(100) NOT NULL,
  `id_uni` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `id_uni_idx` (`id_uni` ASC),
  CONSTRAINT `id_uni`
    FOREIGN KEY (`id_uni`)
    REFERENCES `juufam`.`unidade` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `juufam`.`curso`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `juufam`.`curso` ;

CREATE TABLE IF NOT EXISTS `juufam`.`curso` (
  `id` VARCHAR(12) NOT NULL,
  `nome` VARCHAR(45) NOT NULL,
  `id_instituto` INT NOT NULL,
  `id_unidade` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `id_instituto_idx` (`id_instituto` ASC),
  INDEX `id_unidade_idx` (`id_unidade` ASC),
  CONSTRAINT `id_instituto`
    FOREIGN KEY (`id_instituto`)
    REFERENCES `juufam`.`instituto` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `id_unidade_curso`
    FOREIGN KEY (`id_unidade`)
    REFERENCES `juufam`.`unidade` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `juufam`.`atleta`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `juufam`.`atleta` ;

CREATE TABLE IF NOT EXISTS `juufam`.`atleta` (
  `matricula` VARCHAR(8) NULL DEFAULT NULL,
  `cpf` VARCHAR(11) NOT NULL,
  `rg` VARCHAR(255) NULL DEFAULT NULL,
  `nome` VARCHAR(45) NOT NULL,
  `data_nasc` VARCHAR(45) NOT NULL,
  `genero` ENUM('feminino','masculino') NOT NULL,
  `tipo_atleta` ENUM('egresso','funcionario', 'ativo') NOT NULL,
  `id_curso` VARCHAR(12) NOT NULL,
  INDEX `id_curso_idx` (`id_curso` ASC),
  PRIMARY KEY (`cpf`),
  CONSTRAINT `id_curso`
    FOREIGN KEY (`id_curso`)
    REFERENCES `juufam`.`curso` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `juufam`.`modalidade`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `juufam`.`modalidade` ;

CREATE TABLE IF NOT EXISTS `juufam`.`modalidade` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(45) NOT NULL,
  `tipo_modalidade` ENUM('coletivo','individual') NOT NULL,
  `min_inscr` INT NOT NULL,
  `max_inscr` INT NOT NULL,
  `genero` ENUM('masculino','feminino') NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `juufam`.`repr_atleta`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `juufam`.`repr_atleta` ;

CREATE TABLE IF NOT EXISTS `juufam`.`repr_atleta` (
  `id_repr` VARCHAR(45) NOT NULL,
  `id_atleta` VARCHAR(11) NOT NULL,
  `data` DATE NOT NULL,
  INDEX `fk_id_representante_idx` (`id_repr` ASC),
  INDEX `fk_id_atleta_idx` (`id_atleta` ASC),
  CONSTRAINT `fk_id_representante`
    FOREIGN KEY (`id_repr`)
    REFERENCES `juufam`.`usuario` (`login`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_id_atleta`
    FOREIGN KEY (`id_atleta`)
    REFERENCES `juufam`.`atleta` (`cpf`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `juufam`.`time`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `juufam`.`time` ;

CREATE TABLE IF NOT EXISTS `juufam`.`time` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `id_modalidade` INT NOT NULL,
  `id_curso` VARCHAR(12) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `id_modalidade_time` (`id_modalidade` ASC),
  INDEX `id_curso_time` (`id_curso` ASC),
  CONSTRAINT `id_modalidade_time`
    FOREIGN KEY (`id_modalidade`)
    REFERENCES `juufam`.`modalidade` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `id_curso_time`
    FOREIGN KEY (`id_curso`)
    REFERENCES `juufam`.`curso` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `juufam`.`time_atletas`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `juufam`.`time_atletas` ;

CREATE TABLE IF NOT EXISTS `juufam`.`time_atletas` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `id_atleta` VARCHAR(11) NOT NULL,
  `id_time` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `id_time_time` (`id_time` ASC),
  INDEX `fk_id_atleta_time_idx` (`id_atleta` ASC),
  CONSTRAINT `id_time_time`
    FOREIGN KEY (`id_time`)
    REFERENCES `juufam`.`time` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_id_atleta_time`
    FOREIGN KEY (`id_atleta`)
    REFERENCES `juufam`.`atleta` (`cpf`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `juufam`.`evento_modalidade`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `juufam`.`evento_modalidade` ;

CREATE TABLE IF NOT EXISTS `juufam`.`evento_modalidade` (
  `id_evento` INT NOT NULL,
  `id_modalidade` INT NOT NULL,
  INDEX `id_evento_idx` (`id_evento` ASC),
  INDEX `id_modalidade_idx` (`id_modalidade` ASC),
  CONSTRAINT `id_evento_modalidade`
    FOREIGN KEY (`id_evento`)
    REFERENCES `juufam`.`evento` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `id_modalidade_evento`
    FOREIGN KEY (`id_modalidade`)
    REFERENCES `juufam`.`modalidade` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
