# 🛒 Olist E-Commerce Data Warehouse Project

## 📌 Project Overview
This project involves building a multi-tier (Medallion Architecture) Data Warehouse using the Olist Brazilian E-Commerce dataset. The goal is to transform raw, "dirty" transactional data into a high-performance **Star Schema** in the Gold layer for business intelligence and executive reporting.

---

## 🏗️ Data Architecture
The project follows the **Medallion Architecture**, ensuring data quality and lineage at every step:

![Architecture Diagram](docs\data_architecture.jpg)


### 🥉 Bronze Layer (Raw)
- Literal ingestion of CSV files  
- Data is stored **as-is** with no modifications  

### 🥈 Silver Layer (Cleaned)
- Deduplication of customers and sellers  
- Handling NULL values and correcting data types (casting strings to `DATETIME`)  
- **Data Repair:** Fixed "shifted" columns in the reviews table caused by delimiter collision  
- **Logic Alignment:** Corrected impossible date sequences (e.g., approval dates occurring after delivery)  

### 🥇 Gold Layer (Analytical)
- Transformed into a **Star Schema**  
- Centralized metrics into a `fact_sales` table  
- Provided English translations for product categories  

---

## 📚 Gold Layer Data Catalog

### 1. Fact Table: `gold.fact_sales`
Central table containing quantitative measures for every item sold.

| Column        | Data Type | Description                                      |
|---------------|-----------|--------------------------------------------------|
| order_id      | NVARCHAR  | Unique identifier for the order                  |
| product_id    | NVARCHAR  | FK to `dim_products`                             |
| customer_id   | NVARCHAR  | FK to `dim_customers`                            |
| seller_id     | NVARCHAR  | FK to `dim_sellers`                              |
| price         | DECIMAL   | Item sale price                                  |
| freight_value | DECIMAL   | Item shipping cost                               |
| order_status  | NVARCHAR  | Current status of the order                      |
| is_late       | NVARCHAR  | Flag indicating delivery performance             |

---

### 2. Dimension Tables
Contextual attributes for filtering and grouping.

- **`gold.dim_products`**  
  - Product IDs  
  - English category names  

- **`gold.dim_customers`**  
  - Unique list of customers  
  - Primary city and state  

- **`gold.dim_sellers`**  
  - List of sellers  
  - Headquarters location  

- **`gold.dim_date`**  
  - Specialized calendar table  
  - Supports analysis by:
    - Year  
    - Quarter  
    - Month  
    - Weekday  

---

## 🛠️ Technical Implementation

- **Environment:** SQL Server / Azure SQL Database  
- **Ingestion:** Stored Procedures (`silver.load_silver`) automate movement from Bronze to Silver  

### Cleaning Logic
- Used `CAST` to handle date conversion failures gracefully  
- Implemented `ROW_NUMBER() OVER (PARTITION BY ...)` to handle duplicate customer records  

---

## 📈 Key Insights Enabled

With this Star Schema, the warehouse can efficiently answer:

- **Revenue Trends:** Monthly growth in sales and freight costs  
- **Logistics Efficiency:** Identifying states with the highest frequency of late deliveries  
- **Product Performance:** Top-selling English categories by region  
- **Customer Behavior:** Weekend vs. Weekday purchasing patterns  
