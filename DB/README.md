# Inventory Tracking Database

## Description

This project contains a MySQL database schema for a comprehensive Inventory Tracking System. It's designed to manage:
*   Products and their details (name, price, unit)
*   Suppliers of these products
*   Categories to classify products
*   Current inventory stock levels for each product
*   Customer information
*   Customer orders, including specific products, quantities, and prices at the time of order.

The schema enforces data integrity using primary keys, foreign keys, `NOT NULL`, `UNIQUE`, and `CHECK` constraints. It also defines relationships such as one-to-one (Products-Inventory), one-to-many (e.g., Suppliers-Products, Customers-Orders), and many-to-many (Orders-Products via OrderDetails).

## How to Run/Setup the Project (Import SQL)

To use this database schema:

1.  **Prerequisites:**
    *   A running MySQL server instance.
    *   A MySQL client (e.g., MySQL Workbench, DBeaver, phpMyAdmin, or the `mysql` command-line tool).

2.  **Steps to Import:**
    *   **Create a Database:** If you don't have a specific database to import into, create one. For example:
        ```sql
        CREATE DATABASE inventory_db;
        ```
    *   **Select the Database:**
        ```sql
        USE inventory_db;
        ```
    *   **Import the SQL File:**
        *   **Using MySQL Workbench or similar GUI tools:**
            1.  Open the `inventory_tracking.sql` file.
            2.  Ensure you are connected to your MySQL server and have selected the target database (e.g., `inventory_db`).
            3.  Execute the entire script.
        *   **Using the `mysql` command-line tool:**
            Navigate to the directory containing `inventory_tracking.sql` and run:
            ```bash
            mysql -u your_username -p your_database_name < inventory_tracking.sql
            ```
            Replace `your_username` with your MySQL username and `your_database_name` with the name of the database you want to import the schema into (e.g., `inventory_db`). You will be prompted for your MySQL password.

## ERD (Entity Relationship Diagram)

Below is a textual description of the main entities and their relationships. You can generate a visual ERD using tools like MySQL Workbench (Database > Reverse Engineer) after importing the schema.

*   **Entities:**
    *   `Suppliers`: Stores information about product suppliers.
    *   `Categories`: Stores product categories.
    *   `Products`: Stores details of each product.
    *   `Inventory`: Tracks the current stock quantity for each product.
    *   `Customers`: Stores information about customers.
    *   `Orders`: Records customer orders.
    *   `OrderDetails`: A junction table linking `Orders` and `Products`, detailing each item in an order.

*   **Key Relationships:**
    *   **`Suppliers` to `Products`**: One-to-Many. A supplier can provide multiple products. `Products.SupplierID` is a foreign key referencing `Suppliers.SupplierID`.
    *   **`Categories` to `Products`**: One-to-Many. A category can include multiple products. `Products.CategoryID` is a foreign key referencing `Categories.CategoryID`.
    *   **`Products` to `Inventory`**: One-to-One. Each product has a corresponding inventory record tracking its stock. `Inventory.ProductID` is a primary key and a foreign key referencing `Products.ProductID`.
    *   **`Customers` to `Orders`**: One-to-Many. A customer can place multiple orders. `Orders.CustomerID` is a foreign key referencing `Customers.CustomerID`.
    *   **`Orders` to `OrderDetails`**: One-to-Many. An order can consist of multiple line items (products). `OrderDetails.OrderID` is a foreign key referencing `Orders.OrderID`.
    *   **`Products` to `OrderDetails`**: One-to-Many. A product can appear in multiple order line items. `OrderDetails.ProductID` is a foreign key referencing `Products.ProductID`.
    *   The `OrderDetails` table effectively creates a **Many-to-Many relationship between `Orders` and `Products`**.

