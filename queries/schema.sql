-- ============================================================
--  SQL Revenue & Profitability Analysis Project
--  SCHEMA FILE — PostgreSQL Version (Advanced / Real-World)
-- ============================================================

-- ============================================================
--  DROP STATEMENTS (safe resets when re-running)
-- ============================================================

-- Drop tables first (order matters because of FK constraints)
DROP TABLE IF EXISTS order_items CASCADE;
DROP TABLE IF EXISTS orders CASCADE;
DROP TABLE IF EXISTS costs CASCADE;
DROP TABLE IF EXISTS products CASCADE;
DROP TABLE IF EXISTS product_categories CASCADE;
DROP TABLE IF EXISTS customers CASCADE;

-- Drop ENUM types (PostgreSQL needs this before recreating)
DROP TYPE IF EXISTS order_status_enum CASCADE;
DROP TYPE IF EXISTS payment_method_enum CASCADE;

-- ============================================================
--  ENUM TYPES
-- ============================================================

-- Order status options
CREATE TYPE order_status_enum AS ENUM (
    'placed',
    'shipped',
    'delivered',
    'returned',
    'cancelled'
);

-- Payment methods
CREATE TYPE payment_method_enum AS ENUM (
    'credit_card',
    'debit_card',
    'paypal',
    'gift_card'
);

-- ============================================================
--  CUSTOMERS
-- ============================================================
CREATE TABLE customers (
    customer_id        SERIAL PRIMARY KEY,
    first_name         VARCHAR(50) NOT NULL,
    last_name          VARCHAR(50) NOT NULL,
    email              VARCHAR(255) UNIQUE NOT NULL,
    signup_date        DATE NOT NULL DEFAULT CURRENT_DATE,
    region             VARCHAR(50) NOT NULL
);

CREATE INDEX idx_customers_region ON customers(region);

-- ============================================================
--  PRODUCT CATEGORIES
-- ============================================================
CREATE TABLE product_categories (
    category_id       SERIAL PRIMARY KEY,
    category_name     VARCHAR(100) NOT NULL
);

-- ============================================================
--  PRODUCTS
-- ============================================================
CREATE TABLE products (
    product_id        SERIAL PRIMARY KEY,
    product_name      VARCHAR(200) NOT NULL,
    category_id       INT NOT NULL,
    CONSTRAINT fk_products_category
        FOREIGN KEY (category_id)
        REFERENCES product_categories(category_id)
        ON DELETE CASCADE
);

CREATE INDEX idx_products_category ON products(category_id);

-- ============================================================
--  COSTS (unit cost per product)
-- ============================================================
CREATE TABLE costs (
    product_id        INT PRIMARY KEY,
    unit_cost         NUMERIC(10,2) NOT NULL CHECK (unit_cost >= 0),
    CONSTRAINT fk_costs_product
        FOREIGN KEY (product_id)
        REFERENCES products(product_id)
        ON DELETE CASCADE
);

-- ============================================================
--  ORDERS
-- ============================================================
CREATE TABLE orders (
    order_id          SERIAL PRIMARY KEY,
    customer_id       INT NOT NULL,
    order_date        TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    payment_method    payment_method_enum NOT NULL,
    order_status      order_status_enum NOT NULL DEFAULT 'placed',
    CONSTRAINT fk_orders_customer
        FOREIGN KEY (customer_id)
        REFERENCES customers(customer_id)
        ON DELETE CASCADE
);

CREATE INDEX idx_orders_order_date ON orders(order_date);
CREATE INDEX idx_orders_customer_id ON orders(customer_id);

-- ============================================================
--  ORDER ITEMS
-- ============================================================
CREATE TABLE order_items (
    order_item_id     SERIAL PRIMARY KEY,
    order_id          INT NOT NULL,
    product_id        INT NOT NULL,
    quantity          INT NOT NULL CHECK (quantity > 0),
    price             NUMERIC(10,2) NOT NULL CHECK (price >= 0),
    discount_amount   NUMERIC(10,2) DEFAULT 0 CHECK (discount_amount >= 0),

    CONSTRAINT fk_order_items_order
        FOREIGN KEY (order_id)
        REFERENCES orders(order_id)
        ON DELETE CASCADE,

    CONSTRAINT fk_order_items_product
        FOREIGN KEY (product_id)
        REFERENCES products(product_id)
        ON DELETE CASCADE
);

CREATE INDEX idx_order_items_order_id ON order_items(order_id);
CREATE INDEX idx_order_items_product_id ON order_items(product_id);

-- ============================================================
--  END OF SCHEMA
-- ============================================================
