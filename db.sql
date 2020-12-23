-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`application`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`application` (
  `idapplication`  NOT NULL,
  `cv` LONGTEXT NOT NULL,
  `Description` LONGTEXT NOT NULL,
  `IsApproved`  NOT NULL DEFAULT '0',
  `name` VARCHAR(45) NOT NULL,
  `username` VARCHAR(45) NOT NULL,
  `surname` VARCHAR(45) NOT NULL,
  `password` VARCHAR(45) NOT NULL,
  `email` VARCHAR(45) NOT NULL,
  `ImageUrl` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`idapplication`),
  UNIQUE INDEX `idapplication_UNIQUE` (`idapplication` ASC) VISIBLE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `mydb`.`user`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`user` (
  `id`  NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  `surname` VARCHAR(45) NOT NULL,
  `username` VARCHAR(45) NOT NULL,
  `userType` VARCHAR(45) NOT NULL,
  `password` VARCHAR(200) NOT NULL,
  `email` VARCHAR(70) NOT NULL,
  `ImageUrl` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `idUser_UNIQUE` (`id` ASC) VISIBLE)
ENGINE = InnoDB
AUTO_INCREMENT = 7
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `mydb`.`instructor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`instructor` (
  `idInstructor`  NOT NULL,
  `Iban_no` VARCHAR(200) NOT NULL,
  `cv` LONGTEXT NOT NULL,
  `User_idUser`  NOT NULL,
  `course`  NULL DEFAULT NULL,
  `Score` DOUBLE NOT NULL,
  PRIMARY KEY (`idInstructor`, `User_idUser`),
  UNIQUE INDEX `idInstructor_UNIQUE` (`idInstructor` ASC) VISIBLE,
  INDEX `fk_Instructor_User1_idx` (`User_idUser` ASC) VISIBLE,
  CONSTRAINT `fk_Instructor_User1`
    FOREIGN KEY (`User_idUser`)
    REFERENCES `mydb`.`user` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `mydb`.`premium`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`premium` (
  `idPremium`  NOT NULL,
  `User_idUser`  NOT NULL,
  PRIMARY KEY (`idPremium`, `User_idUser`),
  UNIQUE INDEX `idPremium_UNIQUE` (`idPremium` ASC) VISIBLE,
  INDEX `fk_Premium_User1_idx` (`User_idUser` ASC) VISIBLE,
  CONSTRAINT `fk_Premium_User1`
    FOREIGN KEY (`User_idUser`)
    REFERENCES `mydb`.`user` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `mydb`.`asktoteacher`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`asktoteacher` (
  `idAskToTeacher`  NOT NULL,
  `Premium_idPremium`  NOT NULL,
  `question` LONGTEXT NULL DEFAULT NULL,
  `qUrl` VARCHAR(200) NULL DEFAULT NULL,
  `answer` LONGTEXT NULL DEFAULT NULL,
  `aUrl` VARCHAR(200) NULL DEFAULT NULL,
  `course` VARCHAR(45) NOT NULL,
  `date`  NOT NULL,
  `Instructor_idInstructor`  NOT NULL,
  `Instructor_User_idUser`  NOT NULL,
  PRIMARY KEY (`idAskToTeacher`, `Premium_idPremium`, `Instructor_idInstructor`, `Instructor_User_idUser`),
  UNIQUE INDEX `idAskToTeacher_UNIQUE` (`idAskToTeacher` ASC) VISIBLE,
  INDEX `fk_AskToTeacher_Premium1_idx` (`Premium_idPremium` ASC) VISIBLE,
  INDEX `fk_AskToTeacher_Instructor1_idx` (`Instructor_idInstructor` ASC, `Instructor_User_idUser` ASC) VISIBLE,
  CONSTRAINT `fk_AskToTeacher_Instructor1`
    FOREIGN KEY (`Instructor_idInstructor` , `Instructor_User_idUser`)
    REFERENCES `mydb`.`instructor` (`idInstructor` , `User_idUser`),
  CONSTRAINT `fk_AskToTeacher_Premium1`
    FOREIGN KEY (`Premium_idPremium`)
    REFERENCES `mydb`.`premium` (`idPremium`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `mydb`.`card`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`card` (
  `idCard`  NOT NULL,
  `Card_no` VARCHAR(100) NOT NULL,
  `Card_password` VARCHAR(45) NOT NULL,
  `Card_date` VARCHAR(45) NOT NULL,
  `Card_cvc` VARCHAR(45) NOT NULL,
  `Card_name` VARCHAR(45) NOT NULL,
  `Premium_idPremium`  NOT NULL,
  `Premium_User_idUser`  NOT NULL,
  PRIMARY KEY (`idCard`),
  UNIQUE INDEX `idPremium_UNIQUE` (`idCard` ASC) VISIBLE,
  UNIQUE INDEX `Card_no_UNIQUE` (`Card_no` ASC) VISIBLE,
  INDEX `fk_card_Premium1_idx` (`Premium_idPremium` ASC, `Premium_User_idUser` ASC) VISIBLE,
  CONSTRAINT `fk_card_Premium1`
    FOREIGN KEY (`Premium_idPremium` , `Premium_User_idUser`)
    REFERENCES `mydb`.`premium` (`idPremium` , `User_idUser`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `mydb`.`contact`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`contact` (
  `idContact`  NOT NULL,
  `Message` LONGTEXT NOT NULL,
  `messageType` VARCHAR(45) NOT NULL,
  `User_idUser`  NOT NULL,
  PRIMARY KEY (`idContact`, `User_idUser`),
  UNIQUE INDEX `idContact_UNIQUE` (`idContact` ASC) VISIBLE,
  INDEX `fk_Contact_User1_idx` (`User_idUser` ASC) VISIBLE,
  CONSTRAINT `fk_Contact_User1`
    FOREIGN KEY (`User_idUser`)
    REFERENCES `mydb`.`user` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `mydb`.`course`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`course` (
  `idCourse`  NOT NULL,
  `category` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idCourse`),
  UNIQUE INDEX `idCourse_UNIQUE` (`idCourse` ASC) VISIBLE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `mydb`.`course_has_instructor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`course_has_instructor` (
  `Course_idCourse`  NOT NULL,
  `Instructor_idInstructor`  NOT NULL,
  `Instructor_User_idUser`  NOT NULL,
  PRIMARY KEY (`Course_idCourse`, `Instructor_idInstructor`, `Instructor_User_idUser`),
  INDEX `fk_Course_has_Instructor_Instructor1_idx` (`Instructor_idInstructor` ASC, `Instructor_User_idUser` ASC) VISIBLE,
  INDEX `fk_Course_has_Instructor_Course1_idx` (`Course_idCourse` ASC) VISIBLE,
  CONSTRAINT `fk_Course_has_Instructor_Course1`
    FOREIGN KEY (`Course_idCourse`)
    REFERENCES `mydb`.`course` (`idCourse`),
  CONSTRAINT `fk_Course_has_Instructor_Instructor1`
    FOREIGN KEY (`Instructor_idInstructor` , `Instructor_User_idUser`)
    REFERENCES `mydb`.`instructor` (`idInstructor` , `User_idUser`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `mydb`.`courselink`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`courselink` (
  `idCourseLink`  NOT NULL,
  `CourseLinkcol` VARCHAR(45) NULL DEFAULT NULL,
  `Instructor_idInstructor`  NOT NULL,
  `Instructor_User_idUser`  NOT NULL,
  PRIMARY KEY (`idCourseLink`, `Instructor_idInstructor`, `Instructor_User_idUser`),
  UNIQUE INDEX `idCourseLink_UNIQUE` (`idCourseLink` ASC) VISIBLE,
  INDEX `fk_CourseLink_Instructor1_idx` (`Instructor_idInstructor` ASC, `Instructor_User_idUser` ASC) VISIBLE,
  CONSTRAINT `fk_CourseLink_Instructor1`
    FOREIGN KEY (`Instructor_idInstructor` , `Instructor_User_idUser`)
    REFERENCES `mydb`.`instructor` (`idInstructor` , `User_idUser`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `mydb`.`messageforpanel`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`messageforpanel` (
  `idMessageForPanel`  NOT NULL,
  `User_idUser`  NOT NULL,
  `ReportNum`  NOT NULL DEFAULT '0',
  `Imageurl` VARCHAR(120) NULL DEFAULT NULL,
  `Date`  NULL DEFAULT NULL,
  PRIMARY KEY (`idMessageForPanel`),
  UNIQUE INDEX `idMessageForPanel_UNIQUE` (`idMessageForPanel` ASC) VISIBLE,
  INDEX `fk_MessageForPanel_User1_idx` (`User_idUser` ASC) VISIBLE,
  CONSTRAINT `fk_MessageForPanel_User1`
    FOREIGN KEY (`User_idUser`)
    REFERENCES `mydb`.`user` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `mydb`.`premium_has_courselink`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`premium_has_courselink` (
  `Premium_idPremium`  NOT NULL,
  `Premium_User_idUser`  NOT NULL,
  `CourseLink_idCourseLink`  NOT NULL,
  `CourseLink_Instructor_idInstructor`  NOT NULL,
  `CourseLink_Instructor_User_idUser`  NOT NULL,
  PRIMARY KEY (`Premium_idPremium`, `Premium_User_idUser`, `CourseLink_idCourseLink`, `CourseLink_Instructor_idInstructor`, `CourseLink_Instructor_User_idUser`),
  INDEX `fk_Premium_has_CourseLink_CourseLink1_idx` (`CourseLink_idCourseLink` ASC, `CourseLink_Instructor_idInstructor` ASC, `CourseLink_Instructor_User_idUser` ASC) VISIBLE,
  INDEX `fk_Premium_has_CourseLink_Premium1_idx` (`Premium_idPremium` ASC, `Premium_User_idUser` ASC) VISIBLE,
  CONSTRAINT `fk_Premium_has_CourseLink_CourseLink1`
    FOREIGN KEY (`CourseLink_idCourseLink` , `CourseLink_Instructor_idInstructor` , `CourseLink_Instructor_User_idUser`)
    REFERENCES `mydb`.`courselink` (`idCourseLink` , `Instructor_idInstructor` , `Instructor_User_idUser`),
  CONSTRAINT `fk_Premium_has_CourseLink_Premium1`
    FOREIGN KEY (`Premium_idPremium` , `Premium_User_idUser`)
    REFERENCES `mydb`.`premium` (`idPremium` , `User_idUser`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `mydb`.`video`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`video` (
  `idCourseVideo`  NOT NULL,
  `Instructor_idInstructor`  NOT NULL,
  `Description` LONGTEXT NOT NULL,
  `Title` VARCHAR(45) NOT NULL,
  `date`  NOT NULL,
  `VideoUrl` LONGTEXT NOT NULL,
  `Category` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`idCourseVideo`, `Instructor_idInstructor`),
  UNIQUE INDEX `idCourseVideo_UNIQUE` (`idCourseVideo` ASC) VISIBLE,
  INDEX `fk_CourseVideo_Instructor1_idx` (`Instructor_idInstructor` ASC) VISIBLE,
  CONSTRAINT `fk_CourseVideo_Instructor1`
    FOREIGN KEY (`Instructor_idInstructor`)
    REFERENCES `mydb`.`instructor` (`idInstructor`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
