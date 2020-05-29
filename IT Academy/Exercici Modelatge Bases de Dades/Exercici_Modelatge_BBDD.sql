#Pràctica final

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
