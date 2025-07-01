CREATE TABLE PAYMENT (
    payment_id INT PRIMARY KEY,
    method TEXT,
    card_number VARCHAR(20),
    card_expiry VARCHAR(7)
);

CREATE TABLE DISCOUNT (
  discount_id INT PRIMARY KEY,
  code VARCHAR(20),
  percentage DECIMAL(5,2)
);

-- I assume here that payment can be rejected and therefore the payment_id can be NULL as well.
--
CREATE TABLE ORDER (
    order_id INT PRIMARY KEY,
    order_date DATE NOT NULL,
    customer_id INT NOT NULL,
    shipping_method VARCHAR(50),
    shipping_cost DECIMAL(10, 2),
    payment_id INT,
    discount_id INT,
    FOREIGN KEY C_FK_ORDER_CUSTOMER (customer_id) REFERENCES CUSTOMER(customer_id),
    FOREIGN KEY C_FK_ORDER_PAYMENT (payment_id) REFERENCES PAYMENT(payment_id),
    FOREIGN KEY C_FK_ORDER_DISCOUNT (discount_id) REFERENCES DISCOUNT(discount_id)
);

CREATE TABLE CUSTOMER (
  customer_id INT PRIMARY KEY,
  customer_name VARCHAR(100) NOT NULL,
  customer_email VARCHAR(100) NOT NULL,
  customer_address TEXT NOT NULL,
  customer_phone VARCHAR(32)
);

CREATE TABLE ORDER_HAS_BOOKS (
    id INT PRIMARY KEY,
    book_id INT NOT NULL,
    order_id INT NOT NULL,
    FOREIGN KEY C_FK_ORDER_HAS_BOOKS_BOOK (book_id) REFERENCES BOOK(book_id),
    FOREIGN KEY C_FK_ORDER_HAS_BOOKS_ORDER (order_id) REFERENCES ORDER(order_id)
    --PRIMARY KEY(book_id, order_id)
);

CREATE TABLE BOOK (
  book_id INT PRIMARY KEY,
  book_title TEXT NOT NULL,
  book_author TEXT NOT NULL,
  book_publisher TEXT,
  book_isbn TEXT NOT NULL,
  book_category TEXT,
  book_price DECIMAL(10, 2) NOT NULL,
  quantity INT NOT NULL
);
