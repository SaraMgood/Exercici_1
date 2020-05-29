-- MySQL Workbench Synchronization
-- Generated: 2020-05-28 17:24
-- Model: New Model
-- Version: 1.0
-- Project: Name of the project
-- Author: USUARIO

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

CREATE TABLE IF NOT EXISTS `mydb`.`Plane` (
  `id_plane` INT(11) NOT NULL COMMENT 'Holds contact ID plane',
  `capacity` INT(11) NULL DEFAULT NULL COMMENT 'Holds contact capacity plane',
  `model` VARCHAR(45) NULL DEFAULT NULL COMMENT 'Holds contact model plane',
  PRIMARY KEY (`id_plane`),
  INDEX `model` (`model` ASC) VISIBLE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
KEY_BLOCK_SIZE = 1;

CREATE TABLE IF NOT EXISTS `mydb`.`Seat` (
  `id_seat` INT(11) NOT NULL,
  `Plane_id_plane` INT(11) NOT NULL,
  PRIMARY KEY (`id_seat`),
  INDEX `fk_Seat_Plane_idx` (`Plane_id_plane` ASC) INVISIBLE,
  CONSTRAINT `fk_Seat_Plane`
    FOREIGN KEY (`Plane_id_plane`)
    REFERENCES `mydb`.`Plane` (`id_plane`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `mydb`.`Painting` (
  `id_painting` INT(11) NOT NULL,
  `price` FLOAT(11) NULL DEFAULT NULL,
  `author` VARCHAR(45) NULL DEFAULT NULL COMMENT 'Author\'s painting. When 0 = anonymous',
  `sold out` VARCHAR(1) NOT NULL COMMENT 'Status purchase, whether it is sold out or not \n1- YES\n0- NO',
  `Buyer_Buyer_id` INT(11) NOT NULL,
  PRIMARY KEY (`id_painting`),
  UNIQUE INDEX `author_UNIQUE` (`author` ASC) INVISIBLE,
  INDEX `fk_Painting_Buyer1_idx` (`Buyer_Buyer_id` ASC) INVISIBLE,
  INDEX `status` (`sold out` ASC) VISIBLE,
  CONSTRAINT `fk_Painting_Buyer1`
    FOREIGN KEY (`Buyer_Buyer_id`)
    REFERENCES `mydb`.`Buyer` (`Buyer_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `mydb`.`Buyer` (
  `Buyer_id` INT(11) NOT NULL,
  `Buyer_name` VARCHAR(45) NULL DEFAULT NULL COMMENT 'Buyer\'s name',
  `Buyer_lastname` VARCHAR(45) NULL DEFAULT NULL COMMENT 'Buyer\'s last name',
  PRIMARY KEY (`Buyer_id`),
  INDEX `last name` (`Buyer_lastname` ASC) INVISIBLE,
  INDEX `name` (`Buyer_name` ASC) VISIBLE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `mydb`.`User` (
  `e-mail` VARCHAR(15) NOT NULL,
  `password` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`e-mail`),
  UNIQUE INDEX `password_UNIQUE` (`password` ASC) VISIBLE,
  UNIQUE INDEX `e-mail_UNIQUE` (`e-mail` ASC) VISIBLE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `mydb`.`Stube` (
  `description` VARCHAR(1000) NOT NULL,
  `title` VARCHAR(45) NOT NULL,
  `url` VARCHAR(45) NULL DEFAULT NULL,
  `id` VARCHAR(45) NOT NULL,
  INDEX `fk_Stube_User1_idx` (`description` ASC) VISIBLE,
  PRIMARY KEY (`id`),
  INDEX `id` (`id` ASC) VISIBLE,
  CONSTRAINT `fk_Stube_User1`
    FOREIGN KEY (`description`)
    REFERENCES `mydb`.`User` (`e-mail`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `mydb`.`Catalog` (
  `book_id` VARCHAR(20) NOT NULL,
  `title` VARCHAR(45) NULL DEFAULT NULL,
  `units` INT(11) NULL DEFAULT NULL COMMENT 'Available books unit',
  `price` FLOAT(11) NOT NULL,
  `Author_name` VARCHAR(10) NOT NULL,
  PRIMARY KEY (`book_id`),
  INDEX `fk_Catalog_Author1_idx` (`Author_name` ASC) VISIBLE,
  CONSTRAINT `fk_Catalog_Author1`
    FOREIGN KEY (`Author_name`)
    REFERENCES `mydb`.`Author` (`name`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `mydb`.`Author` (
  `name` VARCHAR(10) NOT NULL,
  `adress` VARCHAR(45) NULL DEFAULT NULL,
  `publications` INT(11) NULL DEFAULT NULL COMMENT 'Number of author\'s publication\n(1 or more)',
  PRIMARY KEY (`name`),
  UNIQUE INDEX `adress_UNIQUE` (`adress` ASC) VISIBLE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `mydb`.`Invoice` (
  `book_id` VARCHAR(20) NOT NULL,
  `title` VARCHAR(45) NOT NULL,
  `units` INT(11) NOT NULL,
  `price` FLOAT(11) NULL DEFAULT NULL,
  `User_user_name` VARCHAR(45) NOT NULL,
  INDEX `fk_Invoice_User1_idx` (`User_user_name` ASC) VISIBLE,
  PRIMARY KEY (`book_id`),
  UNIQUE INDEX `book_id_UNIQUE` (`book_id` ASC) VISIBLE,
  INDEX `idx_title` () VISIBLE,
  CONSTRAINT `fk_Invoice_User1`
    FOREIGN KEY (`User_user_name`)
    REFERENCES `mydb`.`User` (`user_name`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `mydb`.`Invoice_has_Catalog` (
  `Invoice_has_Catalog_col` VARCHAR(45) NOT NULL,
  `Catalog_book` VARCHAR(20) NOT NULL,
  `Invoice_book` INT(11) NOT NULL,
  INDEX `fk_Invoice_has_Catalog_Catalog1_idx` (`Catalog_book` ASC) VISIBLE,
  INDEX `fk_Invoice_has_Catalog_Invoice1_idx` (`Invoice_book` ASC) VISIBLE,
  PRIMARY KEY (`Invoice_has_Catalog_col`),
  CONSTRAINT `fk_Invoice_has_Catalog_Catalog1`
    FOREIGN KEY (`Catalog_book`)
    REFERENCES `mydb`.`Catalog` (`book_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Invoice_has_Catalog_Invoice1`
    FOREIGN KEY (`Invoice_book`)
    REFERENCES `mydb`.`Invoice` (`title`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `mydb`.`Social Network` (
  `user_id` VARCHAR(20) NOT NULL,
  `relationship` VARCHAR(45) NOT NULL COMMENT 'User\'s relationship, how did they met. \n\ndirect friends\nfriends of friends\nfamily \n',
  `photos` VARCHAR(45) NOT NULL,
  `User_user_id` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`user_id`),
  UNIQUE INDEX `user_id_UNIQUE` (`user_id` ASC) VISIBLE,
  INDEX `idx_photos` (`photos` ASC) VISIBLE,
  INDEX `fk_Social Network_User1_idx` (`User_user_id` ASC) VISIBLE,
  CONSTRAINT `fk_Social Network_User1`
    FOREIGN KEY (`User_user_id`)
    REFERENCES `mydb`.`User` (`user_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `mydb`.`Photo` (
  `photo_code` INT(11) NOT NULL,
  `adress` VARCHAR(45) NULL DEFAULT NULL,
  `url` VARCHAR(45) NOT NULL,
  `User_user_id` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`photo_code`),
  UNIQUE INDEX `url_UNIQUE` (`url` ASC) VISIBLE,
  UNIQUE INDEX `photo_code_UNIQUE` (`photo_code` ASC) VISIBLE,
  INDEX `fk_Photo_User1_idx` (`User_user_id` ASC) VISIBLE,
  CONSTRAINT `fk_Photo_User1`
    FOREIGN KEY (`User_user_id`)
    REFERENCES `mydb`.`User` (`user_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `mydb`.`Supplier` (
  `name` VARCHAR(10) NOT NULL,
  `phone` INT(11) NOT NULL,
  `fax` INT(11) NOT NULL,
  `nif` VARCHAR(45) NOT NULL,
  `Glasses_brand` VARCHAR(20) NOT NULL,
  `Supplier_has_adresses_Supplier_has_adresses_id` INT(11) NOT NULL,
  `Supplier_has_Adress_Supplier_has_Adress` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`name`, `Supplier_has_adresses_Supplier_has_adresses_id`, `Supplier_has_Adress_Supplier_has_Adress`),
  UNIQUE INDEX `phone_UNIQUE` (`phone` ASC) VISIBLE,
  UNIQUE INDEX `fax_UNIQUE` (`fax` ASC) VISIBLE,
  UNIQUE INDEX `nif_UNIQUE` (`nif` ASC) VISIBLE,
  INDEX `name` (`name` ASC) INVISIBLE,
  INDEX `fk_Supplier_Glasses1_idx` (`Glasses_brand` ASC) VISIBLE,
  INDEX `fk_Supplier_Supplier_has_Adress1_idx` (`Supplier_has_Adress_Supplier_has_Adress` ASC) VISIBLE,
  CONSTRAINT `fk_Supplier_Glasses1`
    FOREIGN KEY (`Glasses_brand`)
    REFERENCES `mydb`.`Glasses` (`brand`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Supplier_Supplier_has_Adress1`
    FOREIGN KEY (`Supplier_has_Adress_Supplier_has_Adress`)
    REFERENCES `mydb`.`Supplier_has_Adress` (`Supplier_has_Adress`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `mydb`.`Glasses` (
  `brand` VARCHAR(20) NOT NULL,
  `glasses_graduation` INT(11) NULL DEFAULT NULL,
  `frame` VARCHAR(10) NULL DEFAULT NULL COMMENT 'Type of frame:\nFloating\nPlastic\nMetal',
  `color_frame` VARCHAR(45) NULL DEFAULT NULL,
  `color_glass` VARCHAR(45) NULL DEFAULT NULL COMMENT '0=transparent\nrest will be the name of colors',
  `price` FLOAT(11) NOT NULL,
  `sold_glasses` INT(11) NULL DEFAULT NULL,
  `Supplier_name` VARCHAR(10) NOT NULL,
  `Employee_employee_id` VARCHAR(5) NOT NULL,
  `Client_name` VARCHAR(10) NOT NULL,
  PRIMARY KEY (`brand`),
  UNIQUE INDEX `price_UNIQUE` (`price` ASC) VISIBLE,
  INDEX `brand` (`brand` ASC) INVISIBLE,
  INDEX `fk_Glasses_Supplier1_idx` (`Supplier_name` ASC) VISIBLE,
  INDEX `fk_Glasses_Employee1_idx` (`Employee_employee_id` ASC) VISIBLE,
  INDEX `fk_Glasses_Client1_idx` (`Client_name` ASC) VISIBLE,
  CONSTRAINT `fk_Glasses_Supplier1`
    FOREIGN KEY (`Supplier_name`)
    REFERENCES `mydb`.`Supplier` (`name`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Glasses_Employee1`
    FOREIGN KEY (`Employee_employee_id`)
    REFERENCES `mydb`.`Employee` (`employee_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Glasses_Client1`
    FOREIGN KEY (`Client_name`)
    REFERENCES `mydb`.`Client` (`name`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `mydb`.`Adress` (
  `street` VARCHAR(10) NOT NULL,
  `number` INT(11) NULL DEFAULT NULL,
  `flat` INT(11) NULL DEFAULT NULL,
  `door` INT(11) NULL DEFAULT NULL,
  `city` VARCHAR(45) NULL DEFAULT NULL,
  `zip` INT(11) NULL DEFAULT NULL,
  `country` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`street`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `mydb`.`Supplier_has_Adress` (
  `Supplier_has_Adress` VARCHAR(45) NOT NULL,
  `Adress_street` VARCHAR(10) NOT NULL,
  PRIMARY KEY (`Supplier_has_Adress`),
  INDEX `fk_Supplier_has_Adress_Adress1_idx` (`Adress_street` ASC) VISIBLE,
  CONSTRAINT `fk_Supplier_has_Adress_Adress1`
    FOREIGN KEY (`Adress_street`)
    REFERENCES `mydb`.`Adress` (`street`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `mydb`.`Client` (
  `name` VARCHAR(10) NOT NULL,
  `phone` INT(11) NOT NULL,
  `e-mail` VARCHAR(45) NOT NULL,
  `client_register` DATETIME NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'When the client was first registered.',
  `recommended_by` VARCHAR(45) NULL DEFAULT NULL COMMENT 'Client who has recomended \'Cul d\'Ampolla\' to the new client, could cointain:\n\nClient\'s name \n 0=nobody',
  `Client_has_Adress_Client_has_Adress_id` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`name`, `Client_has_Adress_Client_has_Adress_id`),
  UNIQUE INDEX `e-mail_UNIQUE` (`e-mail` ASC) VISIBLE,
  UNIQUE INDEX `phone_UNIQUE` (`phone` ASC) INVISIBLE,
  INDEX `fk_Client_Client_has_Adress1_idx` (`Client_has_Adress_Client_has_Adress_id` ASC) VISIBLE,
  INDEX `name` (`name` ASC) VISIBLE,
  CONSTRAINT `fk_Client_Client_has_Adress1`
    FOREIGN KEY (`Client_has_Adress_Client_has_Adress_id`)
    REFERENCES `mydb`.`Client_has_Adress` (`Client_has_Adress_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `mydb`.`Client_has_Adress` (
  `Client_has_Adress_id` VARCHAR(45) NOT NULL,
  `Adress_street` VARCHAR(10) NOT NULL,
  INDEX `fk_Client_has_Adress_Adress1_idx` (`Adress_street` ASC) VISIBLE,
  PRIMARY KEY (`Client_has_Adress_id`),
  CONSTRAINT `fk_Client_has_Adress_Adress1`
    FOREIGN KEY (`Adress_street`)
    REFERENCES `mydb`.`Adress` (`street`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `mydb`.`Employee` (
  `employee_id` VARCHAR(5) NOT NULL,
  `name` VARCHAR(45) NULL DEFAULT NULL,
  `sold_glasses` INT(11) NULL DEFAULT NULL,
  PRIMARY KEY (`employee_id`),
  INDEX `employee_id` (`employee_id` ASC) VISIBLE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
