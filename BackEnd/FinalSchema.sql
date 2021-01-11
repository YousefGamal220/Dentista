CREATE DATABASE DENTISTA;

USE DENTISTA;

CREATE TABLE MANAGER
(
  MANAGER_ID INT NOT NULL AUTO_INCREMENT,
  MANAGER_Fname VARCHAR(50) NOT NULL,
  MANAGER_Lname VARCHAR(50) NOT NULL,
  MANAGER_EMAIL VARCHAR(255) NOT NULL,
  MANAGER_PASSWORD VARCHAR(15) NOT NULL,
  MANAGEMENT_TYPE VARCHAR(15) NOT NULL,
  AREA_OF_MANAGEMENT VARCHAR(255) NOT NULL,
  MANAGER_IMAGE_URL VARCHAR(500),
  PRIMARY KEY (MANAGER_ID),
  UNIQUE (MANAGER_EMAIL)
);

CREATE TABLE STORE
(
  STORE_ID INT NOT NULL AUTO_INCREMENT,
  STORE_NAME VARCHAR(100) NOT NULL,
  EMAIL VARCHAR(255) NOT NULL,
  PASSWORD VARCHAR(15) NOT NULL,
  PHONE_NUMBER VARCHAR(15) NOT NULL,
  CREDIT_CARD_NUMBER VARCHAR(20) NOT NULL,
  PRIMARY KEY (STORE_ID),
  UNIQUE (EMAIL),
  UNIQUE (PHONE_NUMBER)
);

CREATE TABLE STORE_BRANCH
(
  STORE_ID INT NOT NULL,
  ADDRESS VARCHAR(255) NOT NULL,
  REGION VARCHAR(50) NOT NULL,
  CITY VARCHAR(50) NOT NULL,
  ZIP_CODE INT NOT NULL,
  MANAGER_ID INT ,
  FOREIGN KEY (STORE_ID) REFERENCES STORE(STORE_ID) ON DELETE CASCADE ON UPDATE CASCADE,
  FOREIGN KEY (MANAGER_ID) REFERENCES MANAGER(MANAGER_ID) ON DELETE RESTRICT ON UPDATE RESTRICT,
  UNIQUE (ADDRESS)
);

CREATE TABLE DENTIST
(
  DENTIST_ID INT NOT NULL AUTO_INCREMENT,
  DENTIST_Fname VARCHAR(50) NOT NULL,
  DENTIST_LNAME VARCHAR(50) NOT NULL,
  DENTIST_EMAIL VARCHAR(255) NOT NULL,
  DENTIST_PASSWORD VARCHAR(15) NOT NULL,
  DENTIST_PHONE_NUMBER VARCHAR(15) NOT NULL,
  DENTIST_ADDRESS VARCHAR(255) NOT NULL,
  DENTIST_ZIP_CODE INT NOT NULL,
  DENTIST_REGION VARCHAR(50) NOT NULL,
  DENTIST_CITY VARCHAR(50) NOT NULL,
  DENTIST_CREDIT_CARD_NUMBER VARCHAR(20) NOT NULL,
  DENTIST_IMAGE_URL VARCHAR(255),
  PRIMARY KEY (DENTIST_ID),
  UNIQUE (DENTIST_EMAIL),
  UNIQUE (DENTIST_PHONE_NUMBER)
);

