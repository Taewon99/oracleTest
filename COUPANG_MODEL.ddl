-- 생성자 Oracle SQL Developer Data Modeler 24.3.0.275.2224
--   위치:        2024-11-08 17:19:49 KST
--   사이트:      Oracle Database 11g
--   유형:      Oracle Database 11g



-- predefined type, no DDL - MDSYS.SDO_GEOMETRY

-- predefined type, no DDL - XMLTYPE

CREATE TABLE customer (
    c_num  NUMBER(4) NOT NULL,
    c_name VARCHAR2(10 CHAR) NOT NULL,
    addr   VARCHAR2(50 CHAR) NOT NULL,
    tel    CHAR(13 CHAR) NOT NULL
);

ALTER TABLE customer ADD CONSTRAINT C_NUM_pk PRIMARY KEY ( c_num );
ALTER TABLE CUSTOMER ADD CONSTRAINT ADDR_UK unique(addr);

CREATE TABLE "ORDER" (
    o_num       NUMBER(4) NOT NULL,
    c_num       NUMBER(4) NOT NULL,
    p_num       NUMBER(4) NOT NULL,
    amount      NUMBER(4) NOT NULL,
    total_price NUMBER(10) NOT NULL
);

ALTER TABLE "ORDER" ADD CONSTRAINT O_NUM_pk PRIMARY KEY ( o_num );
ALTER TABLE "ORDER" MODIFY AMOUNT DEFAULT 1;

CREATE TABLE product (
    p_num  NUMBER(4) NOT NULL,
    p_name VARCHAR2(20 CHAR) NOT NULL,
    price  NUMBER(10) NOT NULL,
    stock  NUMBER(4) NOT NULL
);

ALTER TABLE product ADD CONSTRAINT p_NUM_pk PRIMARY KEY ( p_num );
ALTER TABLE PRODUCT MODIFY STOCK DEFAULT 0;


CREATE TABLE shipping (
    s_num         NUMBER(4) NOT NULL,
    o_num         NUMBER(4) NOT NULL,
    addr          VARCHAR2(50 CHAR) NOT NULL,
    shipping_date DATE NOT NULL
);

ALTER TABLE shipping ADD CONSTRAINT shipping_pk PRIMARY KEY ( s_num );

ALTER TABLE "ORDER"
    ADD CONSTRAINT order_customer_c_num_fk FOREIGN KEY ( c_num )
        REFERENCES customer ( c_num );

ALTER TABLE "ORDER"
    ADD CONSTRAINT order_product_p_num_fk FOREIGN KEY ( p_num )
        REFERENCES product ( p_num );

ALTER TABLE shipping
    ADD CONSTRAINT shipping_order_o_num_fk FOREIGN KEY ( o_num )
        REFERENCES "ORDER" ( o_num );

ALTER TABLE shipping
    ADD CONSTRAINT shipping_CUSTOMER_ADDR_fk FOREIGN KEY ( ADDR )
        REFERENCES "CUSTOMER" ( ADDR );

-- Oracle SQL Developer Data Modeler 요약 보고서: 
-- 
-- CREATE TABLE                             4
-- CREATE INDEX                             0
-- ALTER TABLE                              7
-- CREATE VIEW                              0
-- ALTER VIEW                               0
-- CREATE PACKAGE                           0
-- CREATE PACKAGE BODY                      0
-- CREATE PROCEDURE                         0
-- CREATE FUNCTION                          0
-- CREATE TRIGGER                           0
-- ALTER TRIGGER                            0
-- CREATE COLLECTION TYPE                   0
-- CREATE STRUCTURED TYPE                   0
-- CREATE STRUCTURED TYPE BODY              0
-- CREATE CLUSTER                           0
-- CREATE CONTEXT                           0
-- CREATE DATABASE                          0
-- CREATE DIMENSION                         0
-- CREATE DIRECTORY                         0
-- CREATE DISK GROUP                        0
-- CREATE ROLE                              0
-- CREATE ROLLBACK SEGMENT                  0
-- CREATE SEQUENCE                          0
-- CREATE MATERIALIZED VIEW                 0
-- CREATE MATERIALIZED VIEW LOG             0
-- CREATE SYNONYM                           0
-- CREATE TABLESPACE                        0
-- CREATE USER                              0
-- 
-- DROP TABLESPACE                          0
-- DROP DATABASE                            0
-- 
-- REDACTION POLICY                         0
-- 
-- ORDS DROP SCHEMA                         0
-- ORDS ENABLE SCHEMA                       0
-- ORDS ENABLE OBJECT                       0
-- 
-- ERRORS                                   0
-- WARNINGS                                 0
