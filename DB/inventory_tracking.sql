-- Inventory Tracking Database Schema
-- Use Case: Managing products, suppliers, customers, orders, and stock levels for an inventory system.
-- This file contains all CREATE TABLE statements as per the assignment requirement.

-- -----------------------------------------------------
-- Disable foreign key checks temporarily to avoid order issues during creation.
-- -----------------------------------------------------
SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='''ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION''';

-- -----------------------------------------------------
-- Table `Suppliers`
-- Stores information about product suppliers.
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Suppliers` (
  `SupplierID` INT NOT NULL AUTO_INCREMENT,
  `SupplierName` VARCHAR(255) NOT NULL,
  `ContactName` VARCHAR(255) NULL,
  `Address` VARCHAR(255) NULL,
  `City` VARCHAR(100) NULL,
  `PostalCode` VARCHAR(20) NULL,
  `Country` VARCHAR(100) NULL,
  `Phone` VARCHAR(50) NULL,
  `Email` VARCHAR(255) NULL,
  PRIMARY KEY (`SupplierID`),
  UNIQUE INDEX `Email_UNIQUE` (`Email` ASC) VISIBLE,
  UNIQUE INDEX `Phone_UNIQUE` (`Phone` ASC) VISIBLE)
ENGINE = InnoDB
COMMENT = 'Stores information about product suppliers.';

-- -----------------------------------------------------
-- Table `Categories`
-- Stores product categories to help organize products.
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Categories` (
  `CategoryID` INT NOT NULL AUTO_INCREMENT,
  `CategoryName` VARCHAR(255) NOT NULL,
  `Description` TEXT NULL,
  PRIMARY KEY (`CategoryID`),
  UNIQUE INDEX `CategoryName_UNIQUE` (`CategoryName` ASC) VISIBLE)
ENGINE = InnoDB
COMMENT = 'Stores product categories.';

-- -----------------------------------------------------
-- Table `Products`
-- Stores detailed information about individual products.
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Products` (
  `ProductID` INT NOT NULL AUTO_INCREMENT,
  `ProductName` VARCHAR(255) NOT NULL,
  `SupplierID` INT NULL,
  `CategoryID` INT NULL,
  `Unit` VARCHAR(50) NULL COMMENT 'Unit of measure, e.g., pcs, kg, ltr, box',
  `Price` DECIMAL(10,2) NOT NULL,
  `ReorderLevel` INT NULL DEFAULT 10 COMMENT 'Minimum stock quantity before reordering is advised',
  `Discontinued` BOOLEAN NOT NULL DEFAULT FALSE COMMENT 'TRUE if the product is no longer available',
  PRIMARY KEY (`ProductID`),
  INDEX `fk_Products_Suppliers_idx` (`SupplierID` ASC) VISIBLE,
  INDEX `fk_Products_Categories_idx` (`CategoryID` ASC) VISIBLE,
  CONSTRAINT `fk_Products_Suppliers`
    FOREIGN KEY (`SupplierID`)
    REFERENCES `Suppliers` (`SupplierID`)
    ON DELETE SET NULL       -- If a supplier is deleted, keep the product but nullify its supplier.
    ON UPDATE CASCADE,      -- If SupplierID in Suppliers table changes, update it here.
  CONSTRAINT `fk_Products_Categories`
    FOREIGN KEY (`CategoryID`)
    REFERENCES `Categories` (`CategoryID`)
    ON DELETE SET NULL       -- If a category is deleted, keep the product but nullify its category.
    ON UPDATE CASCADE,      -- If CategoryID in Categories table changes, update it here.
  CONSTRAINT `chk_ProductPrice` CHECK (`Price` > 0))
ENGINE = InnoDB
COMMENT = 'Stores information about individual products.';

-- -----------------------------------------------------
-- Table `Inventory`
-- Tracks the current stock levels for each product.
-- This forms a 1-to-1 relationship with the Products table for current stock status.
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Inventory` (
  `ProductID` INT NOT NULL,
  `QuantityInStock` INT NOT NULL DEFAULT 0,
  `LastStockUpdate` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`ProductID`),
  CONSTRAINT `fk_Inventory_Products`
    FOREIGN KEY (`ProductID`)
    REFERENCES `Products` (`ProductID`)
    ON DELETE CASCADE        -- If a product is deleted, its inventory record is also deleted.
    ON UPDATE CASCADE,       -- If ProductID in Products table changes, update it here.
  CONSTRAINT `chk_QuantityInStock` CHECK (`QuantityInStock` >= 0))
ENGINE = InnoDB
COMMENT = 'Tracks the stock levels for each product.';

