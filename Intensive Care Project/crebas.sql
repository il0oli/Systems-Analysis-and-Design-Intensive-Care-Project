/*==============================================================*/
/* DBMS name:      Sybase SQL Anywhere 11                       */
/* Created on:     10/12/2023 9:54:32 AM                        */
/*==============================================================*/


if exists(select 1 from sys.sysforeignkey where role='FK_ACCOUNT__HAS2_PATIENT') then
    alter table account_trans
       delete foreign key FK_ACCOUNT__HAS2_PATIENT
end if;

if exists(select 1 from sys.sysforeignkey where role='FK_HAVE_HAVE_MEDICINE') then
    alter table have
       delete foreign key FK_HAVE_HAVE_MEDICINE
end if;

if exists(select 1 from sys.sysforeignkey where role='FK_HAVE_HAVE2_PATIENT') then
    alter table have
       delete foreign key FK_HAVE_HAVE2_PATIENT
end if;

if exists(select 1 from sys.sysforeignkey where role='FK_ITEMS_OWNE_MEDICINE') then
    alter table items
       delete foreign key FK_ITEMS_OWNE_MEDICINE
end if;

if exists(select 1 from sys.sysforeignkey where role='FK_PATIENT_HAS_ACCOUNT_') then
    alter table patient
       delete foreign key FK_PATIENT_HAS_ACCOUNT_
end if;

if exists(
   select 1 from sys.sysindex i, sys.systable t
   where i.table_id=t.table_id 
     and i.index_name='HAS2_FK'
     and t.table_name='account_trans'
) then
   drop index account_trans.HAS2_FK
end if;

if exists(
   select 1 from sys.sysindex i, sys.systable t
   where i.table_id=t.table_id 
     and i.index_name='ACCOUNT_TRANS_PK'
     and t.table_name='account_trans'
) then
   drop index account_trans.ACCOUNT_TRANS_PK
end if;

if exists(
   select 1 from sys.systable 
   where table_name='account_trans'
     and table_type in ('BASE', 'GBL TEMP')
) then
    drop table account_trans
end if;

if exists(
   select 1 from sys.sysindex i, sys.systable t
   where i.table_id=t.table_id 
     and i.index_name='HAVE_FK'
     and t.table_name='have'
) then
   drop index have.HAVE_FK
end if;

if exists(
   select 1 from sys.sysindex i, sys.systable t
   where i.table_id=t.table_id 
     and i.index_name='HAVE2_FK'
     and t.table_name='have'
) then
   drop index have.HAVE2_FK
end if;

if exists(
   select 1 from sys.sysindex i, sys.systable t
   where i.table_id=t.table_id 
     and i.index_name='HAVE_PK'
     and t.table_name='have'
) then
   drop index have.HAVE_PK
end if;

if exists(
   select 1 from sys.systable 
   where table_name='have'
     and table_type in ('BASE', 'GBL TEMP')
) then
    drop table have
end if;

if exists(
   select 1 from sys.sysindex i, sys.systable t
   where i.table_id=t.table_id 
     and i.index_name='OWNE_FK'
     and t.table_name='items'
) then
   drop index items.OWNE_FK
end if;

if exists(
   select 1 from sys.sysindex i, sys.systable t
   where i.table_id=t.table_id 
     and i.index_name='ITEMS_PK'
     and t.table_name='items'
) then
   drop index items.ITEMS_PK
end if;

if exists(
   select 1 from sys.systable 
   where table_name='items'
     and table_type in ('BASE', 'GBL TEMP')
) then
    drop table items
end if;

if exists(
   select 1 from sys.sysindex i, sys.systable t
   where i.table_id=t.table_id 
     and i.index_name='MEDICINE_PK'
     and t.table_name='medicine'
) then
   drop index medicine.MEDICINE_PK
end if;

if exists(
   select 1 from sys.systable 
   where table_name='medicine'
     and table_type in ('BASE', 'GBL TEMP')
) then
    drop table medicine
end if;

if exists(
   select 1 from sys.sysindex i, sys.systable t
   where i.table_id=t.table_id 
     and i.index_name='HAS_FK'
     and t.table_name='patient'
) then
   drop index patient.HAS_FK
end if;

if exists(
   select 1 from sys.sysindex i, sys.systable t
   where i.table_id=t.table_id 
     and i.index_name='PATIENT_PK'
     and t.table_name='patient'
) then
   drop index patient.PATIENT_PK
