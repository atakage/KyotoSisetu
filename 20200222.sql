CREATE TABLE tbl_user(

    u_id VARCHAR2(50) PRIMARY KEY,
    u_password VARCHAR2(20) NOT NULL,
    u_nickname VARCHAR2(8) NOT NULL,
    u_grade VARCHAR2(1)


);


CREATE TABLE tbl_comment(

    u_id VARCHAR2(50) PRIMARY KEY,
    c_number NUMBER(4) NOT NULL,
    c_f_id VARCHAR2(20) NOT NULL,
    c_text VARCHAR2(1000),

    CONSTRAINTS fk_comment FOREIGN KEY(u_id) REFERENCES tbl_user(u_id) ON DELETE CASCADE

);



CREATE SEQUENCE seq_comment START WITH 1 INCREMENT BY 1; 