CREATE TABLE DELIVERY
(
  DELIVERY_ID INT NOT NULL AUTO_INCREMENT,
  DELIVERY_Fname VARCHAR(50) NOT NULL,
  DELIVERY_Lname VARCHAR(50) NOT NULL,
  DELIVERY_EMAIL VARCHAR(255) NOT NULL,
  DELIVERY_PASSWORD VARCHAR(15) NOT NULL,
  DELIVERY_PHONE_NUMBER VARCHAR(15) NOT NULL,
  DELIVERY_CREDIT_CARD_NUMBER VARCHAR(20) NOT NULL,
  DELIVERY_IMAGE_URL VARCHAR(500),
  AREA VARCHAR(50) NOT NULL,
  VECHILE_LICENCE VARCHAR(50) NOT NULL,
  VECHILE_MODEL VARCHAR(50) NOT NULL,
  RATE INT,
  AVAILABLE INT NOT NULL,
  MANAGER_ID INT ,
  NUMBER_OF_DORDERS INT,
  PRIMARY KEY (DELIVERY_ID),
  FOREIGN KEY (MANAGER_ID) REFERENCES MANAGER(MANAGER_ID) ON DELETE RESTRICT ON UPDATE RESTRICT,
  UNIQUE (DELIVERY_EMAIL),
  UNIQUE (VECHILE_LICENCE),
  UNIQUE(DELIVERY_PHONE_NUMBER)
);

CREATE TABLE PRODUCT
(
  PRODUCT_ID INT NOT NULL AUTO_INCREMENT,
  PRODUCT_NAME VARCHAR(255) NOT NULL,
  PRICE INT NOT NULL,
  SELLING_PRICE INT NOT NULL,
  IMAGE_URL VARCHAR(255) ,
  NUMBER_OF_UNITS INT NOT NULL,
  STORE_ID INT NOT NULL,
  RATE INT,
  NO_OF_REVIEWERS INT,
  CATEGORY VARCHAR(255),
  Brand VARCHAR(255),
  DESCRIPTION VARCHAR(500),
  PRIMARY KEY (PRODUCT_ID),
  foreign key (STORE_ID) references STORE(STORE_ID) ON UPDATE CASCADE ON DELETE CASCADE
);


CREATE TABLE ORDERS
(
  ORDER_ID INT NOT NULL AUTO_INCREMENT,
  DENTIST_ID INT NOT NULL,
  DELIVERY_ID INT,
  TOTAL_COST INT NOT NULL,
  SHIPMENT_STATUS VARCHAR(50),
  ORDER_DATE DATE,
  PRIMARY KEY (ORDER_ID)
);

CREATE TABLE VIRTUAL_BANK
(
  CARD_NUMBER VARCHAR(20) NOT NULL,
  FIRST_NAME VARCHAR(50) NOT NULL,
  LAST_NAME VARCHAR(50) NOT NULL,
  EMAIL VARCHAR(255) NOT NULL,
  PASSWORD VARCHAR(15) NOT NULL,
  NATIONAL_ID VARCHAR(14) NOT NULL,
  SECURITY_CODE INT NOT NULL,
  EXPIRATION_MONTH INT NOT NULL,
  EXPIRATION_YEAR INT NOT NULL,
  CREDIT FLOAT NOT NULL,
  PRIMARY KEY (CARD_NUMBER),
  UNIQUE (EMAIL)
);

CREATE TABLE DELIVERY_VERIFICATION(
DELIVERY_VERIFICATION_ID INT AUTO_INCREMENT NOT NULL,
DELIVERY_ID INT NOT NULL,

PRIMARY KEY (DELIVERY_VERIFICATION_ID),

FOREIGN KEY (DELIVERY_ID) REFERENCES DELIVERY(DELIVERY_ID)
);

CREATE TABLE STORE_VERIFICATION(
STORE_VERIFICATION_ID INT AUTO_INCREMENT NOT NULL,
STORE_ID INT NOT NULL,
PRIMARY KEY (STORE_VERIFICATION_ID),

FOREIGN KEY (STORE_ID) REFERENCES STORE(STORE_ID)
);



