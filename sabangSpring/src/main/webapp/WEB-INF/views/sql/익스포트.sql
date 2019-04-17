--------------------------------------------------------
--  ������ ������ - ������-4��-17-2019   
--------------------------------------------------------
DROP TABLE "BOARD" cascade constraints;
DROP TABLE "HOUSE_INFO" cascade constraints;
DROP TABLE "HOUSE_OPTION" cascade constraints;
DROP TABLE "HOUSE_PRICE" cascade constraints;
DROP TABLE "MEMBER" cascade constraints;
DROP TABLE "RCNLIST" cascade constraints;
DROP TABLE "WDMBR" cascade constraints;
DROP TABLE "WISHLIST" cascade constraints;
DROP SEQUENCE "MYQUE_SEQ";
--------------------------------------------------------
--  DDL for Table BOARD
--------------------------------------------------------

  CREATE TABLE "BOARD" 
   (	"PCODE" VARCHAR2(4 BYTE), 
	"HCODE" VARCHAR2(6 BYTE), 
	"PDATE" DATE DEFAULT SYSDATE, 
	"PPWD" VARCHAR2(4 BYTE), 
	"USERID" VARCHAR2(10 BYTE), 
	"TITLE" VARCHAR2(30 BYTE), 
	"CONTENT" VARCHAR2(4000 BYTE), 
	"FILENAME" VARCHAR2(200 BYTE)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS" ;
--------------------------------------------------------
--  DDL for Table HOUSE_INFO
--------------------------------------------------------

  CREATE TABLE "HOUSE_INFO" 
   (	"HCODE" VARCHAR2(6 BYTE), 
	"HTYPE" VARCHAR2(20 BYTE), 
	"RTYPE" VARCHAR2(4 BYTE), 
	"HNAME" VARCHAR2(100 BYTE), 
	"ADDR" VARCHAR2(500 BYTE), 
	"COORDX" VARCHAR2(30 BYTE), 
	"COORDY" VARCHAR2(30 BYTE), 
	"AREA" VARCHAR2(20 BYTE), 
	"WHLFLR" NUMBER(4,0), 
	"FLR" NUMBER(2,0), 
	"ROOM" VARCHAR2(2 BYTE), 
	"BATR" VARCHAR2(2 BYTE), 
	"CNTWISH" NUMBER(4,0) DEFAULT 0, 
	"HIMAGE" VARCHAR2(80 BYTE), 
	"HETC" VARCHAR2(500 BYTE), 
	"REGISTERDATE" DATE DEFAULT sysdate, 
	"AGNTID" VARCHAR2(10 BYTE), 
	"CLOSED" CHAR(1 BYTE) DEFAULT 'N', 
	"CLOSEDDATE" DATE DEFAULT sysdate
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS" ;
--------------------------------------------------------
--  DDL for Table HOUSE_OPTION
--------------------------------------------------------

  CREATE TABLE "HOUSE_OPTION" 
   (	"HCODE" VARCHAR2(20 BYTE), 
	"BLTIN" CHAR(1 BYTE) DEFAULT 'N', 
	"ELEV" CHAR(1 BYTE) DEFAULT 'N', 
	"PET" CHAR(1 BYTE) DEFAULT 'N', 
	"VRD" CHAR(1 BYTE) DEFAULT 'N', 
	"LOAN" CHAR(1 BYTE) DEFAULT 'N', 
	"PARK" CHAR(1 BYTE) DEFAULT 'N', 
	"MDATE" CHAR(1 BYTE) DEFAULT 'N', 
	"ETC" VARCHAR2(500 BYTE)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS" ;
--------------------------------------------------------
--  DDL for Table HOUSE_PRICE
--------------------------------------------------------

  CREATE TABLE "HOUSE_PRICE" 
   (	"HCODE" VARCHAR2(20 BYTE), 
	"DEPOSIT" NUMBER(6,0), 
	"MRENT" NUMBER(3,0), 
	"YRENT" NUMBER(6,0), 
	"MAINTC" NUMBER(2,0), 
	"PARKF" NUMBER(4,1)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS" ;
--------------------------------------------------------
--  DDL for Table MEMBER
--------------------------------------------------------

  CREATE TABLE "MEMBER" 
   (	"USERID" VARCHAR2(10 BYTE), 
	"PASSWD" VARCHAR2(20 BYTE), 
	"SSN" VARCHAR2(14 BYTE), 
	"USERNAME" VARCHAR2(10 BYTE), 
	"POST" VARCHAR2(6 BYTE), 
	"ADDR" VARCHAR2(500 BYTE), 
	"PHONE" VARCHAR2(11 BYTE), 
	"EMAIL" VARCHAR2(50 BYTE), 
	"AGENT" CHAR(1 BYTE) DEFAULT 'N'
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS" ;
--------------------------------------------------------
--  DDL for Table RCNLIST
--------------------------------------------------------

  CREATE TABLE "RCNLIST" 
   (	"NUM" NUMBER(15,0), 
	"USERID" VARCHAR2(20 BYTE), 
	"HCODE" VARCHAR2(20 BYTE)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS" ;
--------------------------------------------------------
--  DDL for Table WDMBR
--------------------------------------------------------

  CREATE TABLE "WDMBR" 
   (	"USERID" VARCHAR2(10 BYTE), 
	"DROPTIME" DATE DEFAULT SYSDATE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS" ;
--------------------------------------------------------
--  DDL for Table WISHLIST
--------------------------------------------------------

  CREATE TABLE "WISHLIST" 
   (	"USERID" VARCHAR2(10 BYTE), 
	"HCODE" VARCHAR2(6 BYTE)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS" ;
--------------------------------------------------------
--  DDL for Sequence MYQUE_SEQ
--------------------------------------------------------

   CREATE SEQUENCE  "MYQUE_SEQ"  MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 1 CACHE 20 NOORDER  NOCYCLE ;
REM INSERTING into BOARD
SET DEFINE OFF;
Insert into BOARD (PCODE,HCODE,PDATE,PPWD,USERID,TITLE,CONTENT,FILENAME) values ('H006','F001',to_date('19/02/25','RR/MM/DD'),'3333','agent','������ ������ ������','������ ������ ����ͽ��ϴ�',null);
Insert into BOARD (PCODE,HCODE,PDATE,PPWD,USERID,TITLE,CONTENT,FILENAME) values ('H008','F002',to_date('19/02/25','RR/MM/DD'),'9999','JELLY','���ǵ帳�ϴ�','�ڵ��� ��ȣ�� ������Ź�帳�ϴ�',null);
Insert into BOARD (PCODE,HCODE,PDATE,PPWD,USERID,TITLE,CONTENT,FILENAME) values ('H013','T004',to_date('19/02/25','RR/MM/DD'),'6666','aaaas','���� ���� ���ǵ����','�̹��� ����� ����������',null);
Insert into BOARD (PCODE,HCODE,PDATE,PPWD,USERID,TITLE,CONTENT,FILENAME) values ('H014','T005',to_date('19/02/26','RR/MM/DD'),'8888','pts','�����߰��� ��ȣ�� ���� ��ȣ','���� ��ȣ��׿� ������Ʈ���ּ���..',null);
Insert into BOARD (PCODE,HCODE,PDATE,PPWD,USERID,TITLE,CONTENT,FILENAME) values ('H015','T003',to_date('19/03/26','RR/MM/DD'),'6666','sssss','�̹����� �ȶߴµ���','���� ��Ź�帳�ϴ�.',null);
Insert into BOARD (PCODE,HCODE,PDATE,PPWD,USERID,TITLE,CONTENT,FILENAME) values ('H012','O001',to_date('19/03/26','RR/MM/DD'),'1111','sssss','���ֳ�¥�� ���Ƿ� �Ǿ��ֳ׿�','���� ��¥�� ���� ���ǵ����. ���� ��Ź�帳�ϴ�',null);
REM INSERTING into HOUSE_INFO
SET DEFINE OFF;
Insert into HOUSE_INFO (HCODE,HTYPE,RTYPE,HNAME,ADDR,COORDX,COORDY,AREA,WHLFLR,FLR,ROOM,BATR,CNTWISH,HIMAGE,HETC,REGISTERDATE,AGNTID,CLOSED,CLOSEDDATE) values ('P004','p','����','���� �� ����  ���� ���� �ֻ��� ����Ʈ','����Ư���� ���빮�� ����','37.563767002879196','126.93272227930592','32.34��',15,11,'2','1',0,'pimage4','������ ���� 5�аŸ��� ��ġ�� ������ ����Ʈ ���� ���̳��Ծ��.',to_date('19/02/06','RR/MM/DD'),'agent','Y',to_date('19/04/17','RR/MM/DD'));
Insert into HOUSE_INFO (HCODE,HTYPE,RTYPE,HNAME,ADDR,COORDX,COORDY,AREA,WHLFLR,FLR,ROOM,BATR,CNTWISH,HIMAGE,HETC,REGISTERDATE,AGNTID,CLOSED,CLOSEDDATE) values ('O001','o','����','������ �ְ� Ǯ �ɼ� ����','����� ���빮�� âõ��','37.55865382332561','126.93427968164825','19.83m��',4,2,'1','1',32,'oimage1','�α����ǽü� Ȯ�� �����ϴ�. ���ð� ���Կ� ��ġ�ϰ� �־�� :)',to_date('19/02/01','RR/MM/DD'),'agent','Y',to_date('19/04/17','RR/MM/DD'));
Insert into HOUSE_INFO (HCODE,HTYPE,RTYPE,HNAME,ADDR,COORDX,COORDY,AREA,WHLFLR,FLR,ROOM,BATR,CNTWISH,HIMAGE,HETC,REGISTERDATE,AGNTID,CLOSED,CLOSEDDATE) values ('O002','o','����','���� �α� ����� �ǹ�','����� ���빮�� ����','37.564022444565694','126.93195238268775','16.53m��',3,2,'1','1',3,'oimage2','���� ����� ����� ��! ������ ������ �Ź��� ã�� �����ΰ� ���л����� �ȼ�����!',to_date('19/03/21','RR/MM/DD'),'agent','Y',to_date('19/04/17','RR/MM/DD'));
Insert into HOUSE_INFO (HCODE,HTYPE,RTYPE,HNAME,ADDR,COORDX,COORDY,AREA,WHLFLR,FLR,ROOM,BATR,CNTWISH,HIMAGE,HETC,REGISTERDATE,AGNTID,CLOSED,CLOSEDDATE) values ('O003','o','����','�������ִ� ���� ��ž','����� ���빮�� ����','37.56450906563715','126.93209681948031','33.06m��',4,3,'1','1',8,'oimage3','���� ���� ������� ���� Ȱ�뵵 �ְ�, Ǯ�ɼ� ������ ��',to_date('19/03/20','RR/MM/DD'),'agent2','N',null);
Insert into HOUSE_INFO (HCODE,HTYPE,RTYPE,HNAME,ADDR,COORDX,COORDY,AREA,WHLFLR,FLR,ROOM,BATR,CNTWISH,HIMAGE,HETC,REGISTERDATE,AGNTID,CLOSED,CLOSEDDATE) values ('O004','o','����','�ܳ��� ����� ���ߺ���','����� ���빮�� âõ��','37.5588707736284','126.93556972620135','23.14m��',7,3,'1','1',2,'oimage4','���Ÿ� ��ó! ���ǽü� ��� ���� ��Ȱ�ϼ���. ���ߺ������� �����ؿ�e',to_date('19/02/11','RR/MM/DD'),'agent','N',null);
Insert into HOUSE_INFO (HCODE,HTYPE,RTYPE,HNAME,ADDR,COORDX,COORDY,AREA,WHLFLR,FLR,ROOM,BATR,CNTWISH,HIMAGE,HETC,REGISTERDATE,AGNTID,CLOSED,CLOSEDDATE) values ('O005','o','����','Ư����õ ä��¯ �����ν�','����� ���빮�� ��ŵ�','37.564800437357626','126.94487315886799','19.83m��',5,2,'1','1',2,'oimage5','1���� ���� �ֽ��ϴ� ������ ������ �ְ�����. �α� ¯ �Ź� ���θ����� :)',to_date('19/02/03','RR/MM/DD'),'agent2','N',null);
Insert into HOUSE_INFO (HCODE,HTYPE,RTYPE,HNAME,ADDR,COORDX,COORDY,AREA,WHLFLR,FLR,ROOM,BATR,CNTWISH,HIMAGE,HETC,REGISTERDATE,AGNTID,CLOSED,CLOSEDDATE) values ('T001','t','����','���̿� ����5�� ����� ����','����� ���빮�� âõ��','37.55860019936876','126.93506744837961','46.28m��',6,4,'2','1',0,'timage1','���̿� ����5�аŸ� ���ð������̸� ��ũ��,������α�ü�Ͽ� ����մϴ�.',to_date('19/02/03','RR/MM/DD'),'agent3','N',null);
Insert into HOUSE_INFO (HCODE,HTYPE,RTYPE,HNAME,ADDR,COORDX,COORDY,AREA,WHLFLR,FLR,ROOM,BATR,CNTWISH,HIMAGE,HETC,REGISTERDATE,AGNTID,CLOSED,CLOSEDDATE) values ('T002','t','����','���� ���� ������ 5�аŸ� ������ ���� ����','����� ���빮�� âõ��','37.5590685728757','126.93480446707945','49.58m��',4,1,'2','1',8,'timage2','ä�� �ʹ� ���ƿ�~ ���ð� �������� �㿡�� �����ؿ�.',to_date('19/03/25','RR/MM/DD'),'agent','Y',to_date('19/04/17','RR/MM/DD'));
Insert into HOUSE_INFO (HCODE,HTYPE,RTYPE,HNAME,ADDR,COORDX,COORDY,AREA,WHLFLR,FLR,ROOM,BATR,CNTWISH,HIMAGE,HETC,REGISTERDATE,AGNTID,CLOSED,CLOSEDDATE) values ('T003','t','����','���̿� ������ ���� 5�� ������','����� ���빮�� âõ��','37.55927684119469','126.93343708170717','72.72m��',5,5,'3','1',0,'timage3','�������ø� ����� �����ϴ�.�����ּ���',to_date('19/02/26','RR/MM/DD'),'agent','N',null);
Insert into HOUSE_INFO (HCODE,HTYPE,RTYPE,HNAME,ADDR,COORDX,COORDY,AREA,WHLFLR,FLR,ROOM,BATR,CNTWISH,HIMAGE,HETC,REGISTERDATE,AGNTID,CLOSED,CLOSEDDATE) values ('T004','t','����','������ �Ĺ� �α� �ü��� Ǯ�ɼ� ������','����� ������ ���ﵿ','37.55498893879162','126.94186094076593','66.11m��',3,2,'3','1',0,'timage4','��κ����� �����ϸ� Ǯ�ɼ� �ü����� ���� ���ø� �˴ϴ�',to_date('19/02/26','RR/MM/DD'),'agent3','N',null);
Insert into HOUSE_INFO (HCODE,HTYPE,RTYPE,HNAME,ADDR,COORDX,COORDY,AREA,WHLFLR,FLR,ROOM,BATR,CNTWISH,HIMAGE,HETC,REGISTERDATE,AGNTID,CLOSED,CLOSEDDATE) values ('T005','t','����','��ġ �����ִ� ������ ����','����� ������ ������','37.555675951770816','126.94663633678059','46.28m��',5,4,'1','1',0,'timage5','����� �ߵǾ��־ �����е鿡�Ե� ��õ! ��Ʈ�� �������� �ÿ��ÿ��� ����!^^',to_date('19/01/15','RR/MM/DD'),'agent','Y',to_date('19/04/17','RR/MM/DD'));
Insert into HOUSE_INFO (HCODE,HTYPE,RTYPE,HNAME,ADDR,COORDX,COORDY,AREA,WHLFLR,FLR,ROOM,BATR,CNTWISH,HIMAGE,HETC,REGISTERDATE,AGNTID,CLOSED,CLOSEDDATE) values ('F001','f','����','���̿� ���α� �ֺ� ��å�ο� ���δ��� ���� ��','����Ư���� ������ ���굿','37.55544536289714','126.93931192255577','13.52��',11,15,'1','1',0,'fimage1','����� �ߵǾ��־ �����е鿡�Ե� ��õ! ��Ʈ�� �������� �ÿ��ÿ��� ����!^^',to_date('19/02/26','RR/MM/DD'),'agent3','N',null);
Insert into HOUSE_INFO (HCODE,HTYPE,RTYPE,HNAME,ADDR,COORDX,COORDY,AREA,WHLFLR,FLR,ROOM,BATR,CNTWISH,HIMAGE,HETC,REGISTERDATE,AGNTID,CLOSED,CLOSEDDATE) values ('F002','f','����','���̴�� ���� ���ǽ��� �������� ���ɼ� ���� ��','����Ư���� ������ ���굿','37.55522967243774','126.94038950455885','19.99��',13,4,'1','1',0,'fimage2','��󸶿� ���ù��� ������ �����ϰ� ���뵵 ���� ���� ��',to_date('19/01/08','RR/MM/DD'),'agent','Y',to_date('19/04/17','RR/MM/DD'));
Insert into HOUSE_INFO (HCODE,HTYPE,RTYPE,HNAME,ADDR,COORDX,COORDY,AREA,WHLFLR,FLR,ROOM,BATR,CNTWISH,HIMAGE,HETC,REGISTERDATE,AGNTID,CLOSED,CLOSEDDATE) values ('F003','f','����','?�ٴ� ��ü, Ǯ�ɼ�  ����,�̴�,������ ����� ���ǽ���?','����Ư���� ������ ���굿','37.55497398302118','126.93397961072301','31.41��',15,9,'1','1',0,'fimage3','���̿�1�аŸ�, ��ġ �ְ� ���� ��',to_date('19/02/02','RR/MM/DD'),'agent3','N',null);
Insert into HOUSE_INFO (HCODE,HTYPE,RTYPE,HNAME,ADDR,COORDX,COORDY,AREA,WHLFLR,FLR,ROOM,BATR,CNTWISH,HIMAGE,HETC,REGISTERDATE,AGNTID,CLOSED,CLOSEDDATE) values ('F004','f','����','���̿� �ٷξ�.��κ� ���ǽ���','����Ư���� ���빮�� âõ��','37.5562057974519','126.93929772492868','26.67��',15,10,'1','1',0,'fimage4','����� ���ǽ���..�л��̳� ������ �����Ͻô� ���ǿ���.3',to_date('19/02/15','RR/MM/DD'),'agent','N',null);
Insert into HOUSE_INFO (HCODE,HTYPE,RTYPE,HNAME,ADDR,COORDX,COORDY,AREA,WHLFLR,FLR,ROOM,BATR,CNTWISH,HIMAGE,HETC,REGISTERDATE,AGNTID,CLOSED,CLOSEDDATE) values ('F005','f','����','�Ľ��̿� ����2��, ��κ�, ������ ����, ��Ʈ��, ����������','����Ư���� ������ ���굿','37.55605167068116','126.94096377501103','19.53�� ',14,10,'1','1',0,'fimage5','��2ȣ��(���̿�), ���Ǽ�(������), �Ű��׼�(ȫ�뿪)�� Ʈ���ÿ�����',to_date('19/02/15','RR/MM/DD'),'agent3','N',null);
Insert into HOUSE_INFO (HCODE,HTYPE,RTYPE,HNAME,ADDR,COORDX,COORDY,AREA,WHLFLR,FLR,ROOM,BATR,CNTWISH,HIMAGE,HETC,REGISTERDATE,AGNTID,CLOSED,CLOSEDDATE) values ('P001','p','����','��ũ������ѹ�/��1�� �и���/���������ֻ��վ���Ʈ/����������','����Ư���� ������ ���굿','37.55569169876663','126.94182417920896','38.02�� ',19,8,'1','1',0,'pimage1','���� �ʿ����ǿ� �ִ� �ֻ��վ���Ʈ�Դϴ�.',to_date('19/03/17','RR/MM/DD'),'agent','N',null);
Insert into HOUSE_INFO (HCODE,HTYPE,RTYPE,HNAME,ADDR,COORDX,COORDY,AREA,WHLFLR,FLR,ROOM,BATR,CNTWISH,HIMAGE,HETC,REGISTERDATE,AGNTID,CLOSED,CLOSEDDATE) values ('P003','p','����','������ ���� 3�аŸ� Ǯ �ɼ� ����Ʈ. ������ ���� ��','����Ư���� ���빮�� ����','37.564106044648376','126.93319282998453','34.64��  ',19,15,'2','1',4,'pimage3','������ 3 �� �Ÿ� Ǯ �ɼ� ����Ʈ ��2�� ������ ���� �� ����. �̴� ȫ��. ���� ��ȭ��. ������� ���� �ٱ�',to_date('19/03/19','RR/MM/DD'),'agent','N',null);
Insert into HOUSE_INFO (HCODE,HTYPE,RTYPE,HNAME,ADDR,COORDX,COORDY,AREA,WHLFLR,FLR,ROOM,BATR,CNTWISH,HIMAGE,HETC,REGISTERDATE,AGNTID,CLOSED,CLOSEDDATE) values ('P005','p','����','�ü��� ������� ȫ���Ա� �����濷','����Ư���� ������ ������','37.55721705032405','126.93012512025646','59.85�� ',14,10,'3','1',0,'pimage5','�ʿ�����, ȫ���Ա� ���� 5�аŸ�, ȫ�� �ɾ 10�аŸ�',to_date('19/02/10','RR/MM/DD'),'agent2','N',null);
REM INSERTING into HOUSE_OPTION
SET DEFINE OFF;
Insert into HOUSE_OPTION (HCODE,BLTIN,ELEV,PET,VRD,LOAN,PARK,MDATE,ETC) values ('P004','N','Y','N','N','N','Y','N','������, ��Ź��, �����, �Ź���, ����������, ����, ���ڵ����');
Insert into HOUSE_OPTION (HCODE,BLTIN,ELEV,PET,VRD,LOAN,PARK,MDATE,ETC) values ('P003','N','Y','N','N','N','Y','N','������, ��Ź��, å��, ����������, ����, ���ڵ����, �Ź���');
Insert into HOUSE_OPTION (HCODE,BLTIN,ELEV,PET,VRD,LOAN,PARK,MDATE,ETC) values ('O001','Y','N','Y','N','Y','N','N','������, �����, ��Ź��, �δ���, ���ڷ�����, ħ��, ����, ��ũ��');
Insert into HOUSE_OPTION (HCODE,BLTIN,ELEV,PET,VRD,LOAN,PARK,MDATE,ETC) values ('O002','N','N','N','N','N','N','N','������, �����, ��Ź��, �δ���, ħ��');
Insert into HOUSE_OPTION (HCODE,BLTIN,ELEV,PET,VRD,LOAN,PARK,MDATE,ETC) values ('O003','Y','N','N','N','N','N','N','������, �����, ��Ź��, �δ���');
Insert into HOUSE_OPTION (HCODE,BLTIN,ELEV,PET,VRD,LOAN,PARK,MDATE,ETC) values ('O004','N','Y','N','N','N','N','N','������, �����, ��Ź��, �δ���, å��, ����, �Ź���, ��ũ��');
Insert into HOUSE_OPTION (HCODE,BLTIN,ELEV,PET,VRD,LOAN,PARK,MDATE,ETC) values ('O005','N','Y','N','N','N','N','N','������, �����, ��Ź��, �δ���, ���ڷ�����, å��, å��, ħ��, ����, �Ź���, ��ũ��');
Insert into HOUSE_OPTION (HCODE,BLTIN,ELEV,PET,VRD,LOAN,PARK,MDATE,ETC) values ('T001','N','Y','N','N','N','N','Y','�����,��Ź��,������,��������,��ũ��,�Ź��屸��');
Insert into HOUSE_OPTION (HCODE,BLTIN,ELEV,PET,VRD,LOAN,PARK,MDATE,ETC) values ('T002','N','Y','Y','N','Y','Y','Y',null);
Insert into HOUSE_OPTION (HCODE,BLTIN,ELEV,PET,VRD,LOAN,PARK,MDATE,ETC) values ('T003','N','Y','N','N','N','N','Y',null);
Insert into HOUSE_OPTION (HCODE,BLTIN,ELEV,PET,VRD,LOAN,PARK,MDATE,ETC) values ('T004','N','N','N','N','N','N','Y','�����, ��Ź��, ��������, ����, �Ź���, ��ũ��');
Insert into HOUSE_OPTION (HCODE,BLTIN,ELEV,PET,VRD,LOAN,PARK,MDATE,ETC) values ('T005','Y','Y','Y','N','N','Y','N','����');
Insert into HOUSE_OPTION (HCODE,BLTIN,ELEV,PET,VRD,LOAN,PARK,MDATE,ETC) values ('F001','N','Y','N','N','N','Y','N','������, �����, ��Ź��, �δ���, å��, ����, �Ź���, ��ũ��, ���ڵ����');
Insert into HOUSE_OPTION (HCODE,BLTIN,ELEV,PET,VRD,LOAN,PARK,MDATE,ETC) values ('F002','Y','Y','N','N','N','N','Y','������, �����, ��Ź��, ����, �Ź���, ���ڵ����');
Insert into HOUSE_OPTION (HCODE,BLTIN,ELEV,PET,VRD,LOAN,PARK,MDATE,ETC) values ('F003','Y','Y','N','N','N','N','N','������, ��Ź��, ����������, å��, ����, ħ��, �Ź���, ���ڵ����');
Insert into HOUSE_OPTION (HCODE,BLTIN,ELEV,PET,VRD,LOAN,PARK,MDATE,ETC) values ('F004','N','Y','N','N','N','N','N','������, ��Ź��, ���ڵ����, �Ź���, �����');
Insert into HOUSE_OPTION (HCODE,BLTIN,ELEV,PET,VRD,LOAN,PARK,MDATE,ETC) values ('F005','Y','Y','N','N','N','Y','Y','������, ��Ź��, ����, ���ڵ����, �Ź���, �����');
Insert into HOUSE_OPTION (HCODE,BLTIN,ELEV,PET,VRD,LOAN,PARK,MDATE,ETC) values ('P001','N','Y','N','Y','N','Y','Y','������, ����������, ����, ���ڵ����, �Ź���, �����');
Insert into HOUSE_OPTION (HCODE,BLTIN,ELEV,PET,VRD,LOAN,PARK,MDATE,ETC) values ('P005','N','Y','Y','Y','Y','Y','Y','��ũ��');
REM INSERTING into HOUSE_PRICE
SET DEFINE OFF;
Insert into HOUSE_PRICE (HCODE,DEPOSIT,MRENT,YRENT,MAINTC,PARKF) values ('P004',1000,95,0,8,0);
Insert into HOUSE_PRICE (HCODE,DEPOSIT,MRENT,YRENT,MAINTC,PARKF) values ('P003',1000,76,0,5,0);
Insert into HOUSE_PRICE (HCODE,DEPOSIT,MRENT,YRENT,MAINTC,PARKF) values ('T005',26000,0,26000,0,5);
Insert into HOUSE_PRICE (HCODE,DEPOSIT,MRENT,YRENT,MAINTC,PARKF) values ('O001',300,40,0,5,0);
Insert into HOUSE_PRICE (HCODE,DEPOSIT,MRENT,YRENT,MAINTC,PARKF) values ('O002',500,352,0,5,0);
Insert into HOUSE_PRICE (HCODE,DEPOSIT,MRENT,YRENT,MAINTC,PARKF) values ('O003',2000,47,0,5,0);
Insert into HOUSE_PRICE (HCODE,DEPOSIT,MRENT,YRENT,MAINTC,PARKF) values ('O004',1000,60,0,5,0);
Insert into HOUSE_PRICE (HCODE,DEPOSIT,MRENT,YRENT,MAINTC,PARKF) values ('O005',1000,55,0,6,0);
Insert into HOUSE_PRICE (HCODE,DEPOSIT,MRENT,YRENT,MAINTC,PARKF) values ('T001',3000,75,0,5,0);
Insert into HOUSE_PRICE (HCODE,DEPOSIT,MRENT,YRENT,MAINTC,PARKF) values ('T002',8000,50,0,0,0);
Insert into HOUSE_PRICE (HCODE,DEPOSIT,MRENT,YRENT,MAINTC,PARKF) values ('T003',1000,130,0,0,0);
Insert into HOUSE_PRICE (HCODE,DEPOSIT,MRENT,YRENT,MAINTC,PARKF) values ('T004',1000,110,0,0,0);
Insert into HOUSE_PRICE (HCODE,DEPOSIT,MRENT,YRENT,MAINTC,PARKF) values ('F001',300,27,0,5,4);
Insert into HOUSE_PRICE (HCODE,DEPOSIT,MRENT,YRENT,MAINTC,PARKF) values ('F002',5000,70,0,9,3);
Insert into HOUSE_PRICE (HCODE,DEPOSIT,MRENT,YRENT,MAINTC,PARKF) values ('F003',1000,80,0,10,5);
Insert into HOUSE_PRICE (HCODE,DEPOSIT,MRENT,YRENT,MAINTC,PARKF) values ('F004',1000,70,0,9,0);
Insert into HOUSE_PRICE (HCODE,DEPOSIT,MRENT,YRENT,MAINTC,PARKF) values ('F005',1000,55,0,7,3);
Insert into HOUSE_PRICE (HCODE,DEPOSIT,MRENT,YRENT,MAINTC,PARKF) values ('P001',1000,80,0,11,0);
Insert into HOUSE_PRICE (HCODE,DEPOSIT,MRENT,YRENT,MAINTC,PARKF) values ('P005',41000,0,41000,0,0);
REM INSERTING into MEMBER
SET DEFINE OFF;
Insert into MEMBER (USERID,PASSWD,SSN,USERNAME,POST,ADDR,PHONE,EMAIL,AGENT) values ('backer','123456','444444-5555555','��Ŀ','06027','���� ������ �б����� 102 (�Ż絿)','01022008965','ss9291@naver.com','N');
Insert into MEMBER (USERID,PASSWD,SSN,USERNAME,POST,ADDR,PHONE,EMAIL,AGENT) values ('wdwgnbl','12345','940021-4255666','����','06134','���� ������ ������� 101 (���ﵿ)','01033568454','heeeee@yahoo.co.kr','Y');
Insert into MEMBER (USERID,PASSWD,SSN,USERNAME,POST,ADDR,PHONE,EMAIL,AGENT) values ('sssss','sssss','9305202459768','��ȿ��','21842','��õ�� ���� ��굿 92-1','01033002810','owldfl@gmail.com','N');
Insert into MEMBER (USERID,PASSWD,SSN,USERNAME,POST,ADDR,PHONE,EMAIL,AGENT) values ('agent3','agent3','777777-7777777','��Ʈ��','01093','���� ���ϱ� ������ 1 (������)','01077777777','agent3@gmail.com','Y');
Insert into MEMBER (USERID,PASSWD,SSN,USERNAME,POST,ADDR,PHONE,EMAIL,AGENT) values ('sabang','1234','123456-9999999','ȿ��','07622','���� ������ ���μ�ȯ�� 5 (���׵�)','01063279654','ss9291@hanmail.net','N');
Insert into MEMBER (USERID,PASSWD,SSN,USERNAME,POST,ADDR,PHONE,EMAIL,AGENT) values ('record5
','recording5','555555-5555556','���ڵ���','06097','���� ������ ������� 403 (�Ｚ��)','01051786193','recording5@yahoo.co.kr','N');
Insert into MEMBER (USERID,PASSWD,SSN,USERNAME,POST,ADDR,PHONE,EMAIL,AGENT) values ('COFFEE','COFFEE','000201-2150252','��Ŀ��','83922','����� ���α� ����2��','01057322201','CAFE@naver.com','N');
Insert into MEMBER (USERID,PASSWD,SSN,USERNAME,POST,ADDR,PHONE,EMAIL,AGENT) values ('agent','agent','999999-9999999','��Ʈ','9999','����','01099999999','agent@agent.com','Y');
Insert into MEMBER (USERID,PASSWD,SSN,USERNAME,POST,ADDR,PHONE,EMAIL,AGENT) values ('JELLY','JELLY','991212-1151252','������','38236','����� ���빮�� ���ﵿ 138-7','01020026600','JELLY@DAUM.NET','N');
Insert into MEMBER (USERID,PASSWD,SSN,USERNAME,POST,ADDR,PHONE,EMAIL,AGENT) values ('pts','aa','123123-1234123','ȫ�浿','06267','���� ������ ������� 238 (���)','01012347895','abcdef123naver.com@','N');
Insert into MEMBER (USERID,PASSWD,SSN,USERNAME,POST,ADDR,PHONE,EMAIL,AGENT) values ('tester3','1234','123412-1234523','�׽��Ϳ�','06267','���� ������ ������� 238 (���)','01015425412','asd123hanmail.net','N');
Insert into MEMBER (USERID,PASSWD,SSN,USERNAME,POST,ADDR,PHONE,EMAIL,AGENT) values ('ssssss','123456','444444-9999999','ȿ��','01226','���� ���ϱ� ��õ�� 833 (����)','01092828454','wlwngl@hanmail.net','N');
Insert into MEMBER (USERID,PASSWD,SSN,USERNAME,POST,ADDR,PHONE,EMAIL,AGENT) values ('recording4','recording4','555555-5555555','���ڵ���','06097','���� ������ ������� 403 (�Ｚ��)','01054786193','recording4@yahoo.co.kr','N');
Insert into MEMBER (USERID,PASSWD,SSN,USERNAME,POST,ADDR,PHONE,EMAIL,AGENT) values ('sssgggg','aaaa','970429-7777777','ȿ��','01226','���� ���ϱ� ��õ�� 833 (����)','01035260679','dwdggvdvd@yahoo.co.kr','Y');
Insert into MEMBER (USERID,PASSWD,SSN,USERNAME,POST,ADDR,PHONE,EMAIL,AGENT) values ('117960284','naver','117960284','���¼�','na','na','117960284','pts4779@naver.com','N');
Insert into MEMBER (USERID,PASSWD,SSN,USERNAME,POST,ADDR,PHONE,EMAIL,AGENT) values ('membertest','testing','930520-2083025','����ȭ','24111','����Ư���� ������ ���ﵿ �������18�� 88','01022822113','test@test.com','N');
Insert into MEMBER (USERID,PASSWD,SSN,USERNAME,POST,ADDR,PHONE,EMAIL,AGENT) values ('qwerty','123456789','965874-2145698','ȿ��','08789','���� ���Ǳ� ������� 2 (��õ��)','01021458965','ss9291@yahoo.co.kr','N');
Insert into MEMBER (USERID,PASSWD,SSN,USERNAME,POST,ADDR,PHONE,EMAIL,AGENT) values ('81660244','naver','81660244','��ȿ��','na','na','81660244','hyojjjj@naver.com','N');
Insert into MEMBER (USERID,PASSWD,SSN,USERNAME,POST,ADDR,PHONE,EMAIL,AGENT) values ('tester4','1234','123212-4532134','�׽�����','06267','���� ������ ������� 238 (���)','01012355478','asd123@naver.com','N');
Insert into MEMBER (USERID,PASSWD,SSN,USERNAME,POST,ADDR,PHONE,EMAIL,AGENT) values ('aaaas','aaaaass','970429-1111111','ȿ��','42663','�뱸 �޼��� ū��� 9 (�η���)','01044448888','ss9291@naver.com','N');
Insert into MEMBER (USERID,PASSWD,SSN,USERNAME,POST,ADDR,PHONE,EMAIL,AGENT) values ('agent2','agent2','888888-8888888','��Ʈ��','01093','���� ���ϱ� ������ 1 (������)','01088888888','agent2@hanmail.net','Y');
Insert into MEMBER (USERID,PASSWD,SSN,USERNAME,POST,ADDR,PHONE,EMAIL,AGENT) values ('wowowow','111111','444444-6666661','��������','06376','���� ������ �帪�� 569 (���)','01033336666','heeeeegg@nate.com','N');
Insert into MEMBER (USERID,PASSWD,SSN,USERNAME,POST,ADDR,PHONE,EMAIL,AGENT) values ('members','members','930520-2111111','����','07622','���� ������ ���μ�ȯ�� 5 (���׵�)','01092822425','mail@hanmail.net','N');
Insert into MEMBER (USERID,PASSWD,SSN,USERNAME,POST,ADDR,PHONE,EMAIL,AGENT) values ('sssssss','123456','960011-4569874','ȿ��','06110','���� ������ �е��� ���� 102 (������)','01078941111','sssssss@yahoo.co.kr','N');
Insert into MEMBER (USERID,PASSWD,SSN,USERNAME,POST,ADDR,PHONE,EMAIL,AGENT) values ('recording1','recording1','900128-2145698','���ڵ���','06267','���� ������ ������� 238 (���)','01037422145','recording1@naver.com','N');
Insert into MEMBER (USERID,PASSWD,SSN,USERNAME,POST,ADDR,PHONE,EMAIL,AGENT) values ('43415424','naver','43415424','������','na','na','43415424','hj.min1031@gmail.com','N');
REM INSERTING into RCNLIST
SET DEFINE OFF;
Insert into RCNLIST (NUM,USERID,HCODE) values (1554804696812,'agent','O001');
Insert into RCNLIST (NUM,USERID,HCODE) values (1554807737708,'agent','O005');
Insert into RCNLIST (NUM,USERID,HCODE) values (1553765104471,'43415424','O002');
Insert into RCNLIST (NUM,USERID,HCODE) values (1553765109806,'43415424','O003');
Insert into RCNLIST (NUM,USERID,HCODE) values (1555489091276,'43415424','P003');
Insert into RCNLIST (NUM,USERID,HCODE) values (1553769601674,'COFFEE','O001');
REM INSERTING into WDMBR
SET DEFINE OFF;
Insert into WDMBR (USERID,DROPTIME) values ('backer',to_date('19/03/11','RR/MM/DD'));
Insert into WDMBR (USERID,DROPTIME) values ('oioioi',to_date('19/03/26','RR/MM/DD'));
Insert into WDMBR (USERID,DROPTIME) values ('backers',to_date('19/03/13','RR/MM/DD'));
Insert into WDMBR (USERID,DROPTIME) values ('tester',to_date('19/03/26','RR/MM/DD'));
Insert into WDMBR (USERID,DROPTIME) values ('test',to_date('19/03/26','RR/MM/DD'));
Insert into WDMBR (USERID,DROPTIME) values ('ssaa',to_date('19/03/26','RR/MM/DD'));
Insert into WDMBR (USERID,DROPTIME) values ('43415424',to_date('19/03/26','RR/MM/DD'));
Insert into WDMBR (USERID,DROPTIME) values ('pringles',to_date('19/03/12','RR/MM/DD'));
Insert into WDMBR (USERID,DROPTIME) values ('kamil',to_date('19/04/09','RR/MM/DD'));
Insert into WDMBR (USERID,DROPTIME) values ('hollys',to_date('19/03/26','RR/MM/DD'));
Insert into WDMBR (USERID,DROPTIME) values ('tteesstt',to_date('19/03/25','RR/MM/DD'));
Insert into WDMBR (USERID,DROPTIME) values ('ababab',to_date('19/03/26','RR/MM/DD'));
Insert into WDMBR (USERID,DROPTIME) values ('membersss',to_date('19/03/26','RR/MM/DD'));
Insert into WDMBR (USERID,DROPTIME) values ('recording',to_date('19/03/28','RR/MM/DD'));
Insert into WDMBR (USERID,DROPTIME) values ('recording3',to_date('19/03/28','RR/MM/DD'));
REM INSERTING into WISHLIST
SET DEFINE OFF;
Insert into WISHLIST (USERID,HCODE) values ('pts','O003');
Insert into WISHLIST (USERID,HCODE) values ('COFFEE','P003');
Insert into WISHLIST (USERID,HCODE) values ('COFFEE','O001');
Insert into WISHLIST (USERID,HCODE) values ('COFFEE','O003');
--------------------------------------------------------
--  DDL for Index PK_MEM_ID
--------------------------------------------------------

  CREATE UNIQUE INDEX "PK_MEM_ID" ON "MEMBER" ("USERID") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS" ;
--------------------------------------------------------
--  DDL for Index SYS_C0013093
--------------------------------------------------------

  CREATE UNIQUE INDEX "SYS_C0013093" ON "RCNLIST" ("NUM") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS" ;
--------------------------------------------------------
--  DDL for Index PK_HDT_CD
--------------------------------------------------------

  CREATE UNIQUE INDEX "PK_HDT_CD" ON "HOUSE_INFO" ("HCODE") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS" ;
--------------------------------------------------------
--  Constraints for Table MEMBER
--------------------------------------------------------

  ALTER TABLE "MEMBER" ADD CONSTRAINT "PK_MEM_ID" PRIMARY KEY ("USERID")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS"  ENABLE;
 
  ALTER TABLE "MEMBER" MODIFY ("PASSWD" NOT NULL ENABLE);
 
  ALTER TABLE "MEMBER" MODIFY ("SSN" NOT NULL ENABLE);
 
  ALTER TABLE "MEMBER" MODIFY ("USERNAME" NOT NULL ENABLE);
 
  ALTER TABLE "MEMBER" MODIFY ("POST" NOT NULL ENABLE);
 
  ALTER TABLE "MEMBER" MODIFY ("ADDR" NOT NULL ENABLE);
 
  ALTER TABLE "MEMBER" MODIFY ("PHONE" NOT NULL ENABLE);
 
  ALTER TABLE "MEMBER" MODIFY ("EMAIL" NOT NULL ENABLE);
 
  ALTER TABLE "MEMBER" ADD UNIQUE ("SSN")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS"  ENABLE;
 
  ALTER TABLE "MEMBER" ADD UNIQUE ("PHONE")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS"  ENABLE;
--------------------------------------------------------
--  Constraints for Table WDMBR
--------------------------------------------------------

  ALTER TABLE "WDMBR" ADD PRIMARY KEY ("USERID")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS"  ENABLE;
--------------------------------------------------------
--  Constraints for Table HOUSE_OPTION
--------------------------------------------------------

  ALTER TABLE "HOUSE_OPTION" MODIFY ("BLTIN" NOT NULL ENABLE);
 
  ALTER TABLE "HOUSE_OPTION" MODIFY ("ELEV" NOT NULL ENABLE);
 
  ALTER TABLE "HOUSE_OPTION" MODIFY ("PET" NOT NULL ENABLE);
 
  ALTER TABLE "HOUSE_OPTION" MODIFY ("VRD" NOT NULL ENABLE);
 
  ALTER TABLE "HOUSE_OPTION" MODIFY ("LOAN" NOT NULL ENABLE);
 
  ALTER TABLE "HOUSE_OPTION" MODIFY ("PARK" NOT NULL ENABLE);
 
  ALTER TABLE "HOUSE_OPTION" MODIFY ("MDATE" NOT NULL ENABLE);
 
  ALTER TABLE "HOUSE_OPTION" ADD CHECK (bltin in ('Y','N')) ENABLE;
 
  ALTER TABLE "HOUSE_OPTION" ADD CHECK (elev in ('Y','N')) ENABLE;
 
  ALTER TABLE "HOUSE_OPTION" ADD CHECK (pet in ('Y','N')) ENABLE;
 
  ALTER TABLE "HOUSE_OPTION" ADD CHECK (vrd in ('Y','N')) ENABLE;
 
  ALTER TABLE "HOUSE_OPTION" ADD CHECK (loan in ('Y','N')) ENABLE;
 
  ALTER TABLE "HOUSE_OPTION" ADD CHECK (park in ('Y','N')) ENABLE;
 
  ALTER TABLE "HOUSE_OPTION" ADD CHECK (mdate in ('Y','N')) ENABLE;
--------------------------------------------------------
--  Constraints for Table RCNLIST
--------------------------------------------------------

  ALTER TABLE "RCNLIST" MODIFY ("HCODE" NOT NULL ENABLE);
 
  ALTER TABLE "RCNLIST" ADD PRIMARY KEY ("NUM")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS"  ENABLE;
--------------------------------------------------------
--  Constraints for Table BOARD
--------------------------------------------------------

  ALTER TABLE "BOARD" MODIFY ("PPWD" NOT NULL ENABLE);
 
  ALTER TABLE "BOARD" MODIFY ("USERID" NOT NULL ENABLE);
 
  ALTER TABLE "BOARD" MODIFY ("TITLE" NOT NULL ENABLE);
 
  ALTER TABLE "BOARD" MODIFY ("CONTENT" NOT NULL ENABLE);
 
  ALTER TABLE "BOARD" ADD PRIMARY KEY ("PCODE")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS"  ENABLE;
--------------------------------------------------------
--  Constraints for Table HOUSE_PRICE
--------------------------------------------------------

  ALTER TABLE "HOUSE_PRICE" MODIFY ("MAINTC" NOT NULL ENABLE);
 
  ALTER TABLE "HOUSE_PRICE" MODIFY ("PARKF" NOT NULL ENABLE);
--------------------------------------------------------
--  Constraints for Table WISHLIST
--------------------------------------------------------

  ALTER TABLE "WISHLIST" MODIFY ("HCODE" NOT NULL ENABLE);
--------------------------------------------------------
--  Constraints for Table HOUSE_INFO
--------------------------------------------------------

  ALTER TABLE "HOUSE_INFO" ADD CONSTRAINT "PK_HDT_CD" PRIMARY KEY ("HCODE")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS"  ENABLE;
 
  ALTER TABLE "HOUSE_INFO" MODIFY ("HTYPE" NOT NULL ENABLE);
 
  ALTER TABLE "HOUSE_INFO" MODIFY ("RTYPE" NOT NULL ENABLE);
 
  ALTER TABLE "HOUSE_INFO" MODIFY ("HNAME" NOT NULL ENABLE);
 
  ALTER TABLE "HOUSE_INFO" MODIFY ("ADDR" NOT NULL ENABLE);
 
  ALTER TABLE "HOUSE_INFO" MODIFY ("AREA" NOT NULL ENABLE);
 
  ALTER TABLE "HOUSE_INFO" MODIFY ("FLR" NOT NULL ENABLE);
 
  ALTER TABLE "HOUSE_INFO" MODIFY ("ROOM" NOT NULL ENABLE);
 
  ALTER TABLE "HOUSE_INFO" MODIFY ("BATR" NOT NULL ENABLE);
 
  ALTER TABLE "HOUSE_INFO" ADD CHECK (htype in ('o','t','f','p')) ENABLE;
--------------------------------------------------------
--  Ref Constraints for Table BOARD
--------------------------------------------------------

  ALTER TABLE "BOARD" ADD CONSTRAINT "BOARD_HCODE_FK" FOREIGN KEY ("HCODE")
	  REFERENCES "HOUSE_INFO" ("HCODE") ON DELETE CASCADE ENABLE;
 
  ALTER TABLE "BOARD" ADD CONSTRAINT "FK_BRD_ID" FOREIGN KEY ("USERID")
	  REFERENCES "MEMBER" ("USERID") ON DELETE CASCADE ENABLE;
--------------------------------------------------------
--  Ref Constraints for Table HOUSE_INFO
--------------------------------------------------------

  ALTER TABLE "HOUSE_INFO" ADD CONSTRAINT "HOUSE_INFO_AGNTID" FOREIGN KEY ("AGNTID")
	  REFERENCES "MEMBER" ("USERID") ON DELETE CASCADE ENABLE;
--------------------------------------------------------
--  Ref Constraints for Table HOUSE_OPTION
--------------------------------------------------------

  ALTER TABLE "HOUSE_OPTION" ADD CONSTRAINT "HOUSE_OPTION_HCODE_FK" FOREIGN KEY ("HCODE")
	  REFERENCES "HOUSE_INFO" ("HCODE") ON DELETE CASCADE ENABLE;
--------------------------------------------------------
--  Ref Constraints for Table HOUSE_PRICE
--------------------------------------------------------

  ALTER TABLE "HOUSE_PRICE" ADD CONSTRAINT "HOUSE_PRICE_HCODE_FK" FOREIGN KEY ("HCODE")
	  REFERENCES "HOUSE_INFO" ("HCODE") ON DELETE CASCADE ENABLE;
--------------------------------------------------------
--  Ref Constraints for Table RCNLIST
--------------------------------------------------------

  ALTER TABLE "RCNLIST" ADD CONSTRAINT "RCNLIST_HCODE_FK" FOREIGN KEY ("HCODE")
	  REFERENCES "HOUSE_INFO" ("HCODE") ON DELETE CASCADE ENABLE;
 
  ALTER TABLE "RCNLIST" ADD CONSTRAINT "RCNLIST_USERID_FK" FOREIGN KEY ("USERID")
	  REFERENCES "MEMBER" ("USERID") ON DELETE CASCADE ENABLE;
--------------------------------------------------------
--  Ref Constraints for Table WISHLIST
--------------------------------------------------------

  ALTER TABLE "WISHLIST" ADD CONSTRAINT "WISHLIST_HCODE_FK" FOREIGN KEY ("HCODE")
	  REFERENCES "HOUSE_INFO" ("HCODE") ON DELETE CASCADE ENABLE;
 
  ALTER TABLE "WISHLIST" ADD CONSTRAINT "WISHLIST_USERID_FK" FOREIGN KEY ("USERID")
	  REFERENCES "MEMBER" ("USERID") ON DELETE CASCADE ENABLE;