-- -----------------------------------------------------
-- Table `Customers`
-- Stores information about customers who purchase products.
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Customers` (
  `CustomerID` INT NOT NULL AUTO_INCREMENT,
  `CustomerName` VARCHAR(255) NOT NULL,
  `ContactName` VARCHAR(255) NULL,
  `Address` VARCHAR(255) NULL,
  `City` VARCHAR(100) NULL,
  `PostalCode` VARCHAR(20) NULL,
  `Country` VARCHAR(100) NULL,
  `Phone` VARCHAR(50) NULL,
  `Email` VARCHAR(255) NULL,
  PRIMARY KEY (`CustomerID`),
  UNIQUE INDEX `Email_UNIQUE` (`Email` ASC) VISIBLE,
  UNIQUE INDEX `Phone_UNIQUE` (`Phone` ASC) VISIBLE)
ENGINE = InnoDB
COMMENT = 'Stores customer information.';

-- -----------------------------------------------------
-- Table `Orders`
-- Stores records of customer orders.
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Orders` (
  `OrderID` INT NOT NULL AUTO_INCREMENT,
  `CustomerID` INT NULL,
  `OrderDate` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `RequiredDate` DATETIME NULL COMMENT 'Date by which the customer requires the order',
  `ShippedDate` DATETIME NULL COMMENT 'Actual date the order was shipped',
  `Status` VARCHAR(50) NOT NULL DEFAULT 'Pending' COMMENT 'e.g., Pending, Processing, Shipped, Delivered, Cancelled',
  `ShipAddress` VARCHAR(255) NULL,
  `ShipCity` VARCHAR(100) NULL,
  `ShipPostalCode` VARCHAR(20) NULL,
  `ShipCountry` VARCHAR(100) NULL,
  PRIMARY KEY (`OrderID`),
  INDEX `fk_Orders_Customers_idx` (`CustomerID` ASC) VISIBLE,
  CONSTRAINT `fk_Orders_Customers`
    FOREIGN KEY (`CustomerID`)
    REFERENCES `Customers` (`CustomerID`)
    ON DELETE SET NULL       -- If a customer is deleted, their orders remain but CustomerID becomes NULL.
    ON UPDATE CASCADE)      -- If CustomerID in Customers table changes, update it here.
ENGINE = InnoDB
COMMENT = 'Stores customer orders.';

-- -----------------------------------------------------
-- Table `OrderDetails`
-- Acts as a junction table for the M-M relationship between Orders and Products.
-- Stores line items for each order, detailing which products, in what quantity, and at what price.
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `OrderDetails` (
  `OrderDetailID` INT NOT NULL AUTO_INCREMENT,
  `OrderID` INT NOT NULL,
  `ProductID` INT NOT NULL,
  `UnitPrice` DECIMAL(10,2) NOT NULL COMMENT 'Price of the product at the time of the order. Can differ from current product price.',
  `Quantity` INT NOT NULL,
  `Discount` DECIMAL(3,2) NOT NULL DEFAULT 0.00 COMMENT 'Discount applied to this line item, e.g., 0.05 for 5%',
  PRIMARY KEY (`OrderDetailID`),
  INDEX `fk_OrderDetails_Orders_idx` (`OrderID` ASC) VISIBLE,
  INDEX `fk_OrderDetails_Products_idx` (`ProductID` ASC) VISIBLE,
  UNIQUE INDEX `uq_Order_Product` (`OrderID` ASC, `ProductID` ASC) VISIBLE COMMENT 'Ensures a product appears only once per order to avoid duplication.',
  CONSTRAINT `fk_OrderDetails_Orders`
    FOREIGN KEY (`OrderID`)
    REFERENCES `Orders` (`OrderID`)
    ON DELETE CASCADE        -- If an order is deleted, its details are also deleted.
    ON UPDATE CASCADE,
  CONSTRAINT `fk_OrderDetails_Products`
    FOREIGN KEY (`ProductID`)
    REFERENCES `Products` (`ProductID`)
    ON DELETE RESTRICT       -- Prevent deleting a product if it exists in any order details. Consider business logic for this.
    ON UPDATE CASCADE,
  CONSTRAINT `chk_OrderQuantity` CHECK (`Quantity` > 0),
  CONSTRAINT `chk_Discount` CHECK (`Discount` >= 0 AND `Discount` <= 1))
ENGINE = InnoDB
COMMENT = 'Stores line items for each order (M-M relationship between Orders and Products).';

-- -----------------------------------------------------
-- Restore original settings
-- -----------------------------------------------------
SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

-- End of Schema for Inventory Tracking System 