end if;

if exists(
   select 1 from sys.systable 
   where table_name='patient'
     and table_type in ('BASE', 'GBL TEMP')
) then
    drop table patient
end if;

/*==============================================================*/
/* Table: account_trans                                         */
/*==============================================================*/
create table account_trans 
(
   trans_id             integer                        not null,
   patient_id           integer                        not null,
   trans_name           smallint                       not null,
   constraint PK_ACCOUNT_TRANS primary key (trans_id)
);

/*==============================================================*/
/* Index: ACCOUNT_TRANS_PK                                      */
/*==============================================================*/
create unique index ACCOUNT_TRANS_PK on account_trans (
trans_id ASC
);

/*==============================================================*/
/* Index: HAS2_FK                                               */
/*==============================================================*/
create index HAS2_FK on account_trans (
patient_id ASC
);

/*==============================================================*/
/* Table: have                                                  */
/*==============================================================*/
create table have 
(
   medicine_id          integer                        not null,
   patient_id           integer                        not null,
   constraint PK_HAVE primary key (medicine_id, patient_id)
);

/*==============================================================*/
/* Index: HAVE_PK                                               */
/*==============================================================*/
create unique index HAVE_PK on have (
medicine_id ASC,
patient_id ASC
);

/*==============================================================*/
/* Index: HAVE2_FK                                              */
/*==============================================================*/
create index HAVE2_FK on have (
patient_id ASC
);

/*==============================================================*/
/* Index: HAVE_FK                                               */
/*==============================================================*/
create index HAVE_FK on have (
medicine_id ASC
);

/*==============================================================*/
/* Table: items                                                 */
/*==============================================================*/
create table items 
(
   item_id              integer                        not null,
   medicine_id          integer                        not null,
   item_name            char(50)                       not null,
   company_name         char(150)                      not null,
   constraint PK_ITEMS primary key (item_id)
);

/*==============================================================*/
/* Index: ITEMS_PK                                              */
/*==============================================================*/
create unique index ITEMS_PK on items (
item_id ASC
);

/*==============================================================*/
/* Index: OWNE_FK                                               */
/*==============================================================*/
create index OWNE_FK on items (
medicine_id ASC
);

/*==============================================================*/
/* Table: medicine                                              */
/*==============================================================*/
create table medicine 
(
   medicine_id          integer                        not null,
   medicine_name        char(50)                       not null,
   price                decimal(8,2)                   not null,
   note                 char(256)                      null,
   constraint PK_MEDICINE primary key (medicine_id)
);

/*==============================================================*/
/* Index: MEDICINE_PK                                           */
/*==============================================================*/
create unique index MEDICINE_PK on medicine (
medicine_id ASC
);

/*==============================================================*/
/* Table: patient                                               */
/*==============================================================*/
create table patient 
(
   patient_id           integer                        not null,
   trans_id             integer                        null,
   account_id           integer                        not null,
   patient_name         char(20)                       not null,
   age                  integer                        not null,
   gender               smallint                       null,
   phone                integer                        not null,
   address              char(150)                      null,
   constraint PK_PATIENT primary key (patient_id)
);

/*==============================================================*/
/* Index: PATIENT_PK                                            */
/*==============================================================*/
create unique index PATIENT_PK on patient (
patient_id ASC
);

/*==============================================================*/
/* Index: HAS_FK                                                */
/*==============================================================*/
create index HAS_FK on patient (
trans_id ASC
);

alter table account_trans
   add constraint FK_ACCOUNT__HAS2_PATIENT foreign key (patient_id)
      references patient (patient_id)
      on update restrict
      on delete restrict;

alter table have
   add constraint FK_HAVE_HAVE_MEDICINE foreign key (medicine_id)
      references medicine (medicine_id)
      on update restrict
      on delete restrict;

alter table have
   add constraint FK_HAVE_HAVE2_PATIENT foreign key (patient_id)
      references patient (patient_id)
      on update restrict
      on delete restrict;

alter table items
   add constraint FK_ITEMS_OWNE_MEDICINE foreign key (medicine_id)
      references medicine (medicine_id)
      on update restrict
      on delete restrict;

alter table patient
   add constraint FK_PATIENT_HAS_ACCOUNT_ foreign key (trans_id)
      references account_trans (trans_id)
      on update restrict
      on delete restrict;

