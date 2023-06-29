https://www.ibm.com/docs/en/maximo-manage/8.3.0?topic=deployment-configuring-oracle-database



```
4.  Create a table space

Create tablespace maxdata datafile 
'C:\oracle\product\12.1.0.1\db_1\dbs\maxdata.dbf' 
size 1000M autoextend on;

5. Create a temporary table space

create temporary tablespace maxtemp tempfile  
'C:\oracle\product\12.1.0.1\db_1\dbs\maxtemp.dbf'
size 1000M autoextend on maxsize unlimited;

6. Create the Maximo user and grant permissions

create user maximo identified by maximo default tablespace maxdata temporary 
tablespace maxtemp;
grant connect to maximo;
grant create job to maximo;
grant create trigger to maximo;
grant create session to maximo;
grant create sequence to maximo;
grant create synonym to maximo;
grant create table to maximo;
grant create view to maximo;
grant create procedure to maximo;
grant alter session to maximo;
grant execute on ctxsys.ctx_ddl to maximo;
alter user maximo quota unlimited on maxdata;

# Grant access to that index table space to the Maximo user

alter user maximo quota unlimited on TSI_MAM_OWN

7. Create an Oracle preference arbitrary

begin
ctx_ddl.create_preference('MAXIMO_STORAGE', 'BASIC_STORAGE');
ctx_ddl.set_attribute('MAXIMO_STORAGE', 'I_TABLE_CLAUSE',
'tablespace MAXDATA LOB(token_info) store as (tablespace MAXLOBS
enable storage in row)');
ctx_ddl.set_attribute('MAXIMO_STORAGE', 'I_INDEX_CLAUSE',
'tablespace MAXINDX compress 2');
ctx_ddl.set_attribute('MAXIMO_STORAGE', 'K_TABLE_CLAUSE',
'tablespace MAXINDX');
ctx_ddl.set_attribute('MAXIMO_STORAGE', 'R_TABLE_CLAUSE',
'tablespace MAXDATA LOB(data) store as (tablespace MAXLOBS
cache)');
ctx_ddl.set_attribute('MAXIMO_STORAGE', 'N_TABLE_CLAUSE',
'tablespace MAXINDX');
end;


create  index pm_ndx6 on pm (description) indextype is
ctxsys.context parameters ('lexer global_lexer language column
LANGCODE storage MAXIMO_STORAGE');


8. grant  select_catalog_role role

grant select_catalog_role to maximo
```