CREATE TABLE ORDER_PRODUCT
(
  NUMBER_OF_UNITS INT NOT NULL,
  ORDER_ID INT NOT NULL,
  PRODUCT_ID INT NOT NULL,
  FOREIGN KEY (ORDER_ID) REFERENCES ORDERS(ORDER_ID) ON DELETE CASCADE ON UPDATE CASCADE,
  FOREIGN KEY (PRODUCT_ID) REFERENCES PRODUCT(PRODUCT_ID) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE DENTIST_DELIVERY_CHAT
(
  MESSAGES VARCHAR(255) NOT NULL,
  DENTIST_ID INT NOT NULL,
  DELIVERY_ID INT NOT NULL,
  SENDER_ID INT NOT NULL,
  SENDER_TYPE VARCHAR(30) NOT NULL,
  FOREIGN KEY (DENTIST_ID) REFERENCES DENTIST(DENTIST_ID) ON DELETE CASCADE ON UPDATE CASCADE,
  FOREIGN KEY (DELIVERY_ID) REFERENCES DELIVERY(DELIVERY_ID) ON DELETE CASCADE ON UPDATE CASCADE
);


CREATE TABLE MANAGER_STORE_CHAT
(
  MESSAGES VARCHAR(255) NOT NULL,
  MANAGER_ID INT NOT NULL,
  STORE_ID INT NOT NULL,
  SENDER_ID INT NOT NULL,
  SENDER_TYPE VARCHAR(30) NOT NULL,
  FOREIGN KEY (MANAGER_ID) REFERENCES MANAGER(MANAGER_ID) ON DELETE CASCADE ON UPDATE CASCADE,
  FOREIGN KEY (STORE_ID) REFERENCES STORE(STORE_ID) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE MANAGER_DELIVERY_CHAT
(
  MESSAGES VARCHAR(255) NOT NULL,
  MANAGER_ID INT NOT NULL,
  DELIVERY_ID INT NOT NULL,
  SENDER_ID INT NOT NULL,
  SENDER_TYPE VARCHAR(30) NOT NULL,
  FOREIGN KEY (MANAGER_ID) REFERENCES MANAGER(MANAGER_ID) ON DELETE CASCADE ON UPDATE CASCADE,
  FOREIGN KEY (DELIVERY_ID) REFERENCES DELIVERY(DELIVERY_ID) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE STORE_DELIVERY_CHAT
(
  MESSAGES VARCHAR(255) NOT NULL,
  STORE_ID INT NOT NULL,
  DELIVERY_ID INT NOT NULL,
  SENDER_ID INT NOT NULL,
  SENDER_TYPE VARCHAR(30) NOT NULL,
  FOREIGN KEY (STORE_ID) REFERENCES STORE(STORE_ID) ON DELETE CASCADE ON UPDATE CASCADE,
  FOREIGN KEY (DELIVERY_ID) REFERENCES DELIVERY(DELIVERY_ID) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE DENTIST_STORE_CHAT
(
  MESSAGES VARCHAR(255) NOT NULL,
  DENTIST_ID INT NOT NULL,
  STORE_ID INT NOT NULL,
  SENDER_ID INT NOT NULL,
  FOREIGN KEY (DENTIST_ID) REFERENCES DENTIST(DENTIST_ID) ON DELETE CASCADE  ON UPDATE CASCADE,
  FOREIGN KEY (STORE_ID) REFERENCES STORE(STORE_ID) ON DELETE CASCADE ON UPDATE CASCADE
);



CREATE TABLE REVIEW_DELIVERY(
REVIEW_ID INT AUTO_INCREMENT NOT NULL,
DENTIST_ID INT NOT NULL,
DELIVERY_ID INT NOT NULL,
REVIEW VARCHAR(500) NOT NULL,
PRIMARY KEY (REVIEW_ID),
FOREIGN KEY (DENTIST_ID) REFERENCES DENTIST(DENTIST_ID) ON DELETE CASCADE ON UPDATE CASCADE,
FOREIGN KEY (DELIVERY_ID) REFERENCES DELIVERY(DELIVERY_ID) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE GIFT_CARDS(
GIFT_CARD_ID INT AUTO_INCREMENT NOT NULL,
GIFT_CARD_NAME VARCHAR(100) NOT NULL,
DISCOUNT FLOAT,
CARD_PRICE FLOAT,
TOTAL_TIMES_USES INT,
PRIMARY KEY (GIFT_CARD_ID)
);

CREATE TABLE HAS_GIFT_CARD(
DENTIST_ID INT NOT NULL,
GIFT_CARD_ID INT NOT NULL,
EXPIRATION_DATE DATE NOT NULL,
REMAINING_USES INT,
FOREIGN KEY (DENTIST_ID) REFERENCES DENTIST(DENTIST_ID) ON DELETE CASCADE ON UPDATE CASCADE,
FOREIGN KEY (GIFT_CARD_ID) REFERENCES GIFT_CARDS(GIFT_CARD_ID) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE GIFT_PRODUCTS(
GIFT_CARD_ID INT NOT NULL,
PRODUCT_ID INT NOT NULL, 
FOREIGN KEY (PRODUCT_ID) REFERENCES PRODUCT(PRODUCT_ID) ON DELETE CASCADE ON UPDATE CASCADE,
FOREIGN KEY (GIFT_CARD_ID) REFERENCES GIFT_CARDS(GIFT_CARD_ID) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE OFFERS(
OFFER_ID INT AUTO_INCREMENT NOT NULL,
PRODUCT_ID INT NOT NULL,
DISCOUNT INT NOT NULL,
PRIMARY KEY(OFFER_ID),
FOREIGN KEY (PRODUCT_ID) REFERENCES PRODUCT(PRODUCT_ID) ON DELETE CASCADE ON UPDATE CASCADE
);



CREATE TABLE SCEDULE_ORDER(
SCEDULE_ORDER_ID INT AUTO_INCREMENT NOT NULL,
DENTIST_ID INT NOT NULL,
ORDER_ID INT NOT NULL, 
DURATION VARCHAR(20) NOT NULL,
PRIMARY KEY (SCEDULE_ORDER_ID),
FOREIGN KEY (DENTIST_ID) REFERENCES DENTIST(DENTIST_ID) ON DELETE CASCADE ON UPDATE CASCADE,
FOREIGN KEY (ORDER_ID) REFERENCES ORDERS(ORDER_ID) ON DELETE CASCADE ON UPDATE CASCADE
);



CREATE OR REPLACE VIEW LOGIN_DATA(Email, Password, AccountType) AS SELECT DENTIST_EMAIL , DENTIST_PASSWORD, "Dentist"  FROM DENTIST DENT 
union ALL 
SELECT EMAIL, PASSWORD, "Store" FROM STORE ST
UNION ALL
SELECT MANAGER_EMAIL, MANAGER_PASSWORD, "Manager" FROM MANAGER MNG 
UNION ALL
SELECT DELIVERY_EMAIL, DELIVERY_PASSWORD, "Delivery" FROM DELIVERY DLV;

CREATE TABLE DentistCart(
DENTIST_ID INT NOT NULL,
PRODUCT_ID INT NOT NULL,
Number_Units INT,
foreign key (DENTIST_ID) references DENTIST(DENTIST_ID) ON delete cascade ON update Cascade,
foreign key (PRODUCT_ID) references PRODUCT(Product_ID) ON delete cascade ON update Cascade
);


CREATE TABLE DENTIST_COMMENT(
COMMENT_ID INT NOT NULL PRIMARY KEY auto_increment,
DENTIST_ID INT NOT NULL,
PRODUCT_ID INT NOT NULL, 
COMMENT_CONTEXT LONGTEXT NOT NULL,
COMMENT_TIME datetime,
LIKES INT,
foreign key(PRODUCT_ID) references PRODUCT(PRODUCT_ID) ON UPDATE CASCADE ON DELETE CASCADE,
foreign key(DENTIST_ID) references DENTIST(DENTIST_ID) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE DENTIST_LIKES(
DENTIST_ID INT NOT NULL,
COMMENT_ID INT NOT NULL,
FOREIGN KEY(DENTIST_ID) references DENTIST(DENTIST_ID) ON UPDATE CASCADE ON DELETE CASCADE,
FOREIGN KEY(COMMENT_ID) references DENTIST_COMMENT(COMMENT_ID) ON UPDATE CASCADE ON DELETE CASCADE
);