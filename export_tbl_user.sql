--------------------------------------------------------
--  파일이 생성됨 - 일요일-4월-05-2020   
--------------------------------------------------------
--------------------------------------------------------
--  DDL for Table TBL_USER
--------------------------------------------------------

  CREATE TABLE "ADMIN"."TBL_USER" 
   (	"U_ID" VARCHAR2(50 BYTE), 
	"U_PASSWORD" VARCHAR2(100 BYTE), 
	"U_NICKNAME" VARCHAR2(8 BYTE), 
	"U_GRADE" VARCHAR2(1 BYTE)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "SYSTEM" ;
REM INSERTING into ADMIN.TBL_USER
SET DEFINE OFF;
Insert into ADMIN.TBL_USER (U_ID,U_PASSWORD,U_NICKNAME,U_GRADE) values ('admin@yahoo.co.jp','$2a$10$KIhCvsRKB6EZdrbYmQKCyOZlovmLqb5XzdNXQCZMFVGofxGr885XS','admin','U');
Insert into ADMIN.TBL_USER (U_ID,U_PASSWORD,U_NICKNAME,U_GRADE) values ('admin2@gmail.com','$2a$10$mGLeuKh7Ybkj1GU/htDkN.rVYNj3whhuoBwRkWxHops0jpUSqTmXG','admin2','U');
--------------------------------------------------------
--  DDL for Index SYS_C007015
--------------------------------------------------------

  CREATE UNIQUE INDEX "ADMIN"."SYS_C007015" ON "ADMIN"."TBL_USER" ("U_ID") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "SYSTEM" ;
--------------------------------------------------------
--  DDL for Index SYS_C007029
--------------------------------------------------------

  CREATE UNIQUE INDEX "ADMIN"."SYS_C007029" ON "ADMIN"."TBL_USER" ("U_NICKNAME") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "SYSTEM" ;
--------------------------------------------------------
--  Constraints for Table TBL_USER
--------------------------------------------------------

  ALTER TABLE "ADMIN"."TBL_USER" ADD UNIQUE ("U_NICKNAME")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "SYSTEM"  ENABLE;
  ALTER TABLE "ADMIN"."TBL_USER" ADD PRIMARY KEY ("U_ID")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "SYSTEM"  ENABLE;
  ALTER TABLE "ADMIN"."TBL_USER" MODIFY ("U_NICKNAME" NOT NULL ENABLE);
  ALTER TABLE "ADMIN"."TBL_USER" MODIFY ("U_PASSWORD" NOT NULL ENABLE);
